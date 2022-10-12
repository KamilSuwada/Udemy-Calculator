//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var acButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        appLogic.delegate = self
        self.displayValue = 0.0
    }
    
    
    @IBOutlet weak var displayLabel: UILabel!
    
    
    private let appLogic: AppLogic = AppLogic()
    private var actionPressed: CalculatorAction? = nil
    private var isFinishedTypingNumber: Bool = false
    
    
    public var displayValue: Double {
        get {
            if displayLabel.text == "Error" {
                displayLabel.text = "0"
                return 0.0
            } else {
                var numberString: String = ""
                if displayLabel.text!.last == "." {
                    numberString = displayLabel.text! + "0"
                } else {
                    numberString = displayLabel.text!
                }
                guard let number: Double = Double(numberString) else {
                    fatalError("Failed during unwrapping of the display value.")
                }
                return number
            }
        }
        set {
            if newValue == 0.0 {
                displayLabel.text = "0"
            } else if newValue.truncatingRemainder(dividingBy: 1.0) == 0 {
                displayLabel.text = String(Int(newValue))
            } else {
                displayLabel.text = String(newValue)
            }
        }
    }
    
    
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        appLogic.lastButtonPressedTag = sender.tag
        
        switch sender.tag {
        case 11:
            actionPressed = .ac
        case 12:
            actionPressed = .plusMinus
        case 13:
            actionPressed = .percent
        case 14:
            actionPressed = .divide
        case 15:
            actionPressed = .multiply
        case 16:
            actionPressed = .minus
        case 17:
            actionPressed = .plus
        case 18:
            actionPressed = .equals
        default:
            actionPressed = nil
        }
        
        if let action = actionPressed {
            appLogic.calculate(action: action)
        }
        
        print(appLogic.currentCalculatorValue)
    }
    
    
    

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let buttonPressed = sender.currentTitle {
            
            appLogic.lastButtonPressedTag = sender.tag
            
            if isFinishedTypingNumber == true {
                if buttonPressed == "0" {
                    displayLabel.text = "0"
                } else if buttonPressed == "." {
                    displayLabel.text = "0."
                    isFinishedTypingNumber = false
                } else {
                    displayLabel.text = buttonPressed
                    isFinishedTypingNumber = false
                }
            } else {
                if buttonPressed == "." {
                    var hasDecimalPlaceAlready: Bool = false
                    for char in displayLabel.text! {
                        if char == "." {
                            hasDecimalPlaceAlready = true
                            break
                        }
                    }
                    if hasDecimalPlaceAlready == false {
                        displayLabel.text = displayLabel.text! + buttonPressed
                        isFinishedTypingNumber = false
                    }
                } else {
                    
                    if displayLabel.text == "0" {
                        displayLabel.text = buttonPressed
                        isFinishedTypingNumber = false
                    } else {
                        displayLabel.text = displayLabel.text! + buttonPressed
                        isFinishedTypingNumber = false
                    }
                    
                }
            }
            print(appLogic.currentCalculatorValue)
        }
    }
}
