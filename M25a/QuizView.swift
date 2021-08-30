//
//  QuizView.swift
//  QuizView
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct QuizView: View {

  @ObservedObject var quiz: Quiz

  var body: some View {
    Group {
      switch quiz.state {
      case .start:
        VStack {
          QuizStartView(title: quiz.title, questionCount: quiz.questions.count)
          if !quiz.questions.isEmpty {
            Button("Start") {
              quiz.questions = quiz.questions.shuffled()
              quiz.state = .askQuestion(0)
            }

          }
        }
      case .askQuestion(let index):
        QuestionView(started: Date(),
                     questionNumber: index+1,
                     totalQuestionCount: quiz.questions.count,
                     question: quiz.questions[index]) { grade in
          quiz.grades.append(grade)
          quiz.state = .reviewResponse(index, grade)
        }
      case .reviewResponse(let index, let grade):
        VStack {
          ReviewResponseView(questionNumber: index+1,
                             totalQuestionCount: quiz.questions.count,
                             grade: grade)
          Button("Next") {
            let next = index+1
            quiz.state = quiz.questions.indices.contains(next) ?
              .askQuestion(next) : .summary
          }

        }
      case .summary:
        VStack {
          QuizSummaryView(grades: quiz.grades)
          Button("Retake") {
            quiz.state = .start
          }
        }
      }
    }.buttonStyle(BlueButton())
  }
}

struct QuizView_Previews: PreviewProvider {
  static let quiz = Quiz(title: "16",
                         questions: (12...25).map {
    MultiplicationQuestion(a: 16, b: $0)
  }.shuffled())

  static var previews: some View {
    QuizView(quiz: quiz)
      .previewDevice("iPhone 11 Pro Max")
  }
}
