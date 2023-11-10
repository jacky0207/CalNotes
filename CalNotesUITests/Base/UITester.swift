//
//  UITester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-08.
//

import XCTest

protocol UITester {
    var app: XCUIApplication { get }
    init(app: XCUIApplication)
    func reset()
    func enterPage()
    func isEnteredPage() -> Bool
}
