//
//  FormTitle.swift
//  FormEngineSwiftUI
//
//  Created by Jacky Lam on 2023-04-23.
//

import SwiftUI

struct FormTitle: View {
    var title: String

    var body: some View {
        FormView(
            title: title,
            message: .constant(""),
            messageType: .info,
            content: { EmptyView() }
        )
    }
}

struct FormTitle_Previews: PreviewProvider {
    static var previews: some View {
        FormTitle(title: "Title")
            .previewLayout(.sizeThatFits)
    }
}
