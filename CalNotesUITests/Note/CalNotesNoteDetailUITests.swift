//
//  CalNotesNoteDetailUITests.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

final class CalNotesNoteDetailUITests: XCTestCase {
    var tester = NoteDetailTester(app: XCUIApplication())

    override func setUpWithError() throws {
        continueAfterFailure = false
        tester.reset()
    }

    override func tearDownWithError() throws {

    }

    func testNoteDetail_EditNoteTitle() throws {
        tester.editNoteTitle()
    }

    func testNoteDetail_DeleteNote() throws {
        tester.deleteNote()
    }

    func testNoteDetail_EnterCreateNoteItemForm() throws {
        tester.enterCreateNoteItemForm()
    }

    func testNoteDetail_EnterUpdateNoteDetailForm() throws {
        tester.enterUpdateNoteItemForm()
    }

    func testNoteDetail_DeleteNoteItem() throws {
        tester.deleteNoteItem()
    }

    func testNoteDetail_CloneNoteItem() throws {
        tester.cloneNoteItem()
    }
}
