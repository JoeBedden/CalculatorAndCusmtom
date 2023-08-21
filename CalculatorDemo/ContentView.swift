//
//  ContentView.swift
//  CalculatorDemo
//
//  Created by 雷子康 on 2023/8/21.
//

import SwiftUI

// 按钮
enum CalcButton: String {
    case one       = "1"
    case two       = "2"
    case three     = "3"
    case four      = "4"
    case five      = "5"
    case six       = "6"
    case seven     = "7"
    case eight     = "8"
    case nine      = "9"
    case zero      = "0"
    case add       = "+"
    case subtract  = "-"
    case divide    = "/"
    case multiply  = "x"
    case equal     = "="
    case clear     = "AC"
    case decimal   = "."
    case percent   = "%"
    case negative  = "-/+"
    
    // 颜色
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal :
            return .orange
        case .clear, .negative, .percent :
            return Color(.lightGray)
        default:
            return Color(red: 55/255, green: 55/255, blue: 55/255)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0" // 计算器显示的值
    @State var runningNumber = 0 // 当前运算的数字
    @State var currentOperation: Operation = .none // 当前运算符
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all) // 设置背景颜色为黑色，并忽略安全区域
                
                VStack(spacing: 12) {
                    NavigationLink(destination: CustomView()) {
                        Text("Result")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.black)
                    }
                    
                    Spacer() // 占位符，用于调整布局
                    
                    HStack {
                        Spacer() // 占位符，用于调整布局
                        
                        Text(value) // 显示计算器的值
                            .font(.system(size: 64)) // 字体大小
                            .foregroundColor(.white) // 字体颜色
                    }
                    
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { button in
                                Button(action: {
                                    self.didTap(button: button) // 点击按钮时调用的方法
                                }, label: {
                                    Text(button.rawValue) // 按钮上的文字
                                        .font(.system(size: 32)) // 字体大小
                                        .frame(width: self.buttonWidth(for: button), height: self.buttonHeight(for: button)) // 按钮宽度和高度
                                        .background(button.buttonColor) // 按钮的背景颜色
                                        .foregroundColor(.white) // 按钮的字体颜色
                                        .cornerRadius(self.buttonHeight(for: button) / 2) // 按钮的圆角半径
                                })
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            // 处理运算符按钮点击事件
            if button != .equal {
                // 保存当前操作符
                currentOperation = getOperation(for: button)
                // 保存当前数值
                if let value = Int(value) {
                    runningNumber = value
                }
                // 将 value 置为 "0"，等待下一个数字输入
                self.value = "0"
            } else {
                // 处理等号按钮点击事件
                runningNumber = performOperation(with: currentOperation)
                self.value = "\(runningNumber)"
                currentOperation = .none
            }
        case .clear:
            // 处理清除按钮点击事件
            self.value = "0"
            runningNumber = 0
            currentOperation = .none
        case .negative:
            // 处理正负号按钮点击事件
            if let value = Int(value) {
                self.value = String(-value)
            } else {
                self.value = "-\(value)"
            }
        case .percent:
            // 处理百分号按钮点击事件
            if let value = Double(value) {
                self.value = String(value / 100)
            }
       
        default:
            // 处理数字和小数点按钮点击事件
            if value == "0" {
                value = button.rawValue
            } else {
                value += button.rawValue
            }
        }
    }
    
    func getOperation(for button: CalcButton) -> Operation {
        switch button {
        case .add:
            return .add
        case .subtract:
            return .subtract
        case .multiply:
            return .multiply
        case .divide:
            return .divide
        default:
            return .none
        }
    }
    
    func performOperation(with operation: Operation) -> Int {
        switch operation {
        case .add:
            return runningNumber + Int(value)!
        case .subtract:
            return runningNumber - Int(value)!
        case .multiply:
            return runningNumber * Int(value)!
        case .divide:
            return runningNumber / Int(value)!
        default:
            return runningNumber
        }
    }
    
    func buttonWidth(for button: CalcButton) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width // 获取屏幕宽度
        let buttonWidth = (screenWidth - 5 * 12) / 4 // 计算按钮的宽度（减去5个间距，再除以4）
        if button == .zero {
            return buttonWidth * 2 + 12 // 如果是0按钮，宽度是原来按钮宽度的两倍加上一个间距
        }
        return buttonWidth
    }
    
    func buttonHeight(for button: CalcButton) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width // 获取屏幕宽度
        let buttonWidth = (screenWidth - 5 * 12) / 4 // 计算按钮的宽度（减去5个间距，再除以4）
        if button == .zero {
            return buttonWidth // 如果是0按钮，高度和宽度相等
        }
        return buttonWidth
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
