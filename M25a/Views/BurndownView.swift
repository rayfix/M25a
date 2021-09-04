//
//  BurndownView.swift
//
//  Created by Ray Fix on 9/3/21.
//

import SwiftUI


// MARK: - Common Method

private func rectangle(started: Date, current: Date, totalWidth: Double, totalTime: TimeInterval) -> some View {
  let width = totalWidth - (min(current.timeIntervalSince(started), totalTime) / totalTime * totalWidth)
  return Rectangle().frame(width: width, height: 10, alignment: .leading)
    .foregroundColor(Color.accentColor)
    .opacity(0.2)
}

// MARK: - iOS 14 version

private struct BurndownView14: View {
  let totalTime: TimeInterval
  @State private var started: Date?
  @State private var current: Date?
  let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

  var body: some View {
    GeometryReader { proxy in
        if let started = started, let current = current {
          rectangle(started: started, current: current,
                    totalWidth: proxy.size.width, totalTime: totalTime)
        }
      }
    .onAppear {
      started = Date()
    }
    .onReceive(timer) { input in
      self.current = input
    }
  }
}

// MARK: - iOS 15 version

@available(iOS 15, *)
private struct BurndownView15: View {

  let totalTime: TimeInterval
  @State private var started: Date?

  var body: some View {
    GeometryReader { proxy in
        TimelineView(.animation) { context in
          if let started = started {
            rectangle(started: started, current: .now,
                      totalWidth: proxy.size.width, totalTime: totalTime)
          }
        }
    }.onAppear {
      started = Date()
    }
  }
}

// MARK: -- Common view

struct BurndownView: View {
  let totalTime: TimeInterval
  var body: some View {
    if #available(iOS 15, *) {
      AnyView(BurndownView15(totalTime: totalTime))
    } else {
      AnyView(BurndownView14(totalTime: totalTime))
    }
  }
}

