//
//  AppLogic.swift
//  Calculator
//
//  Created by Kamil Suwada on 13/03/2022.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import UIKit



class AppLogic {
    
    
    private var isFinishedTypingNumber: Bool = true
    public var delegate: ViewController?
    
    
    public var currentCalculatorValue: Double? = nil
    private var calculatorAction: CalculatorAction? = nil
    public var lastButtonPressedTag: Int = 0
    
    
    public func calculate(action: CalculatorAction) {
        
        if let delegate = delegate {
            switch action {
                
            case .plus:
                currentCalculatorValue = delegate.displayValue
                delegate.displayValue = 0.0
                calculatorAction = .plus
                
            case .minus:
                currentCalculatorValue = delegate.displayValue
                delegate.displayValue = 0.0
                calculatorAction = .minus
                
            case .multiply:
                currentCalculatorValue = delegate.displayValue
                delegate.displayValue = 0.0
                calculatorAction = .multiply
                
            case .divide:
                currentCalculatorValue = delegate.displayValue
                delegate.displayValue = 0.0
                calculatorAction = .divide
                
            case .percent:
                delegate.displayValue = delegate.displayValue * 0.01
                
            case .plusMinus:
                delegate.displayValue = delegate.displayValue * -1
                
            case .ac:
                delegate.displayValue = 0.0
                currentCalculatorValue = nil
                calculatorAction = nil
                
            case .equals:
                if let a = currentCalculatorValue {
                    if let operation = calculatorAction {
                        switch operation {
                            
                            
                        case .plus:
                            delegate.displayValue = a + delegate.displayValue
                            currentCalculatorValue = delegate.displayValue
                            
                        case .minus:
                            delegate.displayValue = a - delegate.displayValue
                            currentCalculatorValue = delegate.displayValue
                            
                        case .multiply:
                            delegate.displayValue = a * delegate.displayValue
                            currentCalculatorValue = delegate.displayValue
                            
                        case .divide:
                            if delegate.displayValue != 0.0 {
                                delegate.displayValue = a / delegate.displayValue
                                currentCalculatorValue = delegate.displayValue
                            } else {
                                delegate.displayLabel.text = "Error"
                            }
                            
                        default:
                            fatalError()
                        }
                        
                    } else {
                        print("Could not unwrap the action")
                    }
                } else {
                    print("Could not unwrap current value")
                }
            
            }
            
        }
        
    }
    
    
    private func pressButton(button: UIButton) {
        
    }
}


enum CalculatorAction {
    
    case plus
    case minus
    case multiply
    case divide
    case percent
    case plusMinus
    case ac
    case equals
    
}
