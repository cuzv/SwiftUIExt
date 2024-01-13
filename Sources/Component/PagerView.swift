//
//  PagerView.swift
//
//  Created by Majid Jabrayilov on 12/5/19.
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//

import SwiftUI

/// Copied from https://gist.github.com/mecid/e0d4d6652ccc8b5737449a01ee8cbc6f
public struct PagerView<Content: View>: View {
  let pageCount: Int
  @Binding var currentIndex: Int
  let content: Content

  @GestureState private var translation: CGFloat = 0

  public init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
    self.pageCount = pageCount
    _currentIndex = currentIndex
    self.content = content()
  }

  public var body: some View {
    GeometryReader { geometry in
      HStack(spacing: 0) {
        content.frame(width: geometry.size.width)
      }
      .frame(width: geometry.size.width, alignment: .leading)
      .offset(x: -CGFloat(currentIndex) * geometry.size.width)
      .offset(x: translation)
      .animation(.interactiveSpring())
      .gesture(
        DragGesture().updating($translation) { value, state, _ in
          state = value.translation.width
        }.onEnded { value in
          let offset = value.translation.width / geometry.size.width
          let newIndex = (CGFloat(currentIndex) - offset).rounded()
          currentIndex = min(max(Int(newIndex), 0), pageCount - 1)
        }
      )
    }
  }
}
