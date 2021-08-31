//
//  MultiplicationQuestion.swift
//
//  Created by Ray Fix on 8/30/21.
//

import Foundation


// MARK: --

struct MultiplicationQuestion: Question {
  var a: Int
  var b: Int

  var question: String { "\(a) ⨉ \(b)" }
  var answer: String { "\(a*b)"}
  var questionAndAnswer: String { "\(question) = \(answer)" }

  var expectedMaximumResponseTime: TimeInterval {
    return 5
  }
}

// MARK: --

extension MultiplicationQuestion {

  static func quiz(for values: ClosedRange<Int>,
                   range: ClosedRange<Int> = 2...25,
                           exclude: Set<Int> = []) -> Quiz {
    let questions = values.flatMap { a in
      range.map { b in
        MultiplicationQuestion(a: a, b: b)
      }
    }
    .filter { !exclude.contains($0.a) && !exclude.contains($0.b) }

    let title = values.count == 1 ? "\(values.lowerBound)" : "\(values)"
    let details = exclude.isEmpty ? "" : "Excluding " +
      exclude.sorted().map(String.init).joined(separator: ", ")

    return Quiz(title: title, details: details, questions: questions)
  }

  static func quiz(for value: Int,
                   range: ClosedRange<Int> = 2...25,
                   exclude: Set<Int> = []) -> Quiz {
    Self.quiz(for: value...value, range: range, exclude: exclude)
  }

  static func quizzes() -> [Quiz] {
    [
      (12...24).map { Self.quiz(for: $0, exclude: [10]) },
      [ Self.quiz(for: 12...25, exclude: [2,10,20,11,22]) ]
    ].flatMap { $0 }
  }
}
