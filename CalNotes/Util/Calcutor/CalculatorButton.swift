//
//  CalculatorButton.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

enum CalculatorDigit {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case dot
}

extension CalculatorDigit {
    var text: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .dot:
            return "."
        }
    }
}

struct CalculatorDigitButton: View {
    var digit: CalculatorDigit
    var span: Int = 1
    var spanSpacing: CGFloat = 0
    var action: (CalculatorDigit) -> Void

    var body: some View {
        Button(action: { action(digit) }) {
            Text(digit.text)
        }
        .buttonStyle(CalculatorButtonStyle(type: .digit, span: span, spanSpacing: spanSpacing))
    }
}

enum CalculatorOperator {
    case plus
    case minus
    case multiply
    case divide
    case equal
}

extension CalculatorOperator {
    var image: Image {
        switch self {
        case .plus:
            return Image(systemName: "plus")
        case .minus:
            return Image(systemName: "minus")
        case .multiply:
            return Image(systemName: "multiply")
        case .divide:
            return Image(systemName: "divide")
        case .equal:
            return Image(systemName: "equal")
        }
    }
}

struct CalculatorOperatorButton: View {
    var `operator`: CalculatorOperator
    var action: (CalculatorOperator) -> Void

    var body: some View {
        Button(action: { action(`operator`) }) {
            `operator`.image
        }
        .buttonStyle(CalculatorButtonStyle(type: .operator))
    }
}

enum CalculatorFunction {
    case allClear
    case delete
    case percentage
}

extension CalculatorFunction {
    func view(sum: String) -> some View {
        switch self {
        case .allClear:
            return AnyView(Text(sum == "0" ? "AC" : "C"))
        case .delete:
            return AnyView(Image(systemName: "delete.backward"))
        case .percentage:
            return AnyView(Text("%"))
        }
    }
}

struct CalculatorFunctionButton: View {
    var function: CalculatorFunction
    var sum: String = "0"
    var action: (CalculatorFunction) -> Void

    var body: some View {
        Button(action: { action(function) }) {
            function.view(sum: sum)
        }
        .buttonStyle(CalculatorButtonStyle(type: .function))
    }
}

struct CalculatorDigitButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorDigitButton(digit: .one) { _ in

            }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Digit Button")

            CalculatorOperatorButton(operator: .plus) { _ in

            }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Operator Button")

            CalculatorFunctionButton(function: .allClear, sum: "1") { _ in

            }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Function Button")
        }
    }
}
