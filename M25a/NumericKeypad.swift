//
//  Keypad.swift
//  Keypad
//
//  Created by Ray Fix on 8/28/21.
//

import SwiftUI

struct NumericKeypad: View {
  @Binding var value: Int
  var onEnterTapped: (Int) -> () = { _ in }

  enum Command {
    case digit(Int)
    case delete
  }

  struct KeypadButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .font(.title)
        .frame(width: 80, height: 70, alignment: .center)
        .background(
          configuration.isPressed ?
          Color(UIColor.secondaryLabel) :
            Color(UIColor.tertiarySystemFill)
        )
        .cornerRadius(5)
    }
  }

  func send(_ command: Command) {
    switch command {
    case .digit(let digit):
      guard value < 10000000000 else {
        return
      }
      value = value * 10 + digit
    case .delete:
      value /= 10
    }
  }

  private func digit(_ digit: Int) -> some View {
    Button(String(describing: digit)) {
      send(.digit(digit))
    }
  }

  private func delete() -> some View {
    Button {
      send(.delete)
    } label: {
      Image(systemName: "delete.left")
    }
  }

  private func enter() -> some View {
    Button {
      onEnterTapped(value)
    } label: {
      Image(systemName: "return")
    }
  }

  var body: some View {
    VStack {
      HStack { digit(7) ; digit(8); digit(9) }
      HStack { digit(4) ; digit(5); digit(6) }
      HStack { digit(1) ; digit(2); digit(3) }
      HStack { delete() ; digit(0); enter()  }
    }.buttonStyle(KeypadButton())
  }
}

