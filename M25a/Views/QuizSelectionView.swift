//
//  QuizSelectionView.swift
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct QuizSelectionView: View {

  var quizzes: [Quiz]
  var onSelect: (Quiz) -> Void

  var body: some View {
    List(Array(quizzes.enumerated()), id: \.offset) { offset, quiz in
      Button {
        onSelect(quiz)
      } label: {
        Label("Quiz \(quiz.title)", systemImage: "doc.text")
      }.buttonStyle(.plain)
    }
  }
}

