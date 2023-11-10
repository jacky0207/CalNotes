//
//  FormPicker.swift
//  FormEngineSwiftUI
//
//  Created by Jacky Lam on 2023-04-23.
//

import SwiftUI

struct FormPicker<LeftView: View, RightView: View>: View {
    var title: String
    @Binding var selectedId: Int
    var data: [PickerItem]
    @Binding var errorMessage: String
    var leftView: () -> LeftView
    var rightView: () -> RightView
    var spacing: CGFloat
    var onSelectedChanged: (Int) -> Void

    init(
        title: String = "",
        selectedId: Binding<Int>,
        data: [PickerItem],
        errorMessage: Binding<String> = .constant(""),
        leftView: @escaping () -> LeftView = { EmptyView() },
        rightView: @escaping () -> RightView = { Image("arrow_down").resizable().imageStyle(ImageStyle.Icon()) },
        spacing: CGFloat = Dimen.spacing(.small),
        onSelectedChanged: @escaping (Int) -> Void = { _ in }
    ) {
        self.title = title
        self._selectedId = selectedId
        self.data = data
        self._errorMessage = errorMessage
        self.leftView = leftView
        self.rightView = rightView
        self.spacing = spacing
        self.onSelectedChanged = onSelectedChanged
    }

    init(
        title: String = "",
        field: Binding<FormField<Int>>,
        data: [PickerItem],
        leftView: @escaping () -> LeftView = { EmptyView() },
        rightView: @escaping () -> RightView = { Image("arrow_down").resizable().imageStyle(ImageStyle.Icon()) },
        spacing: CGFloat = Dimen.spacing(.small),
        onSelectedChanged: @escaping (Int) -> Void = { _ in }
    ) {
        self.init(
            title: title,
            selectedId: Binding(
                get: { field.wrappedValue.value },
                set: { field.wrappedValue.value = $0 }
            ),
            data: data,
            errorMessage: Binding(
                get: { field.wrappedValue.errorMessage },
                set: { field.wrappedValue.errorMessage = $0 }
            ),
            leftView: leftView,
            rightView: rightView,
            spacing: spacing,
            onSelectedChanged: onSelectedChanged
        )
    }

    var body: some View {
        FormView(
            title: title,
            errorMessage: $errorMessage,
            content: content
        )
    }

    func content() -> some View {
        PickerMenu(
            selectedId: $selectedId,
            data: data,
            maxWidth: .infinity,
            leftView: { FormView<LeftView>.styled(leftView()) },
            rightView: { FormView<LeftView>.styled(rightView()) },
            spacing: spacing
        )
        .textStyle(TextStyle.Regular())
        .stackStyle(StackStyle.RoundedRect(isError: !errorMessage.isEmpty))
        .onChange(of: selectedId) { _ in
            errorMessage = ""
            onSelectedChanged(selectedId)
        }
        .accessibilityIdentifier("content")
    }
}

struct FormPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FormPicker(
                title: "Color",
                selectedId: .constant(2),
                data: [
                    PickerItem(id: 0, value: "Red"),
                    PickerItem(id: 1, value: "Green"),
                    PickerItem(id: 2, value: "Blue"),
                ],
                errorMessage: .constant("")
            )
            .previewLayout(.sizeThatFits)

            FormPicker(
                title: "Color",
                selectedId: .constant(-1),
                data: [
                    PickerItem(id: 0, value: "Red"),
                    PickerItem(id: 1, value: "Green"),
                    PickerItem(id: 2, value: "Blue"),
                ],
                errorMessage: .constant("Please select")
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Error")
        }
    }
}
