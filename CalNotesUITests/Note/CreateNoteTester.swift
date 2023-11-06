//
//  CreateNoteTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-05.
//

import XCTest

class CreateNoteTester {
    let app: XCUIApplication
    lazy var noteListTester = NoteListTester(app: app)
    lazy var root = noteListTester.createNoteForm
    lazy var titleField = root.otherElements["titleField"].textFields.firstMatch
    lazy var submitButton = root.buttons["submitButton"]

    init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func createNote() {
        noteListTester.enterCreateNoteForm()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        titleField.tap()
        titleField.typeText("Weekly Spend")
        submitButton.tap()
        XCTAssertFalse(root.waitForExistence(timeout: 0.5))
    }

    func updateNote() {
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        titleField.tap()
        titleField.typeText(" (2)")
        submitButton.tap()
        XCTAssertFalse(root.waitForExistence(timeout: 0.5))
    }

    func showError() {
        noteListTester.enterCreateNoteForm()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        titleField.tap()
        submitButton.tap()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
    }
}
