//
//  QuizStartView.swift
//  QuizStartView
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct QuizStartView: View {

  let quiz: Quiz

  var questions: String {
    quiz.templates.count == 1 ?
      "Only one question" : "\(quiz.templates.count) questions"
  }

  var body: some View {
    VStack {
      Text("Get Ready!").font(.largeTitle)
      Text(questions)
      Spacer().frame(height: 60)
    }
  }
}
