//
//  NoteTrashTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

class NoteTrashTester: UITester {
    let app: XCUIApplication
    lazy var navigationBarBackButton = app.navigationBars.buttons.element(boundBy: 0)
    lazy var root = app.otherElements["noteTrash"]
    lazy var deleteAllNoteButton = app.buttons["deleteAllNoteButton"]
    lazy var deleteAllNoteForm = app.otherElements["deleteAllNoteForm"]
    lazy var deleteAllNoteSubmitButton = deleteAllNoteForm.buttons["submitButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var noteTrashList = root.otherElements["noteTrashList"]
    lazy var noteTrashListRow = app.otherElements["listRow"].firstMatch
    lazy var noteTrashListRowDeleteButton = noteTrashList.buttons["listRowDeleteButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var noteTrashListRowRecoverButton = noteTrashList.buttons["listRowRecoverButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var noteDetail = app.otherElements["noteDetail"]

    required init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
        let noteListTester = NoteListTester(app: app)
        noteListTester.tapCreateNote()
        noteListTester.completeCreateNote()
        noteListTester.tapBack()
        noteListTester.tapRowDelete()
    }

    func enterPage() {
        let homeTester = HomeTester(app: app)
        homeTester.enterPage()
        homeTester.tapNoteTrash()
    }

    func isEnteredPage() -> Bool {
        return root.waitForExistence(timeout: 0.5)
    }

    func isNoteTrashRowExist() -> Bool {
        return noteTrashListRow.waitForExistence(timeout: 0.5)
    }

    func tapTrashRow() {
        noteTrashListRow.tap()
    }

    func isNoteDetailExist() -> Bool {
        return noteDetail.waitForExistence(timeout: 0.5)
    }

    func tapDeleteAllNotes() {
        deleteAllNoteButton.tap()
        deleteAllNoteSubmitButton.tap()
    }

    func tapDeleteRow() {
        noteTrashListRow.swipeLeft()
        noteTrashListRowDeleteButton.tap()
    }

    func tapRecoverRow() {
        noteTrashListRow.swipeLeft()
        noteTrashListRowRecoverButton.tap()
    }
}
