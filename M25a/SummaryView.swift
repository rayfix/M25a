//
//  SummaryView.swift
//  SummaryView
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct QuizSummaryView: View {
  let grades: [Grade]

  var percentAccuracy: String {
    let fraction =  Double(grades.lazy.filter {$0.isCorrect}.count) / Double(grades.count)
    return String(format: "%3.1f", fraction * 100)
  }

  var medianTime: String {
    let times = grades.sorted { $0.responseTime < $1.responseTime }.map(\.responseTime)
    return String(format: "%3.1f seconds", times[times.count/2])
  }

  var slowSorted: [Grade] {
    grades
      .filter { $0.isSlow }
      .sorted { $0.responseTime > $1.responseTime }
  }


  var body: some View {
    VStack(alignment: .leading) {
      Text("Accuracy: \(percentAccuracy)%")
      Text("Median Time: \(medianTime)")
      if !grades.lazy.filter {!$0.isCorrect}.isEmpty {
        Section {
          Text("Incorrect Responses")
          List(Array(grades.filter {!$0.isCorrect} .enumerated()), id: \.0) { (offset, grade) in
            HStack {
              Image(systemName: "nosign")
              Text(grade.question.questionAndAnswer)
              Spacer()
              Text(grade.response).font(.footnote)
                  .overlay(Text("--").foregroundColor(.red))
            }
          }
        }
      }

      if !slowSorted.isEmpty {
        Section {
          Text("Slow Responses")
          List(Array(slowSorted.enumerated()), id: \.0) { (offset, grade) in
            HStack {
              Image(systemName: "tortoise")
              Text(grade.question.questionAndAnswer)
              Spacer()
              if !grade.isCorrect {
                Text(grade.response).font(.footnote)
                    .overlay(Text("--").foregroundColor(.red))
              }
            }
          }
        }
      }
      Section {
        Text("Correct Responses")
        List(Array(grades.filter {$0.isCorrect} .enumerated()), id: \.0) { (offset, grade) in
          Text(grade.question.questionAndAnswer)
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
    ]
  }


  static var previews: some View {
    NavigationView {
      QuizSummaryView(grades: grades)
        .padding()
    }
  }
}
