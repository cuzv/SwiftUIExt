#if os(iOS) && canImport(SwiftUI)
import SwiftUI

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
public struct ItemsToolbar: ToolbarContent {
    @Binding private var sort: Int

    public init(sort: Binding<Int>) {
        _sort = sort
    }

    public var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            Button("Sort", action: {})
            Button("Filter", action: {})
        }

        ToolbarItem(placement: .primaryAction) {
            Menu {
                Button(action: {}) {
                    Label("Create a file", systemImage: "doc")
                }

                Button(action: {}) {
                    Label("Create a folder", systemImage: "folder")
                }
            }
            label: {
                Label("Add", systemImage: "plus")
            }
        }

        ToolbarItem(placement: .navigationBarLeading) {
            Menu {
                Picker(selection: $sort, label: Text("Sorting options")) {
                    Text("Size").tag(0)
                    Text("Date").tag(1)
                    Text("Location").tag(2)
                }

            }
            label: {
                Label("Add", systemImage: "plus")
            }
        }
    }
}
#endif
