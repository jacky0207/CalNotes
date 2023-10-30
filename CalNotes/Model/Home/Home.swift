//
//  Home.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-29.
//

struct Home: Decodable {
    var note: Int
    var trash: Int
}

extension Home {
    static var none: Home {
        return Home(
            note: 0,
            trash: 0
        )
    }
}
