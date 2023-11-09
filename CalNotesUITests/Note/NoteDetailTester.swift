//
//  NoteDetailTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

class NoteDetailTester: UITester {
    let app: XCUIApplication
    lazy var navigationBarBackButton = app.navigationBars.buttons.element(boundBy: 0)
    lazy var root = app.otherElements["noteDetail"]
    lazy var createNoteItemButton = app.buttons["createNoteItemButton"]
    lazy var navigationBarMenu = app.navigationBars.buttons["noteDetailMenu"]
    lazy var editNoteTitleButton = app.buttons["editNoteTitleButton"]
    lazy var deleteNoteButton = app.buttons["deleteNoteButton"]
    lazy var editNoteTitleForm = app.otherElements["createNoteForm"]
    lazy var noteItemList = app.otherElements["noteItemList"]
    lazy var noteItemListRow = app.otherElements["listRow"].firstMatch
    lazy var noteItemListRowDeleteButton = noteItemList.buttons["listRowDeleteButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var noteItemListRowCloneButton = noteItemList.buttons["listRowCloneButton"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    lazy var noteItemForm = app.otherElements["noteItemForm"]

    required init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func enterPage() {
        let tester = NoteListTester(app: app)
        tester.tapCreateNote()
        tester.completeCreateNote()
    }

    func isEnteredPage() -> Bool {
        return root.waitForExistence(timeout: 0.5)
    }

    func tapBack() {
        navigationBarBackButton.tap()
    }

    func isNoteItemExist() -> Bool {
        return noteItemListRow.waitForExistence(timeout: 0.5)
    }

    func enterCreateNoteItemForm() {
        createNoteItemButton.tap()
    }

    func completeFoodForm() {
        NoteItemFormTester(app: app).completeFoodForm()
    }

    func enterUpdateNoteItemForm() {
        noteItemListRow.tap()
    }

    func isEnteredNoteItemForm() -> Bool {
        return noteItemForm.waitForExistence(timeout: 0.5)
    }

    func isEnteredEditNoteTitle() -> Bool {
        return editNoteTitleForm.waitForExistence(timeout: 0.5)
    }

    func tapEditNoteTitle() {
        navigationBarMenu.tap()
        editNoteTitleButton.tap()
    }

    func completeEditNoteTitle() {
        CreateNoteTester(app: app).completeForm()
    }

    func tapDeleteNote() {
        navigationBarMenu.tap()
        deleteNoteButton.tap()
    }

    func tapDeleteNoteItem() {
        noteItemListRow.swipeLeft()
        noteItemListRowDeleteButton.tap()
    }

    func tapCloneNoteItem() {
        noteItemListRow.swipeLeft()
        noteItemListRowCloneButton.tap()
    }
}
