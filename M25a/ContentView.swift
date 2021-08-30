//
//  ContentView.swift
//  M25a
//
//  Created by Ray Fix on 8/28/21.
//

import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .frame(width: 200)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct QuestionView: View {

  let started: Date
  let questionNumber: Int
  let totalQuestionCount: Int
  let question: Question
  let onResponse: (Grade) -> ()

  @State private var entryValue = 0

  var entry: String {
    entryValue > 0 ? String(entryValue) : " "
  }

  var body: some View {
    VStack {
      Text("Question #\(questionNumber) of \(totalQuestionCount)")
      Text(question.question).font(.largeTitle)
      Text(entry).font(.largeTitle)
      NumericKeypad(value: $entryValue) { value in
        let elapsed = Date().timeIntervalSince(started)
        let grade = Grade(question: question,
                          shown: started,
                          responseTime: elapsed,
                          response: String(value))
        onResponse(grade)
      }
      .padding()
    }
  }
}

struct QuizList: View {
  let quizzes = MultiplicationQuestion.quizes()

  var body: some View {
    List(Array(quizzes.enumerated()), id: \.offset) { offset, quiz in
      NavigationLink(destination: QuizView(quiz: quiz)) {
        Label("Quiz \(quiz.title)", systemImage: "doc.text")
      }
    }.navigationTitle("M25 Quiz List")
  }
}

struct ContentView: View {

  let model = MultiplicationQuestion.quizes()

  var body: some View {
    NavigationView {
      QuizList()
    }

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
