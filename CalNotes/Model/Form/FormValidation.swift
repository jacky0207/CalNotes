//
//  FormValidation.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

protocol FormValidation {
    func isValid() -> Bool
    mutating func validate()
}
