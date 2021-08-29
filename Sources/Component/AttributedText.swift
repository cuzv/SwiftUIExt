#if os(iOS) && canImport(SwiftUI)
import SwiftUI
import UIKit

/// https://raw.githubusercontent.com/omichde/AttributedText/master/Sources/AttributedText/AttributedText.swift
@available(iOS 13.0, *)
public struct AttributedText: View {
    private var attributedText: NSAttributedString
    @State private var box: CGSize = .zero

    public init(_ attributedText: NSAttributedString) {
        self.attributedText = attributedText
    }

    public var body: some View {
        WrappedTextView(attributedText)
            .background(
                GeometryReader { geo in
                    Color.clear.preference(
                        key: SizedTextPreferenceKey.self,
                        value: SizedTextContent(attributedText: attributedText, size: geo.size)
                    )
                }
            )
            .if(box.width > 0) {
                $0.frame(width: box.width, height: box.height)
            }
            .onPreferenceChange(SizedTextPreferenceKey.self) { value in
                // minimize updates
                if
                    value.size.width > 0 &&
                    value.size.height > 0 &&
                    (value.size.width != box.width ||
                    value.size.height != box.height) {
                    self.box = value.size
                }
            }
    }
}

@available(iOS 13.0, *)
extension AttributedText {
    private struct SizedTextContent: Equatable {
        let attributedText: NSAttributedString
        let size: CGSize

        static let empty = SizedTextContent(
            attributedText: NSAttributedString(string: ""),
            size: .zero
        )

        func with(height: CGFloat) -> SizedTextContent {
            SizedTextContent(
                attributedText: attributedText,
                size: CGSize(width: size.width, height: height)
            )
        }
    }

    private struct SizedTextPreferenceKey: PreferenceKey {
        static let defaultValue: SizedTextContent = .empty
        static func reduce(value: inout Value, nextValue: () -> Value) {
            var val = nextValue()
            if value.size.width > 0 {
                // this is called multiple times with the default size value and we only need to recalculate for a "valid" width
                let height = value.attributedText.calculateBoxHeight(value.size.width)
                val = value.with(height: height)
            }
            value = val
        }
    }

    private struct WrappedTextView: UIViewRepresentable {
        let attributedText: NSAttributedString

        init(_ attributedText: NSAttributedString) {
            self.attributedText = attributedText
        }

        func makeUIView(context: Context) -> AttributedUITextView {
            AttributedUITextView()
        }

        func updateUIView(_ uiView: AttributedUITextView, context: Context) {
            uiView.attributedText = attributedText
        }
    }

    private class AttributedUITextView: UITextView {
        override init(frame: CGRect, textContainer: NSTextContainer?) {
            super.init(frame: frame, textContainer: textContainer)
            setup()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }

        private func setup() {
            textContainer.lineBreakMode = .byWordWrapping
            textContainer.maximumNumberOfLines = 0
            textContainer.lineFragmentPadding = 0
            textContainerInset = .zero
            isUserInteractionEnabled = true
            isEditable = false
            isScrollEnabled = false
            isSelectable = true
            backgroundColor = nil

            setContentHuggingPriority(.required, for: .horizontal)
            setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
    }
}

private extension NSAttributedString {
    // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TextLayout/Tasks/StringHeight.html#//apple_ref/doc/uid/20001809-CJBGBIBB
    func calculateBoxHeight(_ width: CGFloat) -> CGFloat {
        let box = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let storage = NSTextStorage(attributedString: self)
        let container = NSTextContainer(size: box)
        let manager = NSLayoutManager()
        manager.addTextContainer(container)
        storage.addLayoutManager(manager)
        container.maximumNumberOfLines = 0
        container.lineFragmentPadding = 0
        manager.glyphRange(forBoundingRect: CGRect(origin: .zero, size: box), in: container)
        return ceil(manager.usedRect(for: container).size.height)
    }
}
#endif
