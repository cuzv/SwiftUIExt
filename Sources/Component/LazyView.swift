import SwiftUI

// https://stackoverflow.com/questions/57594159/swiftui-navigationlink-loads-destination-view-immediately-without-clicking
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct LazyView<Content: View>: View {
    private let content: () -> Content

    public init(content: @autoclosure @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        content()
    }
}
