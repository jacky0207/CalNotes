//
//  DataList.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

struct DataList<Data: RandomAccessCollection, Content: View, SwipeContent: View>: View {
    var data: Data
    var spacing: CGFloat
    var padding: EdgeInsets
    var content: (Data.Element) -> Content
    var swipeContent: Optional<(Foundation.IndexSet) -> SwipeContent>
    var deleteItem: Optional<(Foundation.IndexSet) -> Void>
    var moveItem: Optional<(Foundation.IndexSet, Int) -> Void>

    init(
        data: Data,
        spacing: CGFloat = 0,
        padding: EdgeInsets = EdgeInsets(),
        @ViewBuilder content: @escaping (Data.Element) -> Content,
        swipeContent: Optional<(Foundation.IndexSet) -> SwipeContent> = nil,
        deleteItem: Optional<(Foundation.IndexSet) -> Void> = nil,
        moveItem: Optional<(Foundation.IndexSet, Int) -> Void> = nil
    ) {
        self.data = data
        self.spacing = spacing
        self.padding = padding
        self.content = content
        self.swipeContent = swipeContent
        self.deleteItem = deleteItem
        self.moveItem = moveItem
    }

    init(
        data: Data,
        spacing: CGFloat = 0,
        padding: EdgeInsets = EdgeInsets(),
        @ViewBuilder content: @escaping (Data.Element) -> Content,
        deleteItem: Optional<(Foundation.IndexSet) -> Void> = nil,
        moveItem: Optional<(Foundation.IndexSet, Int) -> Void> = nil
    ) where SwipeContent == EmptyView {
        self.init(
            data: data,
            spacing: spacing,
            padding: padding,
            content: content,
            swipeContent: nil,
            deleteItem: deleteItem,
            moveItem: moveItem
        )
    }

    var body: some View {
        if data.count == 0 {
            DataNoItemView()
        } else {
            DataItemList(
                data: data,
                spacing: spacing,
                padding: padding,
                content: content,
                swipeContent: swipeContent,
                deleteItem: deleteItem,
                moveItem: moveItem
            )
        }
    }
}

struct DataNoItemView: View {
    var body: some View {
        VStack(spacing: Dimen.spacing(.normal)) {
            Image("item")
                .resizable()
                .imageStyle(ImageStyle.IconXXLarge())
            Text("no_item_found")
                .textStyle(TextStyle.Medium(fontSize: .large))
        }
    }
}

struct DataItemList<Data: RandomAccessCollection, Content: View, SwipeContent: View>: View {
    var data: Data
    var spacing: CGFloat
    var padding: EdgeInsets
    var content: (Data.Element) -> Content
    var swipeContent: Optional<(Foundation.IndexSet) -> SwipeContent>
    var deleteItem: Optional<(Foundation.IndexSet) -> Void>
    var moveItem: Optional<(Foundation.IndexSet, Int) -> Void>

    var body: some View {
        List {
            DataItemSpacer(spacing: padding.top)
                .listRowStyle(ListRowStyle.Default())

            ForEach(0..<data.count, id: \.self) { index in
                content(data[data.index(data.startIndex, offsetBy: index)])
                    .listRowInsets(EdgeInsets(
                        top: index == 0 ? 0 : spacing / 2,
                        leading: padding.leading,
                        bottom: index == data.count - 1 ? 0 : spacing / 2,
                        trailing: padding.trailing
                    ))
                    .listRowStyle(ListRowStyle.Default())
                    .moveDisabled(moveItem == nil)
                    .swipeActions(allowsFullSwipe: deleteItem != nil) {
                        let indexSet = Foundation.IndexSet(arrayLiteral: index)
                        if let deleteItem = deleteItem {
                            Button(action: { deleteItem(indexSet) }) {
                                Image("trash")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .imageStyle(ImageStyle.Icon())
                            }
                            .tint(.red)
                            .accessibilityIdentifier("listRowDeleteButton")
                        }
                        if let swipeContent = swipeContent {
                            swipeContent(indexSet)
                        }
                    }
                    .accessibilityElement()
                    .accessibilityIdentifier("listRow")
            }.onMove { from, to in
                moveItem?(from, to)
            }

            DataItemSpacer(spacing: padding.bottom)
                .listRowStyle(ListRowStyle.Default())
        }
        .listStyle(ListStyle.Default())
//        .id(UUID())  // disable animation to avoid overlap with observed object change
        .environment(\.defaultMinListRowHeight, 1)
        .accessibilityElement()
    }
}

struct DataItemSpacer: View {
    var spacing: CGFloat

    var body: some View {
        Spacer().frame(height: spacing)
    }
}

struct DataList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DataList(
                data: ModelData().noteList.notes,
                spacing: Dimen.spacing(.verticalRow),
                padding: EdgeInsets(top: 15, leading: 15, bottom: 50, trailing: 15),
                content: { note in
                    NoteView(note: note)
                }
            )

            DataList(
                data: [Note](),
                spacing: Dimen.spacing(.verticalRow),
                content: { note in
                    NoteView(note: note)
                }
            )
            .previewDisplayName("No Item")

            DataList(
                data: ModelData().noteList.notes,
                spacing: 0,
                content: { note in
                    NoteView(note: note)
                }
            )
            .previewDisplayName("No Spacing")
        }
    }
}
