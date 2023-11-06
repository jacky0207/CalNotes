//
//  PickerMenu.swift
//  FormEngine
//
//  Created by Jacky Lam on 2023-04-14.
//

import SwiftUI

struct PickerItem: Decodable {
    var id: Int
    var value: String
}

struct PickerMenu<LeftView: View, RightView: View>: View {
    @Binding var selectedId: Int
    var data: [PickerItem]
    var maxWidth: CGFloat?
    var leftView: () -> LeftView
    var rightView: () -> RightView
    var spacing: CGFloat

    init(
        selectedId: Binding<Int>,
        data: [PickerItem],
        maxWidth: CGFloat? = nil,
        leftView: @escaping () -> LeftView = { EmptyView() },
        rightView: @escaping () -> RightView = { EmptyView() },
        spacing: CGFloat = 0
    ) {
        self._selectedId = selectedId
        self.data = data
        self.maxWidth = maxWidth
        self.leftView = leftView
        self.rightView = rightView
        self.spacing = spacing
    }

    var body: some View {
        Menu(
            content: content,
            label: label
        )
        .accessibilityElement()
    }

    func content() -> some View {
        Picker("", selection: $selectedId) {
            pickerDefaultItem()
            ForEach(data, id: \.id) { element in
                pickerItem(content: element.value)
            }
        }
    }

    func pickerDefaultItem() -> some View {
        Text(" ").tag(-1)
    }

    func pickerItem(content: String) -> some View {
        Text(content)
    }

    func label() -> some View {
        LeftRightViewHStack(
            content: {
                Text(data.first(where: { $0.id == selectedId })?.value ?? "")
                    .frame(maxWidth: maxWidth, alignment: .leading)
            },
            leftView: leftView,
            rightView: rightView,
            spacing: spacing
        )
        .accessibilityIdentifier("content")
    }
}

struct PickerMenu_Previews: PreviewProvider {
    static var previews: some View {
        PickerMenu(
            selectedId: .constant(2),
            data: [
                PickerItem(id: 0, value: "Red"),
                PickerItem(id: 1, value: "Green"),
                PickerItem(id: 2, value: "Blue"),
            ]
        )
        .previewLayout(.sizeThatFits)
    }
}
