//
//  CalNotesNoteTrashUITests.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

final class CalNotesNoteTrashUITests: XCTestCase {
    var tester = NoteTrashTester(app: XCUIApplication())

    override func setUpWithError() throws {
        continueAfterFailure = false
        tester.reset()
        tester.enterPage()
    }

    override func tearDownWithError() throws {

    }

    func testNoteTrash_EnterNoteDetail() throws {
        XCTAssertTrue(tester.isEnteredPage())
        XCTAssertTrue(tester.isNoteTrashRowExist())
        tester.tapTrashRow()
        XCTAssertTrue(tester.isNoteDetailExist())
    }

    func testNoteTrash_DeleteAllNotes() throws {
        XCTAssertTrue(tester.isEnteredPage())
        XCTAssertTrue(tester.isNoteTrashRowExist())
        tester.tapDeleteAllNotes()
        XCTAssertFalse(tester.isNoteTrashRowExist())
    }

    func testNoteTrash_DeleteNote() throws {
        XCTAssertTrue(tester.isEnteredPage())
        XCTAssertTrue(tester.isNoteTrashRowExist())
        tester.tapDeleteRow()
        XCTAssertFalse(tester.isNoteTrashRowExist())
    }

    func testNoteTrash_RecoverNote() throws {
        XCTAssertTrue(tester.isEnteredPage())
        XCTAssertTrue(tester.isNoteTrashRowExist())
        tester.tapRecoverRow()
        XCTAssertFalse(tester.isNoteTrashRowExist())
    }
}
