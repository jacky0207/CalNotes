//
//  NoteListTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-05.
//

import XCTest

class NoteListTester {
    let app: XCUIApplication
    lazy var navigationBarBackButton = app.navigationBars.buttons.element(boundBy: 0)
    lazy var root = app
    lazy var createNoteButton = root.buttons["createNoteButton"]
    lazy var createNoteForm = root.otherElements["createNoteForm"]
    lazy var noteList = root.otherElements["noteList"]
    lazy var noteListRow = app.otherElements["listRow"].firstMatch
    lazy var noteListRowDeleteButton = noteList.buttons["listRowDeleteButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var noteListRowCloneButton = noteList.buttons["listRowCloneButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var noteDetail = root.otherElements["noteDetail"]

    init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func enterCreateNoteForm() {
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        createNoteButton.tap()
        XCTAssertTrue(createNoteForm.waitForExistence(timeout: 0.5))
    }

    func enterNoteDetail() {
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        let tester = CreateNoteTester(app: app)
        tester.createNote()
        XCTAssertTrue(noteDetail.waitForExistence(timeout: 0.5))
    }

    func deleteNote() {
        XCTAssertFalse(noteListRow.waitForExistence(timeout: 0.5))
        enterNoteDetail()
        navigationBarBackButton.tap()
        XCTAssertTrue(noteListRow.waitForExistence(timeout: 0.5))
        noteListRow.swipeLeft()
        noteListRowDeleteButton.tap()
        XCTAssertFalse(noteListRow.waitForExistence(timeout: 0.5))
    }

    func cloneNote() {
        XCTAssertFalse(noteListRow.waitForExistence(timeout: 0.5))
        enterNoteDetail()
        navigationBarBackButton.tap()
        XCTAssertTrue(noteListRow.waitForExistence(timeout: 0.5))
        noteListRow.swipeLeft()
        noteListRowCloneButton.tap()
        navigationBarBackButton.tap()
        XCTAssertTrue(noteListRow.waitForExistence(timeout: 0.5))
        noteListRow.swipeLeft()
        noteListRowDeleteButton.tap()
        XCTAssertTrue(noteListRow.waitForExistence(timeout: 0.5))
        noteListRow.swipeLeft()
        noteListRowDeleteButton.tap()
        XCTAssertFalse(noteListRow.waitForExistence(timeout: 0.5))
    }
}
