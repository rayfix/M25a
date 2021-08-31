//
//  ViewModel.swift
//
//  Created by Ray Fix on 8/29/21.
//

import Foundation

final class QuizViewModel: ObservableObject {

  enum State {
    case idle
    case ready(Quiz)
    case ask(Progress, Question)
    case review(Progress, Grade)
    case summary([Grade])
  }

  private(set) var quiz: Quiz?
  private var questions: [Question] = []
  private var grades: [Grade] = []
  @Published private(set) var state: State = .idle

  var isIdle: Bool {
    switch state {
    case .idle:
      return true
    case _:
      return false
    }
  }

  func ready(quiz: Quiz) {
    self.quiz = quiz
    state = .ready(quiz)
  }

  func start(shuffle: Bool = true) {
    guard let quiz = quiz else {
      return
    }
    questions = shuffle ? quiz.questions.shuffled() : quiz.questions
    grades = []
    if let progress = Progress(index: 0, count: questions.count) {
      state = .ask(progress, questions[0])
    }
  }

  func review(grade: Grade) {
    if case let .ask(progress, _) = state {
      grades.append(grade)
      state = .review(progress, grade)
    }
  }

  func next() {
    if case let .review(progress, _) = state {

      guard let nextProgress = progress.next() else {
        state = .summary(grades)
        return
      }
      state = .ask(nextProgress, questions[nextProgress.index])
    }
  }

  var canSummarize: Bool {
    guard !grades.isEmpty else { return false }
    if case .summary = state {
      return false
    }
    return true
  }


  func summarize() {
    state = .summary(grades)
  }

  func reset() {
    state = .idle
    questions = []
    grades = []
  }

  var hasGrades: Bool {
    !grades.isEmpty
  }

}

