//
//  CalNotesCreateNoteUITests.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-08-27.
//

import XCTest

final class CalNotesCreateNoteUITests: XCTestCase {
    var tester = CreateNoteTester(app: XCUIApplication())

    override func setUpWithError() throws {
        continueAfterFailure = false
        tester.reset()
    }

    override func tearDownWithError() throws {

    }

    func testCreateNote_Success() throws {
        tester.createNote()
    }

    func testCreateNote_Fail() throws {
        tester.showError()
    }
}
