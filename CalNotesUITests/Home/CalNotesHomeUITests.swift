//
//  CalNotesHomeUITests.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

final class CalNotesHomeUITests: XCTestCase {
    var tester = HomeTester(app: XCUIApplication())

    override func setUpWithError() throws {
        continueAfterFailure = false
        tester.reset()
    }

    override func tearDownWithError() throws {

    }

    func testHome_EnterNoteList() throws {
        tester.enterNoteList()
    }

    func testHome_EnterNoteTrash() throws {
        tester.enterNoteTrash()
    }
}
