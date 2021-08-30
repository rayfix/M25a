//
//  BlueButton.swift
//  BlueButton
//
//  Created by Ray Fix on 8/29/21.
//

import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .frame(width: 200)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .font(.headline)
    }
}
