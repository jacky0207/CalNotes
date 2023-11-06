//
//  CalNotesNoteItemFormUITests.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

final class CalNotesNoteItemFormUITests: XCTestCase {
    var tester = NoteItemFormTester(app: XCUIApplication())

    override func setUpWithError() throws {
        continueAfterFailure = false
        tester.reset()
    }

    override func tearDownWithError() throws {

    }

    func testNoteItemForm_CreateFoodItem_Success() throws {
        tester.createFoodNoteItem()
    }

    func testNoteItemForm_CreateTransportationItem_Success() throws {
        tester.createTransportationNoteItem()
    }

    func testNoteItemForm_Fail() throws {
        tester.showError()
    }
}
