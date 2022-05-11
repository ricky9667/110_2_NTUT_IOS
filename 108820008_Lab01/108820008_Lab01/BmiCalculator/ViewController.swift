//
//  ViewController.swift
//  BmiCalculator
//
//  Created by Ricky Hu on 2022/3/2.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var weightStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCalculateButtonClick(_ sender: Any) {
        let heightText = heightTextField.text
        let weightText = weightTextField.text
        
        if (heightText == nil || weightText == nil) {
            return
        }
        
        let height: Double = toDouble(s: heightText) / 100 // m
        let weight: Double = toDouble(s: weightText) // kg
        
        let bmi: Double = weight / (height * height)
        bmiLabel.text = "\(String(format: "%.2f", bmi))"
        weightStatusLabel.text = getWeightStatusText(bmi: bmi, sexIndex: sexSegmentControl.selectedSegmentIndex)
    }
    
    func getWeightStatusText(bmi: Double, sexIndex: Int) -> String {
        if (bmi < 18.5) {
            return "Weight Status: Underweight"
        } else if (bmi < 25.0) {
            return "Weight Status: Healthy weight"
        } else if (bmi < 30.0) {
            return sexIndex == 0 ? "Weight Status: Overweight" : "Weight Status: It's a secret"
        } else {
            return sexIndex == 0 ? "Weight Status: Obesity" : "Weight Status: It's a secret"
        }
    }
    
    func toDouble(s: String?) -> Double {
        var result = 0.0
        if let str: String = s,
        let i = Double(str) {
            result = i
        }
        return result
    }
}
