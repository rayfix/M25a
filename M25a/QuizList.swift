//
//  QuestionListView.swift
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct QuizListView: View {
  let quizzes = MultiplicationQuestion.quizzes()

  var body: some View {
    List(Array(quizzes.enumerated()), id: \.offset) { offset, quiz in
      NavigationLink(destination: QuizView(model: QuizViewModel(quiz: quiz))) {
        Label("Quiz \(quiz.title)", systemImage: "doc.text")
      }
    }.navigationTitle("M25 Quiz List")
  }
}

