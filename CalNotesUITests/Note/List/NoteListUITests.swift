//
//  NoteListUITests.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-05.
//

import XCTest

final class NoteListUITests: XCTestCase {
    var tester = NoteListTester(app: XCUIApplication())

    override func setUpWithError() throws {
        continueAfterFailure = false
        tester.reset()
    }

    override func tearDownWithError() throws {

    }

    func testNoteList_EnterCreateNote() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.tapCreateNote()
        XCTAssertTrue(tester.isEnteredCreateNoteForm())
    }

    func testNoteList_EnterNoteDetail() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.tapCreateNote()
        tester.completeCreateNote()
        XCTAssertTrue(tester.isEnteredNoteDetail())
    }

    func testNoteList_DeleteNote() throws {
        XCTAssertFalse(tester.isNoteListRowExist())
        tester.tapCreateNote()
        tester.completeCreateNote()
        tester.tapBack()
        XCTAssertTrue(tester.isNoteListRowExist())
        tester.tapRowDelete()
        XCTAssertFalse(tester.isNoteListRowExist())
    }

    func testNoteList_CloneNote() throws {
        XCTAssertFalse(tester.isNoteListRowExist())
        tester.tapCreateNote()
        tester.completeCreateNote()
        tester.tapBack()
        XCTAssertTrue(tester.isNoteListRowExist())
        tester.tapRowClone()
        tester.tapBack()
        XCTAssertTrue(tester.isNoteListRowExist())
        tester.tapRowDelete()
        XCTAssertTrue(tester.isNoteListRowExist())
        tester.tapRowDelete()
        XCTAssertFalse(tester.isNoteListRowExist())
    }
}
