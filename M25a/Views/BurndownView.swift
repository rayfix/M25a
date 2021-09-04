//
//  BurndownView.swift
//
//  Created by Ray Fix on 9/3/21.
//

import SwiftUI

struct BurndownView: View {

  let totalTime: TimeInterval
  @State private var started: Date?
  @State private var current: Date?
  let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

  private func rectangle(started: Date, current: Date, totalWidth: Double) -> some View {
    let width = totalWidth - (min(current.timeIntervalSince(started), totalTime) / totalTime * totalWidth)
    return Rectangle().frame(width: width, height: 10, alignment: .leading)
      .foregroundColor(Color.accentColor)
      .opacity(0.2)
  }

  var body: some View {
    GeometryReader { proxy in
      if #available(iOS 15, macOS 12, *) {
        TimelineView(.animation) { context in
          if let started = started {
            rectangle(started: started, current: .now, totalWidth: proxy.size.width)
          }
        }
      }
      else {
        if let started = started, let current = current {
          rectangle(started: started, current: current, totalWidth: proxy.size.width)
        }
      }
    }.onAppear {
      started = Date()
    }
    .onReceive(timer) { input in
      self.current = Date()
    }

  }
}
