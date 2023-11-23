//
//  ContentView.swift
//  Calculator
//
//  Created by Lincoln Edsall on 11/19/23.
//

import SwiftUI
import SwiftData

enum CalcButton: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case decimal = "•"
    case clear = "AC"
    case sign = "+/-"
    case percent = "%"
    case multiply = "x"
    case add = "+"
    case divide = "/"
    case subtract = "-"
    case equal = "="
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return Color(.systemBlue)
        case .clear, .sign, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    @State var history: [String] = []
    
    let buttons: [[CalcButton]] = [
        [.clear, .sign, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        let shown = min(self.history.count, 3)
                        ForEach(self.history.suffix(shown), id: \.self) { calc in
                            Text(calc)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 25)
                        }
                    }
                }
                
                Spacer()
                
                //Nums
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                //Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            })
                        }
                    }
                    .padding(.bottom, 1)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                    self.history.append("\(runningValue) + \(currentValue) = \(self.value)")
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                case .divide: 
                    self.value = "\(runningValue / currentValue)"
                case .multiply: 
                    self.value = "\(runningValue * currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal:
            if !self.value.contains(".") {
                self.value += "."
            }
        case .percent:
            if self.value.contains(".") {

            } else {
                
            }
        case .sign:
            if self.value.starts(with: "-") {
                self.value = String(self.value.dropFirst())
            } else {
                self.value = "-" + self.value
            }
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else if self.value == "-0" {
                value = "-" + number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if (item == .zero) {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
