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
    lazy var categoryPicker = root.otherElements["categoryField"].otherElements["content"]
    lazy var titleField = root.otherElements["titleField"].textFields.firstMatch
    lazy var amountField = root.otherElements["amountField"].textFields.firstMatch
    lazy var quantityField = root.otherElements["quantityField"].textFields.firstMatch
    lazy var quantityUnitField = root.otherElements["quantityUnitField"].otherElements["content"]
    lazy var submitButton = app.buttons["submitNoteItemFormButton"]

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
        XCTAssertTrue(categoryPicker.waitForExistence(timeout: 0.5))
        categoryPicker.tap()
        app.buttons["Food"].tap()
        titleField.tap()
        titleField.typeText("Title")
        amountField.tap()
        amountField.typeText("1")
        quantityField.tap()
        quantityField.typeText("1")
        quantityUnitField.tap()
        app.buttons["kg"].tap()
        submitButton.tap()
        XCTAssertFalse(root.waitForExistence(timeout: 0.5))
    }

    func showError() {
        noteDetailTester.enterCreateNoteItemForm()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        XCTAssertTrue(categoryPicker.waitForExistence(timeout: 0.5))
        submitButton.tap()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
    }

    func createTransportationNoteItem() {
        noteDetailTester.enterCreateNoteItemForm()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        XCTAssertTrue(categoryPicker.waitForExistence(timeout: 0.5))
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
