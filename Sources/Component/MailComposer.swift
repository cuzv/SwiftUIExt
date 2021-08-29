#if os(iOS) && canImport(MessageUI)
import SwiftUI
import MessageUI

/// https://stackoverflow.com/questions/56784722/swiftui-send-email
@available(iOS 13.0.0, *)
public struct MailComposer: UIViewControllerRepresentable {
    @Binding private var isShowing: Bool
    @Binding private var result: Result<MFMailComposeResult, Error>?
    private let recipients: [String]?
    private let subject: String?
    private let messageBody: String?

    public init(
        isShowing: Binding<Bool>,
        result: Binding<Result<MFMailComposeResult, Error>?>,
        recipients: [String],
        subject: String?,
        messageBody: String?
    ) {
        _isShowing = isShowing
        _result = result
        self.recipients = recipients
        self.subject = subject
        self.messageBody = messageBody
    }

    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding private var isShowing: Bool
        @Binding private var result: Result<MFMailComposeResult, Error>?

        init(
            isShowing: Binding<Bool>,
            result: Binding<Result<MFMailComposeResult, Error>?>
        ) {
            _isShowing = isShowing
            _result = result
        }

        public func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            defer {
                isShowing = false
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(
            isShowing: $isShowing,
            result: $result
        )
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposer>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(recipients)
        if let subject = subject {
            vc.setSubject(subject)
        }
        if let messageBody = messageBody {
            vc.setMessageBody(messageBody, isHTML: false)
        }
        return vc
    }

    public func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<MailComposer>) {
    }
}
#endif
