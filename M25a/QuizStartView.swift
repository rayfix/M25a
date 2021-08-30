//
//  QuizStartView.swift
//  QuizStartView
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI


struct QuizStartView: View {

  let title: String
  let questionCount: Int

  var questions: String {
    questionCount == 1 ?
      "Only one question" :
      "\(questionCount) questions"
  }

  var body: some View {
    VStack {
      Text("Get Ready!").font(.largeTitle)
      Text(questions)
      Spacer().frame(height: 60)
    }
  }
}
