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
        tester.enterPage()
    }

    override func tearDownWithError() throws {

    }

    func testNoteDetail_EditNoteTitle() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.tapEditNoteTitle()
        XCTAssertTrue(tester.isEnteredEditNoteTitle())
        tester.completeEditNoteTitle()
        XCTAssertFalse(tester.isEnteredEditNoteTitle())
    }

    func testNoteDetail_DeleteNote() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.tapDeleteNote()
        XCTAssertFalse(tester.isEnteredPage())
    }

    func testNoteDetail_EnterCreateNoteItemForm() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.enterCreateNoteItemForm()
        XCTAssertTrue(tester.isEnteredNoteItemForm())
    }

    func testNoteDetail_EnterUpdateNoteDetailForm() throws {
        XCTAssertTrue(tester.isEnteredPage())
        XCTAssertFalse(tester.isNoteItemExist())
        tester.enterCreateNoteItemForm()
        tester.completeFoodForm()
        XCTAssertTrue(tester.isNoteItemExist())
        tester.enterUpdateNoteItemForm()
        XCTAssertTrue(tester.isEnteredNoteItemForm())
    }

    func testNoteDetail_DeleteNoteItem() throws {
        XCTAssertTrue(tester.isEnteredPage())
        XCTAssertFalse(tester.isNoteItemExist())
        tester.enterCreateNoteItemForm()
        tester.completeFoodForm()
        XCTAssertTrue(tester.isNoteItemExist())
        tester.tapDeleteNoteItem()
        XCTAssertFalse(tester.isNoteItemExist())
    }

    func testNoteDetail_CloneNoteItem() throws {
        XCTAssertTrue(tester.isEnteredPage())
        XCTAssertFalse(tester.isNoteItemExist())
        tester.enterCreateNoteItemForm()
        tester.completeFoodForm()
        XCTAssertTrue(tester.isNoteItemExist())
        tester.tapCloneNoteItem()
        tester.tapDeleteNoteItem()
        XCTAssertTrue(tester.isNoteItemExist())
        tester.tapDeleteNoteItem()
        XCTAssertFalse(tester.isNoteItemExist())
    }
}
