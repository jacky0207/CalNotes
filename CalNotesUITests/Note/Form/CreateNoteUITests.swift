//
//  CreateNoteUITests.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-08-27.
//

import XCTest

final class CreateNoteUITests: XCTestCase {
    var tester = CreateNoteTester(app: XCUIApplication())

    override func setUpWithError() throws {
        continueAfterFailure = false
        tester.reset()
        tester.enterPage()
    }

    override func tearDownWithError() throws {

    }

    func testCreateNote_Success() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.completeForm()
        XCTAssertFalse(tester.isEnteredPage())
    }

    func testCreateNote_Fail() throws {
        XCTAssertTrue(tester.isEnteredPage())
        tester.tapSubmit()
        XCTAssertTrue(tester.isEnteredPage())
    }
}
