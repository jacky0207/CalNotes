//
//  NoteDetailTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

class NoteDetailTester {
    let app: XCUIApplication
    lazy var navigationBarBackButton = app.navigationBars.buttons.element(boundBy: 0)
    lazy var noteListTester = NoteListTester(app: app)
    lazy var root = noteListTester.noteDetail
    lazy var createNoteItemButton = app.buttons["createNoteItemButton"]
    lazy var navigationBarMenu = app.navigationBars.buttons["noteDetailMenu"]
    lazy var editNoteTitleButton = app.buttons["editNoteTitleButton"]
    lazy var deleteNoteButton = app.buttons["deleteNoteButton"]
    lazy var editNoteTitleForm = app.otherElements["createNoteForm"]
    lazy var noteItemList = root.otherElements["noteItemList"]
    lazy var noteItemListRow = root.otherElements["listRow"].firstMatch
    lazy var noteItemListRowDeleteButton = noteItemList.buttons["listRowDeleteButton"]
    lazy var noteItemListRowCloneButton = noteItemList.buttons["listRowCloneButton"]
    lazy var noteItemForm = app.otherElements["noteItemForm"]

    init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func editNoteTitle() {
        noteListTester.enterNoteDetail()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        navigationBarMenu.tap()
        editNoteTitleButton.tap()
        XCTAssertTrue(editNoteTitleForm.waitForExistence(timeout: 0.5))
        let tester = CreateNoteTester(app: app)
        tester.updateNote()
        XCTAssertFalse(editNoteTitleForm.waitForExistence(timeout: 0.5))
    }

    func deleteNote() {
        noteListTester.enterNoteDetail()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        navigationBarMenu.tap()
        deleteNoteButton.tap()
        XCTAssertFalse(root.waitForExistence(timeout: 0.5))
    }

    func enterCreateNoteItemForm() {
        noteListTester.enterNoteDetail()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        createNoteItemButton.tap()
        XCTAssertTrue(noteItemForm.waitForExistence(timeout: 0.5))
    }

    func enterUpdateNoteItemForm() {
        let tester = NoteItemFormTester(app: app)
        tester.createFoodNoteItem()
        XCTAssertTrue(root.waitForExistence(timeout: 0.5))
        noteItemListRow.tap()
        XCTAssertTrue(noteItemForm.waitForExistence(timeout: 0.5))
    }

    func deleteNoteItem() {
        XCTAssertFalse(noteItemListRow.waitForExistence(timeout: 0.5))
        let tester = NoteItemFormTester(app: app)
        tester.createFoodNoteItem()
        XCTAssertTrue(noteItemListRow.waitForExistence(timeout: 0.5))
        noteItemListRow.swipeLeft()
        noteItemListRowDeleteButton.tap()
        XCTAssertFalse(noteItemListRow.waitForExistence(timeout: 0.5))
    }

    func cloneNoteItem() {
        XCTAssertFalse(noteItemListRow.waitForExistence(timeout: 0.5))
        let tester = NoteItemFormTester(app: app)
        tester.createFoodNoteItem()
        XCTAssertTrue(noteItemListRow.waitForExistence(timeout: 0.5))
        noteItemListRow.swipeLeft()
        noteItemListRowCloneButton.tap()
        XCTAssertTrue(noteItemListRow.waitForExistence(timeout: 0.5))
        noteItemListRow.swipeLeft()
        noteItemListRowDeleteButton.tap()
        XCTAssertTrue(noteItemListRow.waitForExistence(timeout: 0.5))
        noteItemListRow.swipeLeft()
        noteItemListRowDeleteButton.tap()
        XCTAssertFalse(noteItemListRow.waitForExistence(timeout: 0.5))
    }
}
