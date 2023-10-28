//
//  CalculatorStyle.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

//fileprivate extension View {
//    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
//        ModifiedContent(content: self, modifier: style)
//    }
//}
//
//extension Text {
//    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
//        ModifiedContent(content: self, modifier: style)
//    }
//}

struct CalculatorText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
            .foregroundColor(CalculatorColor.white)
            .font(Font.system(size: 48))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

struct CalculatorButtonStyle: ButtonStyle {
    var isSelected: Bool = false

    var type: CalculatorButtonType
    var fontSize: CGFloat = 28
    var width: CGFloat = 40
    var padding: CGFloat = 20
    var span: Int = 1
    var spanSpacing: CGFloat = 0

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelected ? type.foregroundSelectedColor : type.foregroundColor)
            .font(Font.system(size: fontSize))
            .frame(width: width, height: width / 4)
            .padding(.trailing, (spanSpacing + width + padding * 2) * (CGFloat(span) - 1))
            .padding(.all, padding)
            .background(
                RoundedRectangle(cornerRadius: width/2 + padding)
                    .fill(configuration.isPressed ? type.highlightColor : (isSelected ? type.selectedColor : type.normalColor) )
            )
    }
}
