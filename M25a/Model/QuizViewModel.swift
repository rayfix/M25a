//
//  ViewModel.swift
//
//  Created by Ray Fix on 8/29/21.
//

import Foundation

final class QuizViewModel: ObservableObject {
  init(quizzes: [Quiz]) {
    self.stateMachine = QuizStateMachine(quizzes: quizzes)
  }

  @Published private(set) var stateMachine: QuizStateMachine

  var state: QuizStateMachine.State { stateMachine.state }

  var navigationTitle: String { stateMachine.quiz.map { "Quiz \($0.title)" } ?? "M25 Quiz List" }

  func select(quiz: Quiz) { stateMachine.select(quiz: quiz) }

  func startTapped(shuffle: Bool = true) {
    stateMachine.startQuiz(shuffle: shuffle, count: nil)
  }

  func review(grade: Grade) {
    stateMachine.review(grade: grade)
  }

  func nextTapped() {
    stateMachine.nextQuestion()
  }

  func endTapped() {
    stateMachine.summarize()
  }

  var canEnd: Bool {
    switch state {
    case .summary:
      return true
    case _:
      return stateMachine.quiz != nil
    }

  }
}

