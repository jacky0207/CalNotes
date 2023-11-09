//
//  NoteItemFormTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

class NoteItemFormTester: UITester {
    let app: XCUIApplication
    lazy var deleteKey = app.keys["Delete"]
    lazy var root = app.otherElements["noteItemForm"]
    lazy var categoryPicker = app.otherElements["categoryField"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var titleField = app.otherElements["titleField"].textFields["content"]
    lazy var amountField = app.otherElements["amountField"].textFields["content"]
    lazy var quantityField = app.otherElements["quantityField"].textFields["content"]
    lazy var quantityUnitField = app.otherElements["quantityUnitField"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var submitButton = app.buttons["submitNoteItemFormButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))

    required init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func enterPage() {
        let noteDetailTester = NoteDetailTester(app: app)
        noteDetailTester.enterPage()
        noteDetailTester.enterCreateNoteItemForm()
    }

    func isEnteredPage() -> Bool {
        return root.waitForExistence(timeout: 0.5)
    }

    func tapFoodCategory() {
        categoryPicker.tap()
        app.buttons["Food"].tap()
    }

    func tapTransportationCategory() {
        categoryPicker.tap()
        app.buttons["Transport"].tap()
    }

    func typeTitle() {
        titleField.tap()
        titleField.typeText("Title")
    }

    func typeAmount() {
        amountField.tap()
        amountField.typeText("1")
    }

    func typeQuantity() {
        quantityField.tap()
        quantityField.typeText("1")
    }

    func tapQuantityUnit() {
        quantityUnitField.tap()
        app.buttons["kg"].tap()
    }

    func tapSubmit() {
        if app.keys.element(boundBy: 0).exists {
            app.typeText("\n")
        }
        submitButton.tap()
    }
}

// MARK: - Form
extension NoteItemFormTester {
    func completeFoodForm() {
        tapFoodCategory()
        typeTitle()
        typeAmount()
        tapQuantityUnit()
        tapSubmit()
    }

    func completeTransportationForm() {
        tapTransportationCategory()
        typeTitle()
        typeAmount()
        tapSubmit()
    }
}
