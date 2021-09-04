//
//  QuizSummaryView.swift
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct QuizSummaryView: View {

  let model: QuizSummaryViewModel

  var body: some View {
    List {
      Section(header: Text("Statistics")) {
        HStack { Text("Accuracy")
          Spacer()
          Text("\(model.percentAccuracy)%")
        }
        HStack { Text("Median Time");
          Spacer();
          Text("\(model.medianTime)")
        }
      }
      if model.hasIncorrectResponses {
        Section(header: Text("Incorrect Responses")) {
          ForEach(Array(model.incorrectResponses.enumerated()), id: \.0) { (offset, grade) in
            HStack {
              Label(grade.question.questionAndAnswer, systemImage: "nosign")
                .accentColor(.red)
              Spacer()
              Text(grade.response).strikethrough(color: .red)
            }
          }
        }
      }

      if model.hasSlowCorrectResponses {
        Section(header: Text("Slow Responses")) {
          ForEach(Array(model.slowCorrectSorted.enumerated()), id: \.0) { (offset, grade) in
            HStack {
              Label(grade.question.questionAndAnswer, systemImage: "tortoise")
              Spacer()
              Text(String(format: "%3.1f s", grade.responseTime))
                .font(.footnote)
            }
          }
        }
      }

      if model.hasCorrectResponses {
        Section(header: Text("Correct Responses")) {
          ForEach(Array(model.correctResponses.enumerated()), id: \.0) { (offset, grade) in
            Label(grade.question.questionAndAnswer, systemImage: "checkmark")
              .accentColor(.green)
          }
        }
      }
    }
    .navigationTitle("Quiz Results")
  }
}

struct Summary_Previews: PreviewProvider {

  static var grades: [Grade] {
    [.init(question: MultiplicationQuestion(a: 10, b: 10),
           shown: Date(),
           responseTime: 3, response: "100"),
     .init(question: MultiplicationQuestion(a: 11, b: 11),
           shown: Date(),
           responseTime: 10, response: "121"),
     .init(question: MultiplicationQuestion(a: 12, b: 12),
           shown: Date(),
           responseTime: 2, response: "143"),
     .init(question: MultiplicationQuestion(a: 12, b: 12),
           shown: Date(),
           responseTime: 2, response: "143"),
     .init(question: MultiplicationQuestion(a: 12, b: 12),
           shown: Date(),
           responseTime: 2, response: "143"),
     .init(question: MultiplicationQuestion(a: 12, b: 12),
           shown: Date(),
           responseTime: 2, response: "143"),
     .init(question: MultiplicationQuestion(a: 12, b: 12),
           shown: Date(),
           responseTime: 2, response: "143"),
     .init(question: MultiplicationQuestion(a: 12, b: 12),
           shown: Date(),
           responseTime: 2, response: "143"),
    ]
  }

  static var previews: some View {
    NavigationView {
      QuizSummaryView(model: QuizSummaryViewModel(grades: grades))
        .padding()
    }
  }
}
