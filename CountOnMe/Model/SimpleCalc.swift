//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Simon Dahan on 04/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation
class SimpleCalc {
    var calculation: [String] = [] {
        didSet {
            if !equalButtonHasBeenPressed {
                let name = Notification.Name("newElementAddedToCalculation")
                let notification = Notification(name: name)
                NotificationCenter.default.post(notification)
            }
        }
    }
    var equalButtonHasBeenPressed = false
    var result = ""
    var error = false
    
    var expressionHaveEnoughElement: Bool {
        return calculation.count >= 3
    }
    
    var expressionIsCorrect: Bool {
        return calculation.last != "+" && calculation.last != "-" && calculation.last != "*" && calculation.last != "/"
    }
    
    var canAddOperator: Bool {
        return self.expressionIsCorrect && self.calculation.count != 0
    }
    
    //    var canAddOperator: Bool {
    //        return self.calculation.last != "+" && self.calculation.last != "-" && self.calculation.count != 0
    //    }
    
    func getResult() -> String? {
        self.equalButtonHasBeenPressed = true
        var temporaryResult = ""
        self.error = false
        reduceCalculation()
        if error {
            return nil
        }
        while calculation.count != 1 {
            guard expressionHaveEnoughElement else {
                return nil
            }
            
            guard expressionIsCorrect else {
                return nil
            }
            
            let left = Float(calculation[0])!
            let operand = calculation[1]
            let right = Float(calculation[2])!
            switch operand {
            case "+": temporaryResult = addition(a: left, b: right)
            case "-": temporaryResult = substraction(a: left, b: right)
            default: fatalError("Unknown operator !")
            }
            calculation = Array(calculation.dropFirst(3))
            calculation.insert(temporaryResult, at: 0)
        }
        self.result = calculation[0]
        cleanResult()
        return self.result
    }
    
    private func reduceCalculation() {
        var index = 0
        if expressionHaveEnoughElement && expressionIsCorrect {
            while index < calculation.count {
                if calculation[index] == "*" {
                    let multiplicationResult = multiplication(a: Float(calculation[index-1])!, b: Float(calculation[index+1])!)
                    sortDictionnary(result: multiplicationResult, at: index)
                    index = 0
                }
                else if calculation[index] == "/" {
                    if let divisionResult = division(a: Float(calculation[index-1])!, b: Float(calculation[index+1])!) {
                        sortDictionnary(result: divisionResult, at: index)
                        index = 0
                    }
                    else {
                        self.error = true
                    }
                    
                }
                index += 1
            }
        }
        
    }
    private func addition(a: Float, b: Float) -> String {
        return String(a + b)
    }
    
    private func substraction(a: Float, b: Float) -> String {
        return String(a - b)
    }
    
    private func multiplication(a: Float, b: Float) -> String {
        return String(a * b)
    }
    
    private func division(a: Float, b: Float) -> String? {
        if b != 0 {
            return String(a / b)
        }
        return nil
    }
    
    private func sortDictionnary(result: String, at index: Int) {
        self.calculation[index - 1] = result
        self.calculation.removeSubrange(index...index+1)
    }
    
    private func cleanResult() {
        let initialResult = Float(self.result)!
        let intResult = Int(initialResult)
        let refloatResult = Float(intResult)
        if refloatResult == initialResult {
            self.result = String(intResult)
        }
    }
}
