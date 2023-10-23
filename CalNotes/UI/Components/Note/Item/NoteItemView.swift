//
//  NoteItemView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-08-28.
//

import SwiftUI

struct NoteItemView: View {
    var item: NoteItem
    
    var body: some View {
        HStack(spacing: Dimen.spacing(.normal)) {
            NoteItemTitleView(
                item.title,
                category: NoteItemCategory(rawValue: item.category)
            )
            NoteItemStateView(
                title: item.title,
                image: item.image == nil ? nil : UIImage(data: item.image!),
                remarks: item.remarks
            )
            Spacer()
            NoteItemSumView(item.amount)
        }
        .stackStyle(StackStyle.NoteItem())
    }
}

struct NoteItemTitleView: View {
    var title: String
    var category: NoteItemCategory?

    init(_ title: String, category: NoteItemCategory?) {
        self.title = title
        self.category = category
    }

    var body: some View {
        HStack(spacing: Dimen.spacing(.normal)) {
            if let category = category {
                category.icon
                    .resizable()
                    .imageStyle(ImageStyle.Icon())
            }
            Text(title)
                .textStyle(TextStyle.ItemTitle())
        }
    }
}

struct NoteItemStateView: View {
    var title: String
    var image: UIImage?
    var remarks: String?

    var body: some View {
        HStack(spacing: Dimen.spacing(.small)) {
            imageButton()
            infoButton()
        }
    }

    func imageButton() -> some View {
        if let image = image {
            return AnyView(NavigationViewLink(
                destination: { ImagePreviewView(title: title, image: image) },
                label: imageLabel
            ))
        } else {
            return AnyView(EmptyView())
        }
    }

    func imageLabel() -> some View {
        Image("image")
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }

    func infoButton() -> some View {
        if let remarks = remarks, !remarks.isEmpty {
            return AnyView(Button(
                action: { infoAction(title: title, remarks: remarks) },
                label: infoLabel
            ))
        } else {
            return AnyView(EmptyView())
        }
    }

    func infoAction(title: String, remarks: String) {
        AppState.shared.setAlert(for: AlertParams(title: title, message: remarks))
    }

    func infoLabel() -> some View {
        Image("info")
            .resizable()
            .imageStyle(ImageStyle.Icon())
    }
}

struct NoteItemSumView: View {
    var amount: Float

    init(_ amount: Float) {
        self.amount = amount
    }

    var body: some View {
        Text(amount == 0 ? "free".localized() : "dollar_format".localized(with: [amount]))
            .textStyle(TextStyle.Medium())
    }
}

struct NoteItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoteItemView(item: ModelData().noteItem)
            NoteItemView(item: NoteItem(id: 0, noteId: 0, title: "", category: 0, amount: 0, remarks: nil))
                .previewDisplayName("Default")
            NoteItemView(item: NoteItem(id: 0, noteId: 0, title: "", category: 1, amount: 0, remarks: nil))
                .previewDisplayName("Free Item")
            NoteItemView(item: NoteItem(id: 0, noteId: 0, title: "", category: 0, amount: 0, image: Data(base64Encoded: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII="), remarks: "remarks"))
                .previewDisplayName("status Item")
        }
    }
}
