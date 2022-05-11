//
//  ViewController.swift
//  Calculator
//
//  Created by Ricky Hu on 2022/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var operationLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var currentSelectedOperator: UIButton!
    @IBOutlet var testLabel: UILabel!
    private var operation: [String]! = [] {
        didSet {
            var text = ""
            for element in operation {
                text += element
            }
            operationLabel.text! = text
        }
    }
    
    let PLUS = "+"
    let MINUS = "-"
    let MULTIPLY = "×"
    let DIVIDE = "÷"
    let REMOVE_ELEMENT_TEXT = "C"
    let REMOVE_ALL_TEXT = "AC"
    let COLOR_WHITE = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let COLOR_ORANGE = #colorLiteral(red: 0.9987371564, green: 0.5848035216, blue: 0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func isNumeric(text: String) -> Bool {
        return Double(text) != nil || text == "."
    }
    
    func isOperator(text: String) -> Bool {
        return (text == PLUS || text == MINUS || text == MULTIPLY || text == DIVIDE)
    }
    
    private func _setOperatorButtonColor(textColor: UIColor, backgroundColor: UIColor) {
        if currentSelectedOperator != nil {
            currentSelectedOperator.setTitleColor(textColor, for: .normal)
            currentSelectedOperator.backgroundColor = backgroundColor
        }
    }

    @IBAction func onNumberClick(_ sender: UIButton) {
        if operation.isEmpty || !isNumeric(text: "\(operation.last!.last!)") {
            operation.append(sender.currentTitle!)
        } else {
            let number = operation.popLast()!
            let inputChar = sender.currentTitle!
            let length = number.count
            
            if length > 0 {
                let i = number.index(number.startIndex, offsetBy: length - 1)
                if number[i] == "." && inputChar == "." {
                    operation.append(number)
                    return
                }
            }
            if length > 1 {
                let i = number.index(number.startIndex, offsetBy: length - 2)
                if number[i] == "." {
                    operation.append(number)
                    return
                }
            }
            
            operation.append(number + inputChar)
        }
        
        clearButton.setTitle(REMOVE_ELEMENT_TEXT, for: .normal)
        _setOperatorButtonColor(textColor: COLOR_WHITE, backgroundColor: COLOR_ORANGE)
    }
    
    @IBAction func onOperatorClick(_ sender: UIButton) {
        if operation.isEmpty {
            operation.append("\(Double(resultLabel.text!)!)")
        }
        
        if !isNumeric(text: operation.last!) {
            _setOperatorButtonColor(textColor: COLOR_WHITE, backgroundColor: COLOR_ORANGE)
            operation.removeLast()
        }
        
        let number = operation.popLast()!
        if number.contains(".") {
            operation.append(String(Double(number)!))
        } else {
            operation.append(String(Int(number)!))
        }
        
        currentSelectedOperator = sender
        operation.append(sender.currentTitle!)
        clearButton.setTitle(REMOVE_ELEMENT_TEXT, for: .normal)
        _setOperatorButtonColor(textColor: COLOR_ORANGE, backgroundColor: COLOR_WHITE)
    }
    
    @IBAction func onPosNegClick(_ sender: UIButton) {}
    
    @IBAction func onCalculateClick(_ sender: UIButton) {
        if operation.isEmpty || isOperator(text: operation.last!) {
            return
        }
        
        var answer = _calculateMultiplyAndDivide(operation: operation)
        operation.removeAll()
        
        if answer.last! == "." {
            answer = String(answer.dropLast())
        }
        
        answer = String(format: "%.6f", Double(answer)!)
        resultLabel.text! = String(Double(answer)!)
        clearButton.setTitle(REMOVE_ALL_TEXT, for: .normal)
    }
    
    @IBAction func onClearClick(_ sender: UIButton) {
        if sender.currentTitle! == REMOVE_ELEMENT_TEXT {
            if !operation.isEmpty && isNumeric(text: operation.last!) {
                operation.removeLast()
                _setOperatorButtonColor(textColor: COLOR_ORANGE, backgroundColor: COLOR_WHITE)
                sender.setTitle(REMOVE_ALL_TEXT, for: .normal)
            }
        } else if operation.isEmpty || sender.currentTitle == REMOVE_ALL_TEXT {
            sender.setTitle(REMOVE_ELEMENT_TEXT, for: .normal)
            _setOperatorButtonColor(textColor: COLOR_WHITE, backgroundColor: COLOR_ORANGE)
            
            operation.removeAll()
            currentSelectedOperator = nil
            resultLabel.text! = "0"
        }
    }
    
    private func _calculateMultiplyAndDivide(operation: [String]) -> String {
        var tempOperation: [String] = []
        var isCalculated = false

        for index in 0...(operation.count - 1) {
            if isCalculated {
                isCalculated = false
                continue
            }

            if operation[index] == MULTIPLY {
                let first = Double(tempOperation.popLast()!)!
                let second = Double(operation[index + 1])!
                tempOperation.append("\(first * second)")
                isCalculated = true
            }
            else if operation[index] == DIVIDE {
                let first = Double(tempOperation.popLast()!)!
                let second = Double(operation[index + 1])!
                if second == 0 {
                    tempOperation.append("0")
                } else {
                    tempOperation.append("\(first / second)")
                }
                isCalculated = true
            }
            else {
                tempOperation.append(operation[index])
            }
        }
        
        if tempOperation.count == 1 {
            return tempOperation[0]
        } else {
            return _calculatePlusAndMinus(operation: tempOperation)
        }
    }
    
    private func _calculatePlusAndMinus(operation: [String]) -> String {
        var isCalculated = false
        var answer = operation[0]
        for index in 1...(operation.count - 1) {
            if isCalculated {
                isCalculated = false
                continue
            }

            if operation[index] == PLUS {
                let first = Double(answer)!
                let second = Double(operation[index + 1])!
                answer = "\(first + second)"
            }
            else if operation[index] == MINUS {
                let first = Double(answer)!
                let second = Double(operation[index + 1])!
                answer = "\(first - second)"
            }
        }
        
        return answer
    }
}
