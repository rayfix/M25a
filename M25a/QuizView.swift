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
      case .begin:
        VStack {
          QuizStartView(quiz: model.quiz)
          if !model.quiz.questions.isEmpty {
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
        VStack {
          QuizSummaryView(grades: grades)
            .padding()
          Button("Retake") {
            model.reset()
          }
        }
      }
    }
    .navigationTitle("Quiz \(model.quiz.title)")
    .buttonStyle(BlueButton())
  }
}

struct QuizView_Previews: PreviewProvider {
  static let quiz = Quiz(title: "16",
                         details: "Cool thing",
                         questions: (12...25).map {
    MultiplicationQuestion(a: 16, b: $0)
  }.shuffled())

  static var previews: some View {
    QuizView(model: QuizViewModel(quiz: quiz))
      .previewDevice("iPhone 11 Pro Max")
  }
}
