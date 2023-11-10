//
//  HomeTester.swift
//  CalNotesUITests
//
//  Created by Jacky Lam on 2023-11-06.
//

import XCTest

class HomeTester: UITester {
    let app: XCUIApplication
    lazy var navigationBarBackButton = app.navigationBars.buttons.element(boundBy: 0)
    lazy var root = app.otherElements["home"]
    lazy var noteListButton = app.buttons["noteListButton"]
    lazy var noteList = app.otherElements["noteList"]
    lazy var noteTrashButton = app.buttons["noteTrashButton"]
    lazy var noteTrash = app.otherElements["noteTrash"]

    required init(app: XCUIApplication) {
        self.app = app
        self.app.launchArguments = ["testing"]
    }

    func reset() {
        app.launch()
    }

    func enterPage() {
        navigationBarBackButton.tap()
    }

    func isEnteredPage() -> Bool {
        return root.waitForExistence(timeout: 0.5)
    }

    func isEnteredNoteList() -> Bool {
        return noteList.waitForExistence(timeout: 0.5)
    }

    func tapNoteList() {
        noteListButton.tap()
    }

    func isEnteredNoteTrash() -> Bool {
        return noteTrash.waitForExistence(timeout: 0.5)
    }

    func tapNoteTrash() {
        noteTrashButton.tap()
    }
}
