#if os(iOS)
import SwiftUI

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
public struct Table<
    Model: Identifiable,
    Row: View,
    Header: View,
    Placeholder: View
>: View {
    private let axis: Axis
    private let showsIndicators: Bool
    private let backgroundColor: Color
    private let data: [Model]?
    private let row: (Model) -> Row
    private let header: () -> Header
    private let placeholder: () -> Placeholder

    public init(
        axis: Axis = .vertical,
        showsIndicators: Bool = false,
        backgroundColor: Color = .background,
        data: [Model]?,
        row: @escaping (Model) -> Row,
        header: @autoclosure @escaping () -> Header,
        placeholder: @autoclosure @escaping () -> Placeholder
    ) {
        self.axis = axis
        self.showsIndicators = showsIndicators
        self.backgroundColor = backgroundColor
        self.data = data
        self.row = row
        self.header = header
        self.placeholder = placeholder
    }

    public var body: some View {
        Group {
            if let data = data {
                if data.isEmpty {
                    placeholder()
                } else {
                    ScrollView([scrollAxis], showsIndicators: showsIndicators) {
                        header()
                        lazyStack {
                            ForEach(data) {
                                row($0)
                            }
                        }
                        .padding(15)
                    }
                    .background(backgroundColor)
                }
            } else {
                ActivityIndicator(style: .large, isAnimating: .constant(true))
            }
        }
    }

    @ViewBuilder
    private func lazyStack<Content: View>(content: () -> Content) -> some View {
        if axis == .vertical {
            LazyVStack(spacing: 10, content: content)
        } else {
            LazyHStack(spacing: 10, content: content)
        }
    }

    private var scrollAxis: Axis.Set {
        axis == .vertical ? [.vertical] : [.horizontal]
    }
}
#endif
