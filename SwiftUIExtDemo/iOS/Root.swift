//
//  Root.swift
//  SwiftUIExtDemo
//
//  Created by Shaw on 8/30/21.
//

import SwiftUI
import SwiftUIExt

struct Root: View {
  var body: some View {
    ActivityIndicator(style: .large, isAnimating: .constant(true))
  }
}

struct Root_Previews: PreviewProvider {
  static var previews: some View {
    Root()
  }
}
