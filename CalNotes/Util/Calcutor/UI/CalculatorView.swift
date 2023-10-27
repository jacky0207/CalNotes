//
//  CalculatorView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var calculator: SumTextCalculator
    private let spanSpacing: CGFloat = 16.0
    private let maxLength = 16

    init(
        sum: String,
        onChange: @escaping (String) -> Void
    ) {
        self._calculator = StateObject(wrappedValue: SumTextCalculator(sum: sum, onChange: onChange))
    }

    var body: some View {
        VStack(spacing: spanSpacing) {
            calculationText()
            HStack(spacing: spanSpacing) {
                functionButton(calculator.isDigitInputted ? .clear : .allClear)
                functionButton(.delete)
                functionButton(.percentage)
                operatorButton(.divide)
            }
            HStack(spacing: spanSpacing) {
                digitButton(.seven)
                digitButton(.eight)
                digitButton(.nine)
                operatorButton(.multiply)
            }
            HStack(spacing: spanSpacing) {
                digitButton(.four)
                digitButton(.five)
                digitButton(.six)
                operatorButton(.minus)
            }
            HStack(spacing: spanSpacing) {
                digitButton(.one)
                digitButton(.two)
                digitButton(.three)
                operatorButton(.plus)
            }
            HStack(spacing: spanSpacing) {
                digitButton(.zero, span: 2)
                digitButton(.dot)
                operatorButton(.equal)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16)
        .background(CalculatorColor.black)
    }

    func calculationText() -> some View {
        Text(calculator.text)
            .frame(maxWidth: 350, alignment: .trailing)
            .textStyle(CalculatorText())
            .onChange(of: calculator.text) { text in
                if text.count > maxLength {
                    calculator.text = String(text.prefix(maxLength))
                }
            }
    }

    func digitButton(_ type: CalculatorDigit, span: Int = 1) -> some View {
        CalculatorButton(
            type: .digit(type),
            span: span,
            spanSpacing: spanSpacing,
            action: calculator.pressButton
        )
    }

    func operatorButton(_ type: CalculatorOperator) -> some View {
        CalculatorButton(
            type: .operator(type),
            isSelected: calculator.isOperatorSelected(type),
            action: calculator.pressButton
        )
    }

    func functionButton(_ type: CalculatorFunction) -> some View {
        CalculatorButton(
            type: .function(type),
            action: calculator.pressButton
        )
    }
}

struct CalculatorTestView: View {
    @State private var sum = "abc"

    var body: some View {
        VStack {
            Text("Sum: \(sum)")
            CalculatorView(
                sum: sum,
                onChange: { sum in
                    self.sum = sum
                }
            )
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorTestView()
                .previewLayout(.sizeThatFits)
        }
    }
}
