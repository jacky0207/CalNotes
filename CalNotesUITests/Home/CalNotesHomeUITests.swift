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
        tester.enterPage()
    }

    override func tearDownWithError() throws {

    }

    func testHome_EnterNoteList() throws {
        XCTAssertFalse(tester.isEnteredNoteList())
        tester.tapNoteList()
        XCTAssertTrue(tester.isEnteredNoteList())
    }

    func testHome_EnterNoteTrash() throws {
        XCTAssertFalse(tester.isEnteredNoteTrash())
        tester.tapNoteTrash()
        XCTAssertTrue(tester.isEnteredNoteTrash())
    }
}
