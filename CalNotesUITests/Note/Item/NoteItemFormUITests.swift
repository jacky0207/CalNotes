//
//  NoteItemFormUITests.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

final class NoteItemFormUITests: XCTestCase {
    var tester = NoteItemFormTester(app: XCUIApplication())

    override func setUpWithError() throws {
        continueAfterFailure = false
        tester.reset()
        tester.enterPage()
    }

    override func tearDownWithError() throws {

    }

    func testNoteItemForm_CreateFoodItem_Success() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.completeFoodForm()
        XCTAssertFalse(tester.isEnteredPage())
    }

    func testNoteItemForm_CreateTransportationItem_Success() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.completeTransportationForm()
        XCTAssertFalse(tester.isEnteredPage())
    }

    func testNoteItemForm_Fail() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.tapSubmit()
        XCTAssertTrue(tester.isEnteredPage())
    }
}
