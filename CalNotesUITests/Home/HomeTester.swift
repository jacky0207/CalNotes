//
//  HomeTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

class HomeTester {
    let app: XCUIApplication
    lazy var navigationBarBackButton = app.navigationBars.buttons.element(boundBy: 0)
    lazy var root = app
    lazy var noteListButton = root.buttons["noteListButton"]
    lazy var noteList = root.otherElements["noteList"]
    lazy var noteTrashButton = root.buttons["noteTrashButton"]
    lazy var noteTrash = root.otherElements["noteTrash"]

    init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func enterNoteList() {
        navigationBarBackButton.tap()
        XCTAssertFalse(noteList.waitForExistence(timeout: 0.5))
        noteListButton.tap()
        XCTAssertTrue(noteList.waitForExistence(timeout: 0.5))
    }

    func enterNoteTrash() {
        navigationBarBackButton.tap()
        XCTAssertFalse(noteTrash.waitForExistence(timeout: 0.5))
        noteTrashButton.tap()
        XCTAssertTrue(noteTrash.waitForExistence(timeout: 0.5))
    }
}
