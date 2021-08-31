//
//  BlueButton.swift
//  BlueButton
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct BorderedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .frame(width: 200)
        .padding()
        .background(Color.accentColor)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .font(.headline)
    }
}
