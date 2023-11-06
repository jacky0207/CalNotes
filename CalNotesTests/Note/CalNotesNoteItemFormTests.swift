//
//  CalNotesNoteItemFormTests.swift
//  CalNotesTests
//
//  Created by Jacky Lam on 2023-11-05.
//

import XCTest
@testable import CalNotes

final class CalNotesNoteItemFormTests: XCTestCase {
    var tester = NoteItemFormTester()

    override func setUpWithError() throws {
        try super.setUpWithError()
        tester.reset()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        tester.reset()
    }

    func testCreateNoteForm_QuantityEnabled_Valid() throws {
        tester.fillInTransportationForm()
        XCTAssertTrue(tester.form.isValid())
        tester.form.validate()
        XCTAssertTrue(tester.form.category.errorMessage.isEmpty)
        XCTAssertTrue(tester.form.title.errorMessage.isEmpty)
        XCTAssertTrue(tester.form.amount.errorMessage.isEmpty)
        XCTAssertTrue(tester.form.category.errorMessage.isEmpty)
    }

    func testCreateNoteForm_CategoryNotSelected_NotValid() throws {
        tester.fillInTransportationForm()
        tester.form.category.value = -1
        XCTAssertFalse(tester.form.isValid())
        tester.form.validate()
        XCTAssertFalse(tester.form.category.errorMessage.isEmpty)
    }

    func testCreateNoteForm_TitleNotEntered_NotValid() throws {
        tester.fillInTransportationForm()
        tester.form.title.value = ""
        XCTAssertFalse(tester.form.isValid())
        tester.form.validate()
        XCTAssertFalse(tester.form.title.errorMessage.isEmpty)
    }

    func testCreateNoteForm_AmountNotValid_NotValid() throws {
        tester.fillInTransportationForm()
        tester.form.amount.value = "a"
        XCTAssertFalse(tester.form.isValid())
        tester.form.validate()
        XCTAssertFalse(tester.form.amount.errorMessage.isEmpty)
    }

    func testCreateNoteForm_QuantityEnabled_NotValid() throws {
        tester.fillInDollarForm()
        tester.form.quantity.value = "a"
        XCTAssertFalse(tester.form.isValid())
        tester.form.validate()
        XCTAssertFalse(tester.form.quantity.errorMessage.isEmpty)
    }
}
