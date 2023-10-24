//
//  CalculatorStyle.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

// add a initialiser by hex color
// https://stackoverflow.com/a/56894458/12208834
extension Color {
    fileprivate init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

struct CalculatorColor {
    private init() {}

    // colours
    static let gray = Color(hex: 0xa5a5a5)
    static let grayHighlight = Color(hex: 0xd9d9d9)

    static let darkGray = Color(hex: 0x333333)
    static let darkGrayHighlight = Color(hex: 0x737373)

    static let orange = Color(hex: 0xff9f06)
    static let orangeHighlight = Color(hex: 0xfcc88d)

    static let white = Color(.white)
    static let black = Color(.black)
}

enum CalculatorButton {
    case digit
    case `operator`
    case function
}

extension CalculatorButton {
    var foregroundColor: Color {
        switch self {
        case .digit:
            return CalculatorColor.white
        case .operator:
            return CalculatorColor.white
        case .function:
            return CalculatorColor.black
        }
    }
    var normalColor: Color {
        switch self {
        case .digit:
            return CalculatorColor.darkGray
        case .operator:
            return CalculatorColor.orange
        case .function:
            return CalculatorColor.gray
        }
    }

    var highlightColor: Color {
        switch self {
        case .digit:
            return CalculatorColor.darkGrayHighlight
        case .operator:
            return CalculatorColor.orangeHighlight
        case .function:
            return CalculatorColor.grayHighlight
        }
    }
}

struct CalculatorButtonStyle: ButtonStyle {
    var type: CalculatorButton
    var fontSize: CGFloat = 28
    var width: CGFloat = 40
    var padding: CGFloat = 20
    var span: Int = 1
    var spanSpacing: CGFloat = 0

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(type.foregroundColor)
            .font(Font.system(size: fontSize))
            .frame(width: width, height: width / 4)
            .padding(.trailing, (spanSpacing + width + padding * 2) * (CGFloat(span) - 1))
            .padding(.all, padding)
            .background(
                RoundedRectangle(cornerRadius: width/2 + padding)
                    .fill(configuration.isPressed ? type.highlightColor : type.normalColor )
            )
    }
}
