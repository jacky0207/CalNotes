//
//  NoteItemFormTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

class NoteItemFormTester {
    let app: XCUIApplication
    lazy var deleteKey = app.keys["Delete"]
    lazy var noteDetailTester = NoteDetailTester(app: app)
    lazy var root = noteDetailTester.noteItemForm
    lazy var categoryPicker = root.otherElements["categoryField"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var titleField = root.otherElements["titleField"].textFields["content"]
    lazy var amountField = root.otherElements["amountField"].textFields["content"]
    lazy var quantityField = root.otherElements["quantityField"].textFields["content"]
    lazy var quantityUnitField = root.otherElements["quantityUnitField"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var submitButton = app.buttons["submitNoteItemFormButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))

    init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func createFoodNoteItem() {
        noteDetailTester.enterCreateNoteItemForm()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        categoryPicker.tap()
        app.buttons["Food"].tap()
        titleField.tap()
        titleField.typeText("Title")
        amountField.tap()
        amountField.typeText("1")
        quantityField.tap()
        quantityField.typeText("1")
        XCTAssertTrue(root.otherElements["quantityUnitField"].waitForExistence(timeout: 0.5))
        quantityUnitField.tap()
        app.buttons["kg"].tap()
        submitButton.tap()
        XCTAssertFalse(root.waitForExistence(timeout: 0.5))
    }

    func showError() {
        noteDetailTester.enterCreateNoteItemForm()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        submitButton.tap()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
    }

    func createTransportationNoteItem() {
        noteDetailTester.enterCreateNoteItemForm()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        categoryPicker.tap()
        app.buttons["Transport"].tap()
        titleField.tap()
        titleField.typeText("Title")
        amountField.tap()
        amountField.typeText("1")
        submitButton.tap()
        XCTAssertFalse(root.waitForExistence(timeout: 0.5))
    }
}
