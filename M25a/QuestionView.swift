//
//  QuestionView.swift
//  QuestionView
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct QuestionView: View {

  let started: Date
  let progress: Progress
  let question: Question
  let onResponse: (Grade) -> ()

  @State private var entryValue = 0

  var entry: String {
    (entryValue > 0 ? String(entryValue) : "") + "_"
  }

  var body: some View {
    VStack {
      Text("Question \(progress.questionNumber) of \(progress.questionCount)")
      Spacer().frame(height: 15)
      Text(question.question).font(.largeTitle)
      Text(entry).font(.largeTitle)
      NumericKeypad(value: $entryValue) { value in
        let elapsed = Date().timeIntervalSince(started)
        let grade = Grade(question: question,
                          shown: started,
                          responseTime: elapsed,
                          response: value > 0 ? String(value) : "")
        onResponse(grade)
      }
      .padding()
    }
  }
}

