//
//  ViewModel.swift
//
//  Created by Ray Fix on 8/29/21.
//

import Foundation

final class Quiz: ObservableObject {

  enum State {
    case start
    case askQuestion(Array<Question>.Index)
    case reviewResponse(Array<Question>.Index, Grade)
    case summary
  }

  let title: String
  var questions: [Question]
  @Published var grades: [Grade] = []
  @Published var state: State = .start

  init(title: String, questions: [Question]) {
    self.title = title
    self.questions = questions
    self.state = .start
  }
}

extension MultiplicationQuestion {

  static func quiz(for values: ClosedRange<Int>,
                   range: ClosedRange<Int> = 12...25,
                   exclude: Set<Int> = []) -> Quiz {
    let questions = values.flatMap { a in
      range.map { b in
        MultiplicationQuestion(a: a, b: b)
      }
    }
    .filter { !exclude.contains($0.a) && !exclude.contains($0.b) }

    let valuesString = values.count == 1 ? "\(values.lowerBound)" : "\(values)"

    return Quiz(title: "\(valuesString)", questions: questions)
  }

  static func quizes() -> [Quiz] {
    [
      (12...24).map { quiz(for: $0...$0) },
      [
        quiz(for: 12...25, exclude: [10,11,22])
      ]
    ].flatMap { $0 }
  }
}
