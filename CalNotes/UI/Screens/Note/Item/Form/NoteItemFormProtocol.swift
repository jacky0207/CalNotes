//
//  NoteItemFormProtocol.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-27.
//

protocol NoteItemFormProtocol {
    var noteId: Int { get set }
    var noteItemId: Int? { get set }
    var form: NoteItemForm.LocalForm { get set }
    init(diContainer: DIContainer, noteId: Int, noteItemId: Int?)
    func getNoteItemDetail()
    func addNoteItem(completion: @escaping (NoteItemDetail) -> Void)
    func updateNoteItem(completion: @escaping (NoteItemDetail) -> Void)
}
