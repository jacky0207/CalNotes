//
//  SlashView.swift
//  NASA Data
//
//  Created by Jacky Lam on 2023-08-10.
//

import SwiftUI

struct SlashView: View {
    var body: some View {
        BodyView(
            title: "",
            content: content
        )
        .onAppear(perform: fadeOut)
    }

    func content() -> some View {
        Image("logo")
            .resizable()
            .imageStyle(ImageStyle.Logo())
    }
    
    func fadeOut() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) {
            withAnimation {
                AppState.shared.launchState = .main
            }
        }
    }
}

struct SlashView_Previews: PreviewProvider {
    static var previews: some View {
        SlashView()
    }
}
