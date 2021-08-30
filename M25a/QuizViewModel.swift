//
//  ViewModel.swift
//
//  Created by Ray Fix on 8/29/21.
//

import Foundation

final class QuizViewModel: ObservableObject {

  enum State {
    case begin
    case ask(Progress, Question)
    case review(Progress, Grade)
    case summary([Grade])
  }

  let quiz: Quiz
  private var questions: [Question] = []
  private var grades: [Grade] = []
  @Published private(set) var state: State = .begin

  init(quiz: Quiz) {
    self.quiz = quiz
  }

  func start(shuffle: Bool = true) {
    guard !quiz.questions.isEmpty else { return }
    questions = shuffle ? quiz.questions.shuffled() : quiz.questions
    grades = []
    let progress = Progress(index: 0, questionCount: questions.count)
    state = .ask(progress, questions[0])
  }

  func review(grade: Grade) {
    if case let .ask(progress, _) = state {
      grades.append(grade)
      state = .review(progress, grade)
    }
  }

  func next() {
    if case let .review(progress, _) = state {
      let nextIndex = progress.index + 1
      guard nextIndex < progress.questionCount else {
        state = .summary(grades)
        return
      }
      state = .ask(Progress(index: nextIndex, questionCount: progress.questionCount),
                   questions[nextIndex])
    }
  }

  func summarize() {
    state = .summary(grades)
  }

  func reset() {
    state = .begin
    questions = []
    grades = []
  }
}

