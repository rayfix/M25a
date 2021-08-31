//
//  ResponseTimeView.swift
//  ResponseTimeView
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI


struct ReviewResponseView: View {

  let progress: Progress
  let grade: Grade

  var body: some View {
    VStack {
      Text("Question \(progress.number) of \(progress.count)")
      Group {
      if grade.isCorrect {
        Text("Correct").foregroundColor(.green)
      } else {
        Text("Incorrect").foregroundColor(.red)
      }
      }.font(.largeTitle)
      Spacer().frame(height: 30)
      Text(grade.question.questionAndAnswer).font(.largeTitle)
      if grade.isCorrect {
        Text("Response Time: \(String(format: "%3.1f seconds", grade.responseTime))")
        if grade.isSlow {
          Text("Try to improve your response time.")
        }
      }
      Spacer().frame(height: 60)


      if !grade.isCorrect {
        HStack {
          Text("The answer is not ")
          Text("\(grade.response).")
            .overlay(Text("--").foregroundColor(.red))
        }
      }
    }
  }
}

struct ReviewResponse_Previews: PreviewProvider {
   static var previews: some View {
     NavigationView {
       VStack {
         ReviewResponseView(progress: Progress(index: 0, count: 10)!,
                            grade: .init(question: MultiplicationQuestion(a: 10, b: 10),
                                         shown: Date(), responseTime: 1, response: "100"))
         Button("Next") { }.buttonStyle(BorderedButton())
       }
     }
     ReviewResponseView(progress: Progress(index: 5, count: 10)!,
                        grade: .init(question: MultiplicationQuestion(a: 10, b: 10),
                                     shown: Date(), responseTime: 10.11111, response: "100"))
     ReviewResponseView(progress: Progress(index: 0, count: 10)!,
                        grade: .init(question: MultiplicationQuestion(a: 10, b: 10),
                                     shown: Date(), responseTime: 10, response: "101"))
   }
}
