//
//  NoteTrashTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

class NoteTrashTester {
    let app: XCUIApplication
    lazy var navigationBarBackButton = app.navigationBars.buttons.element(boundBy: 0)
    lazy var homeTester = HomeTester(app: app)
    lazy var root = homeTester.noteTrash
    lazy var deleteAllNoteButton = app.buttons["deleteAllNoteButton"]
    lazy var deleteAllNoteForm = app.otherElements["deleteAllNoteForm"]
    lazy var deleteAllNoteSubmitButton = deleteAllNoteForm.buttons["submitButton"]
    lazy var noteTrashList = root.otherElements["noteTrashList"]
    lazy var noteTrashListRow = root.otherElements["listRow"].firstMatch
    lazy var noteTrashListRowDeleteButton = noteTrashList.buttons["listRowDeleteButton"]
    lazy var noteTrashListRowRecoverButton = noteTrashList.buttons["listRowRecoverButton"]
    lazy var noteDetail = app.otherElements["noteDetail"]

    init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func enterNoteDetail() {
        let noteListTester = NoteListTester(app: app)
        noteListTester.deleteNote()
        XCTAssertFalse(noteListTester.noteDetail.waitForExistence(timeout: 0.5))
        homeTester.enterNoteTrash()
        noteTrashListRow.tap()
        XCTAssertTrue(noteDetail.waitForExistence(timeout: 0.5))
    }

    func deleteAllNotes() {
        enterNoteDetail()
        navigationBarBackButton.tap()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        XCTAssertFalse(deleteAllNoteForm.waitForExistence(timeout: 0.5))
        XCTAssertTrue(noteTrashListRow.waitForExistence(timeout: 0.5))
        deleteAllNoteButton.tap()
        XCTAssertTrue(deleteAllNoteForm.waitForExistence(timeout: 0.5))
        deleteAllNoteSubmitButton.tap()
        XCTAssertFalse(deleteAllNoteForm.waitForExistence(timeout: 0.5))
        XCTAssertFalse(noteTrashListRow.waitForExistence(timeout: 0.5))
    }

    func deleteNote() {
        enterNoteDetail()
        navigationBarBackButton.tap()
        XCTAssertTrue(noteTrashListRow.waitForExistence(timeout: 0.5))
        noteTrashListRow.swipeLeft()
        noteTrashListRowDeleteButton.tap()
        XCTAssertFalse(noteTrashListRow.waitForExistence(timeout: 0.5))
    }

    func recoverNote() {
        enterNoteDetail()
        navigationBarBackButton.tap()
        XCTAssertTrue(noteTrashListRow.waitForExistence(timeout: 0.5))
        noteTrashListRow.swipeLeft()
        noteTrashListRowRecoverButton.tap()
        XCTAssertFalse(noteTrashListRow.waitForExistence(timeout: 0.5))
    }
}
