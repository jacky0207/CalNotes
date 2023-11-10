//
//  NoteListTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-05.
//

import XCTest

class NoteListTester: UITester {
    let app: XCUIApplication
    lazy var navigationBarBackButton = app.navigationBars.buttons.element(boundBy: 0)
    lazy var root = app.otherElements["noteList"]
    lazy var createNoteButton = app.buttons["createNoteButton"]
    lazy var createNoteForm = app.otherElements["createNoteForm"]
    lazy var noteList = app.otherElements["noteList"]
    lazy var noteListRow = app.otherElements["listRow"].firstMatch
    lazy var noteListRowDeleteButton = noteList.buttons["listRowDeleteButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var noteListRowCloneButton = noteList.buttons["listRowCloneButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var noteDetail = app.otherElements["noteDetail"]

    required init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func enterPage() {
        // default entered
    }

    func isEnteredPage() -> Bool {
        return root.waitForExistence(timeout: 0.5)
    }

    func tapBack() {
        navigationBarBackButton.tap()
    }

    func isEnteredCreateNoteForm() -> Bool {
        return createNoteForm.waitForExistence(timeout: 0.5)
    }

    func tapCreateNote() {
        createNoteButton.tap()
    }

    func completeCreateNote() {
        CreateNoteTester(app: app).completeForm()
    }

    func isEnteredNoteDetail() -> Bool {
        return noteDetail.waitForExistence(timeout: 0.5)
    }

    func enterNoteDetail() {
        noteListRow.tap()
    }

    func isNoteListRowExist() -> Bool {
        return noteListRow.waitForExistence(timeout: 0.5)
    }

    func tapRowDelete() {
        noteListRow.swipeLeft()
        noteListRowDeleteButton.tap()
    }

    func tapRowClone() {
        noteListRow.swipeLeft()
        noteListRowCloneButton.tap()
    }
}
