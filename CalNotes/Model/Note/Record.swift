//
//  Record.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

protocol Record: Decodable, Identifiable {
    var id: Int { get set }
    var title: String { get set }
    var sum: Float { get set }
    var lastUpdate: String { get set }
}
