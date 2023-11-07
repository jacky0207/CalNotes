//
//  NoteItemForm.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-30.
//

import Foundation
import UIKit

struct NoteItemForm: Encodable {
    var category: Int
    var title: String
    var amount: Float
    var quantity: Float?
    var quantityUnit: String?
    var image: Data?
    var remarks: String?
}

extension NoteItemForm {
    struct LocalForm {
        var category: FormField<Int>
        var title: FormField<String>
        var amount: FormField<String>
        var quantity: FormField<String>
        var quantityUnit: FormField<Int>
        var image: FormField<Optional<UIImage>>
        var remarks: FormField<String>
    }

    init(localForm: LocalForm) {
        let category = NoteItemCategory(rawValue: localForm.category.value)
        let isQuantityEnabled = category?.isQuantityEnabled ?? false
        let quantityUnit = NoteItemQuantityUnit(rawValue: localForm.quantityUnit.value)

        self.init(
            category: localForm.category.value,
            title: localForm.title.value,
            amount: Float(localForm.amount.value)!,
            quantity: isQuantityEnabled ? Float(localForm.quantity.value) : nil,
            quantityUnit: isQuantityEnabled ? quantityUnit?.name : nil,
            image: localForm.image.value?.jpegData(compressionQuality: 1),
            remarks: localForm.remarks.value.isEmpty ? nil : localForm.remarks.value
        )
    }
}

extension NoteItemForm.LocalForm {
    static var none: NoteItemForm.LocalForm {
        return NoteItemForm.LocalForm(
            category: .init(NoteItemCategory.dollar.rawValue),
            title: .init(""),
            amount: .init(""),
            quantity: .init("1"),
            quantityUnit: .init(-1),
            image: .init(nil),
            remarks: .init("")
        )
    }

    static func image(_ image: UIImage?) -> NoteItemForm.LocalForm {
        return NoteItemForm.LocalForm(
            category: .init(NoteItemCategory.dollar.rawValue),
            title: .init(""),
            amount: .init(""),
            quantity: .init("1"),
            quantityUnit: .init(-1),
            image: .init(image),
            remarks: .init("")
        )
    }
}

// MARK: - FormValidation
extension NoteItemForm.LocalForm: FormValidation {
    func isValid() -> Bool {
        return category.value >= 0
        && !title.value.isEmpty
        && Float(amount.value) != nil
        && (!(NoteItemCategory(rawValue: category.value)?.isQuantityEnabled ?? true) || Float(quantity.value) != nil)
    }

    mutating func validate() {
        if category.value < 0 {
            category.errorMessage = "empty_select_error".localized()
        }
        if title.value.isEmpty {
            title.errorMessage = "empty_text_error".localized()
        }
        if Float(amount.value) == nil {
            amount.errorMessage = "empty_text_error".localized()
        }
        if (NoteItemCategory(rawValue: category.value)?.isQuantityEnabled ?? false) && Float(quantity.value) == nil {
            quantity.errorMessage = "empty_text_error".localized()
        }
    }
}

// MARK: - NoteItemForm
extension NoteItemForm.LocalForm {
    init(noteItemDetail: NoteItemDetail) {
        let quantityUnit = NoteItemQuantityUnit.unit(from: noteItemDetail.quantityUnit ?? "")
        self.init(
            category: .init(noteItemDetail.category),
            title: .init(noteItemDetail.title),
            amount: .init(String(noteItemDetail.amount)),
            quantity: .init(String(noteItemDetail.quantity ?? 1)),
            quantityUnit: .init(quantityUnit?.rawValue ?? -1),
            image: .init(noteItemDetail.image == nil ? nil : UIImage(data: noteItemDetail.image!)),
            remarks: .init(noteItemDetail.remarks ?? "")
        )
    }
}

// MARK: - NoteItemDetail
extension NoteItemDetail {
    init(
        id: Int,
        noteId: Int,
        form: NoteItemForm
    ) {
        self.init(
            id: id,
            noteId: noteId,
            title: form.title,
            category: form.category,
            amount: form.amount,
            quantity: form.quantity,
            remarks: form.remarks
        )
    }
}
