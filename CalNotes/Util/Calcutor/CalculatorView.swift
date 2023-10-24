//
//  CalculatorView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//

import SwiftUI

struct CalculatorView: View {
    @Binding var sum: String
    private let spanSpacing: CGFloat = 16.0
    private let maxLength = 16

    enum CalculationState {
        case idle
        case progress
    }
    private var state: CalculationState = .idle
    private var `operator`: CalculatorOperator = .equal
    @State private var operatorNumber: String = ""

    init(sum: Binding<String>) {
        self._sum = sum
    }

    var body: some View {
        VStack(spacing: spanSpacing) {
            Text(sum)
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
                CalculatorFunctionButton(function: .allClear, sum: sum) { function in

                }
                CalculatorFunctionButton(function: .delete) { function in

                }
                CalculatorFunctionButton(function: .percentage) { function in

                }
                CalculatorOperatorButton(operator: .divide) { digit in

                }
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
                CalculatorOperatorButton(operator: .multiply) { digit in

                }
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
                CalculatorOperatorButton(operator: .minus) { digit in

                }
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
                CalculatorOperatorButton(operator: .plus) { digit in

                }
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
                CalculatorOperatorButton(operator: .equal) { digit in

                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16)
        .background(CalculatorColor.black)
        .onAppear {
            // clear sum if initial value is not valid
            if Float(sum) == nil {
                sum = "0"
            }
        }
    }

    func appendDigit(_ digit: CalculatorDigit) {
        switch state {
        case .idle:
            if digit == .zero, sum == "0" {
                break
            } else if digit == .dot, sum.contains(CalculatorDigit.dot.text) {
                break
            }
            sum = sum == "0" && digit != .dot ? digit.text : sum + digit.text
        case .progress:
            if digit == .zero, operatorNumber == "0" {
                break
            } else if digit == .dot, operatorNumber.contains(CalculatorDigit.dot.text) {
                break
            }
            operatorNumber = operatorNumber == "0" && digit != .dot ? digit.text : operatorNumber + digit.text
        }
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
