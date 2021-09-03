//
//  ContentView.swift
//  M25a
//
//  Created by Ray Fix on 8/28/21.
//

import SwiftUI

struct ContentView: View {

  @StateObject var model = QuizViewModel(quizzes: MultiplicationQuestion.quizzes())

  var body: some View {
    NavigationView {
      QuizView(model: model)
        .toolbar {
          if model.canEnd {
              Button("End") { model.endTapped() }
          }
        }
        .navigationTitle(model.navigationTitle)
    }.navigationViewStyle(.stack)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
