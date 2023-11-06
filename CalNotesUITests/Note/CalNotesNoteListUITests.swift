//
//  CalNotesNoteListUITests.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-05.
//

import XCTest

final class CalNotesNoteListUITests: XCTestCase {
    var tester = NoteListTester(app: XCUIApplication())

    override func setUpWithError() throws {
        continueAfterFailure = false
        tester.reset()
    }

    override func tearDownWithError() throws {

    }

    func testNoteList_EnterCreateNote() throws {
        tester.enterCreateNoteForm()
    }

    func testNoteList_EnterNoteDetail() throws {
        tester.enterNoteDetail()
    }

    func testNoteList_DeleteNote() throws {
        tester.deleteNote()
    }

    func testNoteList_CloneNote() throws {
        tester.cloneNote()
    }
}
