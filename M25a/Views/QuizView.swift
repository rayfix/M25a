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
      case .selecting(let quizzes):
        QuizSelectionView(quizzes: quizzes) { quiz in
          model.select(quiz: quiz)
        }

      case .prepare(let quiz):
        VStack {
          QuizStartView(quiz: quiz)
          if !quiz.templates.isEmpty {
            Button("Start") {
              model.startTapped()
            }
          }
        }

      case let .ask(progress,question):
        VStack {
          QuestionView(started: Date(),
                       progress: progress,
                       question: question) { grade in
            model.review(grade: grade)
          }
          Color.clear
        }
      case let .review(progress, grade):
        VStack {
          ReviewResponseView(progress: progress, grade: grade)
          Button("Next") {
            model.nextTapped()
          }
          Spacer()
        }
      case .summary(let grades):
        QuizSummaryView(model: QuizSummaryViewModel(grades: grades))
          .padding()
      }
    }
    .buttonStyle(BorderedButton())
  }
}

struct QuizView_Previews: PreviewProvider {
  static let quiz = Quiz(title: "16",
                         details: "Cool thing",
                         templates: (12...25).map {
    MultiplicationQuestionTemplate(16, $0)
  }.shuffled())

  static let model: QuizViewModel = QuizViewModel(quizzes: [quiz])

  static var previews: some View {
    QuizView(model: Self.model)
      .previewDevice("iPhone 11 Pro Max")
  }
}
