//
//  CalNotesCreateNoteFormTests.swift
//  CalNotesTests
//
//  Created by Jacky Lam on 2023-11-05.
//

import XCTest
@testable import CalNotes

final class CalNotesCreateNoteFormTests: XCTestCase {
    var form: CreateNoteForm.LocalForm = .none

    override func setUpWithError() throws {
        try super.setUpWithError()
        form = .none
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        form = .none
    }

    func testCreateNoteForm_Valid() throws {
        form.title = "Title"
        XCTAssertTrue(form.isValid())
    }

    func testCreateNoteForm_Empty_NotValid() throws {
        form.title = ""
        XCTAssertFalse(form.isValid())
    }
}
