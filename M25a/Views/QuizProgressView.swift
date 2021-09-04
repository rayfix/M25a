//
//  QuizProgressView.swift
//  QuizProgressView
//
//  Created by Ray Fix on 9/3/21.
//

import SwiftUI

struct QuizProgress: View {
  var progress: Progress

  init(_ progress: Progress) {
    self.progress = progress
  }

  var body: some View {
    HStack(spacing: 3) {
      ForEach(0 ..< progress.count, id: \.self) { item in
        Capsule().frame(height: 10)
          .foregroundColor(item <= progress.index ? Color.accentColor : .black.opacity(0.1))
      }
    }
  }
}
