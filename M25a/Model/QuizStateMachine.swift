//
//  QuizStateMachine.swift
//  QuizStateMachine
//
//  Created by Ray Fix on 9/3/21.
//

import Foundation

struct QuizStateMachine {
  enum State {
    case selecting([Quiz])
    case prepare(Quiz)
    case ask(Progress, Question)
    case review(Progress, Grade)
    case summary([Grade])
  }

  private(set) var state: State

  // All of the quizzes and the selected quiz
  private(set) var quizzes: [Quiz]
  private(set) var quiz: Quiz?

  // Randomized questions pulled from the quiz
  private var questions: [Question] = []

  // User generated responses
  private var grades: [Grade] = []


  init(quizzes: [Quiz]) {
    self.quizzes = quizzes
    self.state = .selecting(quizzes)
  }

  mutating func select(quiz: Quiz) {
    self.quiz = quiz
    state = .prepare(quiz)
  }

  mutating func startQuiz(shuffle: Bool = true, count: Int?) {
    guard let quiz = quiz else {
      state = .selecting(quizzes)
      return
    }

    questions = quiz.prepareQuestions(shuffle: shuffle, count: count)

    guard !questions.isEmpty else {
      state = .selecting(quizzes)
      return
    }

    if let progress = Progress(index: 0, count: questions.count) {
      grades = []
      state = .ask(progress, questions[0])
    }
  }

  mutating func review(grade: Grade) {
    if case let .ask(progress, _) = state {
      grades.append(grade)
      state = .review(progress, grade)
    }
  }

  private var hasGrades: Bool {
    !grades.isEmpty
  }

  mutating func nextQuestion() {
    if case let .review(progress, _) = state {

      guard let nextProgress = progress.next() else {
        state = .summary(grades)
        return
      }
      state = .ask(nextProgress, questions[nextProgress.index])
    }
  }

  mutating func summarize() {
    state = hasGrades ? .summary(grades) : .selecting(quizzes)
    quiz = nil
    grades = []
  }
}
