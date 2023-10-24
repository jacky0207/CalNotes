//
//  CalculatorView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

struct CalculatorView: View {
    static let zeroValue: String = "0"

    @Binding var sum: String
    private let spanSpacing: CGFloat = 16.0
    private let maxLength = 16

    enum CalculationState {
        case idle
        case progress
    }
    @State private var state: CalculationState = .idle
    @State private var cleanState: CalcalationCleanState = .allClean
    @State private var `operator`: CalculatorOperator = .equal
    @State private var operatorNumber: String = ""
    @State private var isOperatorNumberEdited: Bool = false

    init(sum: Binding<String>) {
        self._sum = sum
    }

    var text: String {
        get {
            switch state {
            case .idle:
                return sum
            case .progress:
                return operatorNumber
            }
        }
    }

    func text(_ text: String, concat digit: CalculatorDigit) -> String {
        if digit == .zero, text == CalculatorView.zeroValue {
            return text
        } else if digit == .dot, text.contains(CalculatorDigit.dot.text) {
            return text
        }
        return (text == CalculatorView.zeroValue && digit != .dot) ? digit.text : text + digit.text
    }

    func text(from sum: Float) -> String {
        return sum.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", sum) : String("\(NSNumber(value: sum).decimalValue)")
    }

    func setText(_ text: String) {
        let text = Float(text) == nil ? "0" : text
        switch state {
        case .idle:
            sum = text
        case .progress:
            operatorNumber = text
        }
    }

    func isOperatorSelected(_ operator: CalculatorOperator) -> Bool {
        return state == .progress
        && self.`operator` == `operator`
        && (!isOperatorNumberEdited || operatorNumber == CalculatorView.zeroValue)
    }

    var body: some View {
        VStack(spacing: spanSpacing) {
            Text(text)
                .frame(maxWidth: 350, alignment: .trailing)
                .padding(.horizontal, 16)
                .foregroundColor(CalculatorColor.white)
                .font(Font.system(size: 48))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .onChange(of: sum) { _ in
                    if sum.count > maxLength {
                        sum = String(sum.prefix(maxLength))
                    }
                }
            HStack(spacing: spanSpacing) {
                CalculatorFunctionButton(
                    function: .allClear,
                    cleanState: cleanState,
                    action: executeFunction
                )
                CalculatorFunctionButton(
                    function: .delete,
                    action: executeFunction
                )
                CalculatorFunctionButton(
                    function: .percentage,
                    action: executeFunction
                )
                CalculatorOperatorButton(
                    operator: .divide,
                    isSelected: isOperatorSelected(.divide),
                    action: proceedOperator
                )
            }
            HStack(spacing: spanSpacing) {
                CalculatorDigitButton(
                    digit: .seven,
                    action: appendDigit
                )
                CalculatorDigitButton(
                    digit: .eight,
                    action: appendDigit
                )
                CalculatorDigitButton(
                    digit: .nine,
                    action: appendDigit
                )
                CalculatorOperatorButton(
                    operator: .multiply,
                    isSelected: isOperatorSelected(.multiply),
                    action: proceedOperator
                )
            }
            HStack(spacing: spanSpacing) {
                CalculatorDigitButton(
                    digit: .four,
                    action: appendDigit
                )
                CalculatorDigitButton(
                    digit: .five,
                    action: appendDigit
                )
                CalculatorDigitButton(
                    digit: .six,
                    action: appendDigit
                )
                CalculatorOperatorButton(
                    operator: .minus,
                    isSelected: isOperatorSelected(.minus),
                    action: proceedOperator
                )
            }
            HStack(spacing: spanSpacing) {
                CalculatorDigitButton(
                    digit: .one,
                    action: appendDigit
                )
                CalculatorDigitButton(
                    digit: .two,
                    action: appendDigit
                )
                CalculatorDigitButton(
                    digit: .three,
                    action: appendDigit
                )
                CalculatorOperatorButton(
                    operator: .plus,
                    isSelected: isOperatorSelected(.plus),
                    action: proceedOperator
                )
            }
            HStack(spacing: spanSpacing) {
                CalculatorDigitButton(
                    digit: .zero,
                    span: 2,
                    spanSpacing: spanSpacing,
                    action: appendDigit
                )
                CalculatorDigitButton(
                    digit: .dot,
                    action: appendDigit
                )
                CalculatorOperatorButton(
                    operator: .equal,
                    action: proceedOperator
                )
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16)
        .background(CalculatorColor.black)
        .onAppear {
            // clear sum if initial value is not valid
            if Float(sum) == nil {
                sum = CalculatorView.zeroValue
            }
        }
    }

    func appendDigit(_ digit: CalculatorDigit) {
        if !isOperatorNumberEdited {
            setText(CalculatorView.zeroValue)  // 1st edit clear operator number first
            isOperatorNumberEdited = true
        }
        let newText = text(text, concat: digit)
        if newText == text {
            return
        }
        setText(newText)
        cleanState = .clean
    }

    func proceedOperator(_ operator: CalculatorOperator) {
        switch state {
        case .idle:
            if `operator` == .equal && self.`operator` != .equal {
                // redo last operation
                state = .progress
                proceedOperator(.equal)
            } else if `operator` != .equal {
                // select operator
                state = .progress
                self.`operator` = `operator`
                operatorNumber = sum  // default operator number = sum
                isOperatorNumberEdited = false
            }
        case .progress:
            if !isOperatorNumberEdited && `operator` != .equal {
                // change operator
                self.`operator` = `operator`
            } else {
                // calculate new sum
                state = .idle
                isOperatorNumberEdited = false
                let newSum = self.`operator`.calcuate(Float(sum)!, Float(operatorNumber)!)
                sum = text(from: newSum)
                if `operator` != .equal {
                    proceedOperator(`operator`)  // operator combo
                }
            }
        }
    }

    func executeFunction(_ function: CalculatorFunction) {
        switch function {
        case .allClear:
            executeAllClearFunction()
        case .delete:
            executeDeleteFunction()
        case .percentage:
            executePercentageFunction()
        }
    }

    func executeAllClearFunction() {
        switch cleanState {
        case .allClean:
            sum = CalculatorView.zeroValue
            state = .idle
            `operator` = .equal
            operatorNumber = ""
            isOperatorNumberEdited = false
        case .clean:
            cleanState = .allClean
            setText(CalculatorView.zeroValue)
        }
    }

    func executeDeleteFunction() {
        setText(String(text.dropLast()))
    }

    func executePercentageFunction() {
        isOperatorNumberEdited = false  // digit input will be clear after input digit
        setText(text(from: Float(text)! / 100))
    }
}

struct CalculatorTestView: View {
    @State private var sum = "abc"

    var body: some View {
        CalculatorView(sum: $sum)
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
