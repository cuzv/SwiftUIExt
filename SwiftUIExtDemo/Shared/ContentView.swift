//
//  ContentView.swift
//  Shared
//
//  Created by Shaw on 8/30/21.
//

import SwiftUI
import SwiftUIExt

struct ContentView: View {
    var body: some View {
        #if os(iOS)
        Root()
        #else
        FetchProgress()
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FetchProgress: View {
    var body: some View {
        HStack(spacing: 10) {
            Spinner(lineWidth: 2).frame(width: 14, height: 14)
            Text("Fetching 90%...").font(.footnote)
            Spacer()
        }
        .padding(15, 6)
    }
}
