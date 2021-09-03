//
//  QuizSummaryViewModel.swift
//  QuizSummaryViewModel
//
//  Created by Ray Fix on 9/3/21.
//

import Foundation

final class QuizSummaryViewModel {

  let grades: [Grade]

  init(grades: [Grade]) {
    self.grades = grades
  }

  var percentAccuracy: String {
    let fraction =  Double(grades.lazy.filter {$0.isCorrect}.count) / Double(grades.count)
    return String(format: "%3.1f", fraction * 100)
  }

  var medianTime: String {
    let times = grades.sorted { $0.responseTime < $1.responseTime }.map(\.responseTime)
    return String(format: "%3.1f seconds", times[times.count/2])
  }

  var slowSorted: [Grade] {
    grades
      .filter { $0.isSlow }
      .sorted { $0.responseTime > $1.responseTime }
  }

  var hasIncorrectResponses: Bool {
    !grades.allSatisfy { $0.isCorrect }
  }

  var incorrectResponses: [Grade] {
    grades.filter { !$0.isCorrect }
  }

  var hasSlowResponses: Bool {
    !grades.allSatisfy { !$0.isSlow }
  }

  var hasCorrectResponses: Bool {
    grades.first { $0.isCorrect } != nil
  }

  var correctResponses: [Grade] {
    grades.filter { $0.isCorrect }
  }
}
