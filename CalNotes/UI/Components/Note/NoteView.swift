//
//  NoteView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

struct NoteView: View {
    var note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: Dimen.spacing(.small)) {
            NoteTitleView(note.title)
            NoteSumView(note.sum)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .stackStyle(StackStyle.Note())
    }
}

struct NoteTitleView: View {
    var title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .textStyle(TextStyle.ItemTitle())
    }
}

struct NoteSumView: View {
    var sum: Float

    init(_ sum: Float) {
        self.sum = sum
    }

    var body: some View {
        HStack(alignment: .center, spacing: Dimen.spacing(.xSmall)) {
            Image("coin")
                .resizable()
                .imageStyle(ImageStyle.Icon())
            Text(String(format: "%.2f", sum))
                .textStyle(TextStyle.ItemText())
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: ModelData().note)
    }
}
