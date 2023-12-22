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
    self._currentIndex = currentIndex
    self.content = content()
  }

  public var body: some View {
    GeometryReader { geometry in
      HStack(spacing: 0) {
        self.content.frame(width: geometry.size.width)
      }
      .frame(width: geometry.size.width, alignment: .leading)
      .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
      .offset(x: self.translation)
      .animation(.interactiveSpring())
      .gesture(
        DragGesture().updating(self.$translation) { value, state, _ in
          state = value.translation.width
        }.onEnded { value in
          let offset = value.translation.width / geometry.size.width
          let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
          self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
        }
      )
    }
  }
}
