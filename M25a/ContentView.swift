//
//  ContentView.swift
//  M25a
//
//  Created by Ray Fix on 8/28/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      QuizListView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
