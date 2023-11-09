//
//  CreateNoteTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-05.
//

import XCTest

class CreateNoteTester: UITester {
    let app: XCUIApplication
    lazy var noteListTester = NoteListTester(app: app)
    lazy var root = noteListTester.createNoteForm
    lazy var titleField = app.otherElements["titleField"].textFields["content"]
    lazy var submitButton = app.buttons["submitButton"]

    required init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func enterPage() {
        noteListTester.tapCreateNote()
    }

    func isEnteredPage() -> Bool {
        return root.waitForExistence(timeout: 0.5)
    }

    func typeTitle() {
        titleField.tap()
        titleField.typeText("Weekly Spend")
    }

    func tapSubmit() {
        if app.keys.element(boundBy: 0).exists {
            app.typeText("\n")
        }
        submitButton.tap()
    }
}

// MARK: - Form
extension CreateNoteTester {
    func completeForm() {
        typeTitle()
        tapSubmit()
    }
}
