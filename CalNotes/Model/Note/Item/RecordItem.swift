//
//  RecordItem.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

protocol RecordItem: Decodable {
    var id: Int { get set }
    var title: String { get set }
    var category: Int { get set }
    var amount: Float { get set }
}
