//
//  Model.swift
//
//  Created by Ray Fix on 8/29/21.
//

import Foundation

protocol Question {
  var question: String { get }
  var answer: String { get }
  var questionAndAnswer: String { get }
  var expectedMaximumResponseTime: TimeInterval { get }

  // Grading
  func isCorrect(response: String) -> Bool
  func isSlow(responseTime: TimeInterval) -> Bool
}

extension Question {
  var questionAndAnswer: String { "\(question)\n\(answer)" }

  func isCorrect(response: String) -> Bool {
    response == answer
  }
  func isSlow(responseTime: TimeInterval) -> Bool {
    responseTime > expectedMaximumResponseTime
  }
}

// MARK: --

struct Grade {
  let question: Question
  let shown: Date
  let responseTime: TimeInterval
  let response: String

  var isCorrect: Bool {
    question.isCorrect(response: response)
  }

  var isSlow: Bool {
    question.isSlow(responseTime: responseTime)
  }
}

// MARK: --

struct Quiz {
  var title: String
  var details: String
  var questions: [Question]
}

struct Progress {
  var index: Int
  var questionNumber: Int { index + 1 }
  var questionCount: Int
}
