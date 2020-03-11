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
    var error: CalcError?
    
    var expressionHaveEnoughElement: Bool {
        return calculation.count >= 3
    }
    
    var expressionIsCorrect: Bool {
        return calculation.last != "+" && calculation.last != "-" && calculation.last != "*" && calculation.last != "/"
    }
    
    var canAddOperator: Bool {
        return self.expressionIsCorrect
    }
    
    func getResult() -> String? {
        self.equalButtonHasBeenPressed = true
        var temporaryResult = ""
        self.error = nil
        reduceCalculation()
        if error != nil {
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
            case "+": temporaryResult = add(left, to: right)
            case "-": temporaryResult = substract(left, from: right)
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
        var previousValue: Int {
            return  index - 1
        }
        var nextValue: Int {
            return index + 1
        }
        if expressionHaveEnoughElement && expressionIsCorrect {
            while index < calculation.count {
                if calculation[index] == "*" {
                    if let multiplicationResult = multiply(calculation[previousValue], and: calculation[nextValue]){
                        sortArray(result: multiplicationResult, at: index)
                        index = 0
                    }
                    else {
                        self.error = .unknownOperand
                        break
                    }
                }
                else if calculation[index] == "/" {
                    if let divisionResult = divide(calculation[previousValue], by: calculation[nextValue]) {
                        sortArray(result: divisionResult, at: index)
                        index = 0
                    }
                    else {
                        self.error = .divisionByZero
                    }
                    
                }
                index += 1
            }
        }
        
    }
    private func add(_ leftOperand: Float, to rightOperand: Float) -> String {
        return String(leftOperand + rightOperand)
    }
    
    private func substract(_ leftOperand: Float, from rightOperand: Float) -> String {
        return String(leftOperand - rightOperand)
    }
    
    private func multiply(_ leftOperand: String, and rightOperand: String) -> String? {
        guard let floatLeftOperand = Float(leftOperand), let floatRightOperand = Float(rightOperand) else {
            return nil
        }
        return String(floatLeftOperand * floatRightOperand)
    }
    
    private func divide(_ leftOperand: String, by rightOperand: String) -> String? {
        guard let floatLeftOperand = Float(leftOperand), let floatRightOperand = Float(rightOperand), floatRightOperand != 0 else {
            return nil
        }
        return String(floatLeftOperand / floatRightOperand)
    }
    
    private func sortArray(result: String, at index: Int) {
        self.calculation[index - 1] = result
        self.calculation.removeSubrange(index...index+1)
    }
    
    private func cleanResult() {
        let initialResult = Float(self.result)!
        if initialResult < Float(Int.max ){
            let intResult = Int(initialResult)
            let refloatResult = Float(intResult)
            if refloatResult == initialResult {
                self.result = String(intResult)
            }
        }
    }
    
    func checkError() -> CalcError? {
        guard self.expressionIsCorrect else {
            return .missingElements
        }
        
        guard self.expressionHaveEnoughElement else {
            return .notEnoughElement
        }
        return nil
    }
}
