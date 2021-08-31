//
//  ContentView.swift
//  M25a
//
//  Created by Ray Fix on 8/28/21.
//

import SwiftUI

struct ContentView: View {

  let quizzes = MultiplicationQuestion.quizzes()
  @StateObject var model = QuizViewModel()

  var body: some View {
    NavigationView {
      if model.isIdle {
        QuizSelectionView(quizzes: quizzes) { quiz in
          model.ready(quiz: quiz)
        }.navigationTitle("M25 Quiz List")

      }
      else {
        QuizView(model: model)
          .toolbar {
            Button("End") {
              model.canSummarize ? model.summarize() : model.reset()
            }
          }
          .navigationTitle("Quiz \(model.quiz!.title)")
      }
    }.navigationViewStyle(.stack)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
