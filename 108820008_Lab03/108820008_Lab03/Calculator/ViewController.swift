//
//  ViewController.swift
//  Calculator
//
//  Created by Ricky Hu on 2022/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    private var operation: [String]! = []
    
    let PLUS = "+"
    let MINUS = "-"
    let MULTIPLY = "×"
    let DIVIDE = "÷"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func onNumberClick(_ sender: UIButton) {
        if operation.isEmpty || Int(operation.last!) == nil {
            operation.append(sender.currentTitle!)
            operationLabel.text! += sender.currentTitle!
        } else {
            let number = operation.popLast()! + sender.currentTitle!
            operation.append(number)
            operationLabel.text! += sender.currentTitle!
        }
        
//        testLabel.text! = "\(operations.count)"
    }
    
    @IBAction func onOperatorClick(_ sender: UIButton) {
        if Int(operation.last!) != nil {
            operation.append(sender.currentTitle!)
            operationLabel.text! += sender.currentTitle!
        }
    }
    
    
    @IBAction func onCalculateClick(_ sender: UIButton) {
        var new_operation: [String] = []
        var isCalculated = false

        for index in 0...(operation.count - 1) {
            if isCalculated {
                isCalculated = false
                continue
            }

            if operation[index] == MULTIPLY {
                let first = Int(new_operation.popLast()!)!
                let second = Int(operation[index + 1])!
                let result = first * second
                new_operation.append("\(result)")
                isCalculated = true
            }
            else if operation[index] == DIVIDE {
                let first = Int(new_operation.popLast()!)!
                let second = Int(operation[index + 1])!
                let result = first / second
                new_operation.append("\(result)")
                isCalculated = true
            }
            else {
                new_operation.append(operation[index])
            }
        }

        isCalculated = false
        var answer = new_operation[0]

        for index in 1...(new_operation.count - 1) {
            if isCalculated {
                isCalculated = false
                continue
            }

            if new_operation[index] == PLUS {
                let first = Int(answer)!
                let second = Int(new_operation[index + 1])!
                let result = first + second
                answer = "\(result)"
            }
            else if new_operation[index] == MINUS {
                let first = Int(answer)!
                let second = Int(new_operation[index + 1])!
                let result = first - second
                answer = "\(result)"
            }
        }
        
        operationLabel.text! = ""
        operation.removeAll()
        resultLabel.text! = answer
    }
    
    @IBAction func onClearClick(_ sender: UIButton) {
        operationLabel.text! = ""
        resultLabel.text! = "0"
    }
}

