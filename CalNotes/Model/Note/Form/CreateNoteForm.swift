//
//  CreateNoteForm.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-09-03.
//

import Foundation

struct CreateNoteForm: Encodable {
    var title: String
}

extension CreateNoteForm: CustomStringConvertible {
    var description: String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

extension CreateNoteForm {
    struct LocalForm {
        var title: String
    }

    init(localForm: LocalForm) {
        self.init(
            title: localForm.title
        )
    }
}

extension CreateNoteForm.LocalForm: Encodable & CustomStringConvertible {
    var description: String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

extension CreateNoteForm.LocalForm {
    static var none: CreateNoteForm.LocalForm {
        return CreateNoteForm.LocalForm(
            title: ""
        )
    }
}

// MARK: - FormValidation
extension CreateNoteForm.LocalForm: FormValidation {
    func isValid() -> Bool {
        return !title.isEmpty
    }

    mutating func validate() {
        
    }
}
