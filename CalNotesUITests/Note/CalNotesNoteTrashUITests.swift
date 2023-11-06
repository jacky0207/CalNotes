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
    }

    override func tearDownWithError() throws {

    }

    func testNoteTrash_EnterNoteDetail() throws {
        tester.enterNoteDetail()
    }

    func testNoteTrash_DeleteAllNotes() throws {
        tester.deleteAllNotes()
    }

    func testNoteTrash_DeleteNote() throws {
        tester.deleteNote()
    }

    func testNoteTrash_RecoverNote() throws {
        tester.recoverNote()
    }
}
