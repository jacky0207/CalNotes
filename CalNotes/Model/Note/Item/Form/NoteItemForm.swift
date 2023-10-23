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
    var image: Data?
    var remarks: String?
}

extension NoteItemForm: CustomStringConvertible {
    var description: String {
        var object = self
        object.image = object.image == nil ? nil : Data()
        let jsonData = try! JSONEncoder().encode(object)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

extension NoteItemForm {
    struct LocalForm {
        var category: FormField<Int>
        var title: FormField<String>
        var amount: FormField<String>
        var image: FormField<Optional<UIImage>>
        var remarks: FormField<String>
    }

    init(localForm: LocalForm) {
        self.init(
            category: localForm.category.value,
            title: localForm.title.value,
            amount: Float(localForm.amount.value)!,
            image: localForm.image.value?.jpegData(compressionQuality: 1),
            remarks: localForm.remarks.value.isEmpty ? nil : localForm.remarks.value
        )
    }
}

extension NoteItemForm.LocalForm: Encodable & CustomStringConvertible {
    var description: String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

extension NoteItemForm.LocalForm {
    static var none: NoteItemForm.LocalForm {
        return NoteItemForm.LocalForm(
            category: .init(NoteItemCategory.dollar.rawValue),
            title: .init(""),
            amount: .init(""),
            image: .init(nil),
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
    }

    mutating func validate() {
        if category.value < 0 {
            category.message = "empty_select_error".localized()
        }
        if title.value.isEmpty {
            title.message = "empty_text_error".localized()
        }
        if Float(amount.value) == nil {
            amount.message = "empty_text_error".localized()
        }
    }
}

// MARK: - NoteItemForm
extension NoteItemForm.LocalForm {
    init(noteItemDetail: NoteItemDetail) {
        self.init(
            category: .init(noteItemDetail.category),
            title: .init(noteItemDetail.title),
            amount: .init(String(noteItemDetail.amount)),
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
            remarks: form.remarks
        )
    }
}
