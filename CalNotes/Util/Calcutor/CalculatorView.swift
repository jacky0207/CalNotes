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

    var body: some View {
        VStack(spacing: spanSpacing) {
            Text(sum)
                .frame(maxWidth: 350, alignment: .trailing)
                .padding(.horizontal, 16)
                .foregroundColor(CalculatorColor.white)
                .font(Font.system(size: 48))
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
                CalculatorDigitButton(digit: .seven) { digit in

                }
                CalculatorDigitButton(digit: .eight) { digit in

                }
                CalculatorDigitButton(digit: .nine) { digit in

                }
                CalculatorOperatorButton(operator: .multiply) { digit in

                }
            }
            HStack(spacing: spanSpacing) {
                CalculatorDigitButton(digit: .four) { digit in

                }
                CalculatorDigitButton(digit: .five) { digit in

                }
                CalculatorDigitButton(digit: .six) { digit in

                }
                CalculatorOperatorButton(operator: .minus) { digit in

                }
            }
            HStack(spacing: spanSpacing) {
                CalculatorDigitButton(digit: .one) { digit in

                }
                CalculatorDigitButton(digit: .two) { digit in

                }
                CalculatorDigitButton(digit: .three) { digit in

                }
                CalculatorOperatorButton(operator: .plus) { digit in

                }
            }
            HStack(spacing: spanSpacing) {
                CalculatorDigitButton(digit: .zero, span: 2, spanSpacing: spanSpacing) { digit in

                }
                CalculatorDigitButton(digit: .dot) { digit in

                }
                CalculatorOperatorButton(operator: .equal) { digit in

                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16)
        .background(CalculatorColor.black)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorView(sum: .constant("0"))
                .previewLayout(.sizeThatFits)
        }
    }
}
