#if canImport(SwiftUI)
import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, macCatalyst 13.0, *)
extension View {
    public func embedInButton(action: @escaping () -> Void) -> Button<Self> {
        Button(action: action) {
            self
        }
    }

    public func embedInNavigation() -> NavigationView<Self> {
        NavigationView {
            self
        }
    }

    public func embedInHStack(justify: HorizontalAlignment = .leading) -> some View {
        HStack {
            if [.trailing, .center].contains(justify) {
                Spacer()
            }
            self
            if [.leading, .center].contains(justify) {
                Spacer()
            }
        }
    }

    public func embedInVStack(justify: VerticalAlignment = .top) -> some View {
        VStack {
            if [.bottom, .center].contains(justify) {
                Spacer()
            }
            self
            if [.top, .center].contains(justify) {
                Spacer()
            }
        }
    }

    public func embedInScrollView(_ axis: Axis.Set = .vertical, showsIndicators: Bool = true) -> ScrollView<Self> {
        ScrollView(axis, showsIndicators: showsIndicators) {
            self
        }
    }

    public func embedInScrollView(alignment: Alignment = .center) -> some View {
        GeometryReader { geometry in
            ScrollView {
                frame(
                    minHeight: geometry.size.height,
                    maxHeight: .infinity,
                    alignment: alignment
                )
            }
        }
    }

    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
    @ViewBuilder
    public func unredacted(when condition: Bool) -> some View {
        if condition {
            unredacted()
        } else {
            redacted(reason: .placeholder)
        }
    }

    @ViewBuilder
    public func navigation<Destination: View>(
        isActive: Binding<Bool>? = nil,
        destination: @autoclosure @escaping () -> Destination
    ) -> some View {
        if let isActive = isActive {
            NavigationLink(
                destination: LazyView(content: destination()),
                isActive: isActive
            ) { self }
        } else {
            NavigationLink(
                destination: LazyView(content: destination())
            ) { self }
        }
    }

    public func adaptiveHeight(
        alignment: VerticalAlignment,
        cacheHeight: Binding<CGFloat>
    ) -> some View {
        frame(minHeight: cacheHeight.wrappedValue)
        .alignmentGuide(alignment) { dimensions in
            let dh = dimensions.height
            if dh.isNormal {
                let nh = max(cacheHeight.wrappedValue, dh)
                if cacheHeight.wrappedValue != nh {
                    DispatchQueue.main.async {
                        cacheHeight.wrappedValue = nh
                    }
                }
            }
            return dimensions[alignment]
        }
    }

    @ViewBuilder
    public func `if`<Transform: View>(
        _ condition: @autoclosure () -> Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }

    @ViewBuilder
    public func get<Transform: View, T>(
        _ getter: @autoclosure () -> T?,
        transform: (Self, T) -> Transform
    ) -> some View {
        if let v = getter() {
            transform(self, v)
        } else {
            self
        }
    }
}
#endif

#if os(iOS)
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
    public func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .systemBackground

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
#endif
