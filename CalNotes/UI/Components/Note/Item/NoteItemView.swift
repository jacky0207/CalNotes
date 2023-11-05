//
//  NoteItemView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

struct NoteItemView: View {
    var item: NoteItem
    var disabled: Bool
    
    var body: some View {
        HStack(spacing: Dimen.spacing(.normal)) {
            NoteItemTitleView(
                item.title,
                category: NoteItemCategory(rawValue: item.category)
            )
            NoteItemQuantityView(
                item.quantity,
                item.quantityUnit
            )
            if !disabled {
                NoteItemStateView(
                    title: item.title,
                    image: item.image == nil ? nil : UIImage(data: item.image!),
                    remarks: item.remarks
                )
            }
            Spacer()
            NoteItemSumView(item.sum)
        }
        .stackStyle(StackStyle.NoteItem())
    }
}

struct NoteItemTitleView: View {
    var title: String
    var category: NoteItemCategory?

    init(_ title: String, category: NoteItemCategory?) {
        self.title = title
        self.category = category
    }

    var body: some View {
        HStack(spacing: Dimen.spacing(.normal)) {
            if let category = category {
                category.icon
                    .resizable()
                    .imageStyle(ImageStyle.Icon())
            }
            Text(title)
                .textStyle(TextStyle.ItemTitle())
        }
    }
}

struct NoteItemQuantityView: View {
    var quantity: Float
    var unit: String?

    init(_ quantity: Float, _ unit: String?) {
        self.quantity = quantity
        self.unit = unit
    }

    var body: some View {
        if quantity != 1 || !(unit?.isEmpty ?? true) {
            return AnyView(
                Text("quantity_unit_format".localized(with: [
                    quantity.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(quantity))" : String(format: "%.2f", quantity),
                    unit ?? ""
                ]))
                .textStyle(TextStyle.ItemTitle())
            )
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct NoteItemStateView: View {
    var title: String
    var image: UIImage?
    var remarks: String?

    var body: some View {
        HStack(spacing: Dimen.spacing(.small)) {
            imageButton()
            infoButton()
        }
    }

    func imageButton() -> some View {
        if let image = image {
            return AnyView(NavigationViewLink(
                destination: { ImagePreviewView(title: title, image: image) },
                label: imageLabel
            ))
        } else {
            return AnyView(EmptyView())
        }
    }

    func imageLabel() -> some View {
        Image("image")
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }

    func infoButton() -> some View {
        if let remarks = remarks, !remarks.isEmpty {
            return AnyView(Button(
                action: { infoAction(title: title, remarks: remarks) },
                label: infoLabel
            ))
        } else {
            return AnyView(EmptyView())
        }
    }

    func infoAction(title: String, remarks: String) {
        AppState.shared.setAlert(for: AlertParams(title: title, message: remarks))
    }

    func infoLabel() -> some View {
        Image("info")
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }
}

struct NoteItemSumView: View {
    var amount: Float

    init(_ amount: Float) {
        self.amount = amount
    }

    var body: some View {
        Text(amount == 0 ? "free".localized() : "dollar_format".localized(with: [amount]))
            .textStyle(TextStyle.ItemTitle())
    }
}

struct NoteItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoteItemView(item: ModelData().noteItem, disabled: false)
//            NoteItemView(item: ModelData().noteItem, disabled: true)
//                .previewDisplayName("Disabled Item")
        }
    }
}

