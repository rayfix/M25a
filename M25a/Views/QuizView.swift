//
//  QuizView.swift
//  QuizView
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct QuizView: View {

  @ObservedObject var model: QuizViewModel

  var body: some View {
    Group {
      switch model.state {
      case .idle:
        EmptyView()
      case .ready(let quiz):
        VStack {
          QuizStartView(quiz: quiz)
          if !quiz.questions.isEmpty {
            Button("Start") {
              model.start()
            }
          }
        }
      case let .ask(progress,question):
        QuestionView(started: Date(),
                     progress: progress,
                     question: question) { grade in
          model.review(grade: grade)
        }
      case let .review(progress, grade):
        VStack {
          ReviewResponseView(progress: progress,
                             grade: grade)
          Button("Next") {
            model.next()
          }

        }
      case .summary(let grades):
        QuizSummaryView(grades: grades)
          .padding()
      }
    }
    .navigationTitle("Quiz \(model.quiz?.title ?? "")")
    .buttonStyle(BorderedButton())
  }
}

struct QuizView_Previews: PreviewProvider {
  static let quiz = Quiz(title: "16",
                         details: "Cool thing",
                         questions: (12...25).map {
    MultiplicationQuestion(a: 16, b: $0)
  }.shuffled())

  static let model: QuizViewModel = QuizViewModel()

  static var previews: some View {
    QuizView(model: Self.model)
      .previewDevice("iPhone 11 Pro Max")
  }
}
