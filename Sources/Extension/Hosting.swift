import SwiftUI

@available(iOS 15.0, *)
public extension View {
  func inHost(detents: [UISheetPresentationController.Detent] = []) -> UIHostingController<Self> {
    let vc = UIHostingController(rootView: self)
    
    if !detents.isEmpty {
      vc.modalPresentationStyle = .pageSheet
      if let sheet = vc.sheetPresentationController {
        sheet.detents = detents
      }
    }
    
    return vc
  }
}
