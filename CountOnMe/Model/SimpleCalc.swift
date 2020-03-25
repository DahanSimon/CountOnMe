//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Simon Dahan on 04/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation
class SimpleCalc {
    ///  This number formatter is use to use  the right syntax for the result
    let numberFormatter = NumberFormatter()
    
    /// This array stocks every elements of the calculation
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
    
    /// If an error is find somewhere a notification is sent to to the controller to let know the user
    var error: CalcError?  {
        didSet {
            let name = Notification.Name("errorOccured")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
        }
    }
    
    /// Checks that the expression has at least 3 element
    var expressionHaveEnoughElement: Bool {
        return calculation.count >= 3
    }
    
    /// Checks that the expression is not ending with an operator
    var expressionIsCorrect: Bool {
        return calculation.last != "+" && calculation.last != "-" && calculation.last != "*" && calculation.last != "/"
    }
    
    /// Checks if an operator can be added
    var canAddOperator: Bool {
        return calculation.last != "+" && calculation.last != "-" && calculation.last != "*" && calculation.last != "/"
    }
    
    /// This method is called when the user clicks on the equal button
    func getResult() -> String? {
        self.equalButtonHasBeenPressed = true
        
        /// reduceCalculation reduces the calculation to only addition and substraction
        reduceCalculation()
        
        /// if an error occures durring reducing the calculation we return nil
        if error != nil || calculation.count == 0{
            return nil
        }
        
        var stringLeftOperand: String {
            return calculation[0]
        }
        var operatorSymbol: String {
            return calculation[1]
        }
        var stringRightOperand: String {
            return calculation[2]
        }
        var temporaryResult: String
        
        /// While there still is some elements to add or substract
        while calculation.count != 1 {
            /// We cast the left and right operands in float to be able to use them in calculation
            guard let floatLeftOperand = Float(stringLeftOperand),
                       let floatRightOperand = Float(stringRightOperand) else {
                self.error = .unknownOperand
                return nil
            }
            
            switch operatorSymbol {
                case "+": temporaryResult = add(floatLeftOperand, to: floatRightOperand)
                case "-": temporaryResult = substract(floatLeftOperand, from: floatRightOperand)
                default: self.error = .unknownOperator
                        return nil
            }
            /// We erase the first 3 element of the array  since we already calculated them and stocked the result in a variable called temporaryResult
            calculation = Array(calculation.dropFirst(3))
            /// We insert the result in the array at the  first index
            calculation.insert(temporaryResult, at: 0)
        }
        /// We "clean" the result it means that we get rid of of decimal digit if needed for exemple 2.0 become 2 but 2.5 stays 2.5
        if let cleanedResult = numberFormatter.number(from: calculation[0]) {
            calculation[0] = "\(cleanedResult)"
        }
        self.equalButtonHasBeenPressed = false
        /// we return the result
        return calculation[0]
    }
    
    private func reduceCalculation() {
        var index = 0
        
        var leftOperandIndex: Int {
            return  index - 1
        }
        
        var rightOperandIndex: Int {
            return index + 1
        }
        
        if expressionHaveEnoughElement && expressionIsCorrect {
            /// We go threw calculation
            while index < calculation.count {
                if calculation[index] == "*" {
                    ///  We multiply the element if possible
                    if let multiplicationResult = multiply(calculation[leftOperandIndex], and: calculation[rightOperandIndex]){
                        /// sortArray delete the calculation that have been done and replace it with the result
                        sortCalculation(result: multiplicationResult, at: index)
                        /// We start again from the begining
                        index = 0
                    }
                    else {
                        self.error = .unknownOperand
                        break
                    }
                }
                else if calculation[index] == "/" {
                    ///  We divide the element if possible
                    if let divisionResult = divide(calculation[leftOperandIndex], by: calculation[rightOperandIndex]) {
                        /// sortArray delete the calculation that have been done and replace it with the result
                        sortCalculation(result: divisionResult, at: index)
                        /// We start again from the begining
                        index = 0
                    }
                    else {
                        self.error = .divisionByZero
                        break
                    }
                }
                index += 1
            }
        } else {
            if !expressionHaveEnoughElement {
                self.error = .notEnoughElement
            }
            
            if !expressionIsCorrect {
                self.error = .missingElements
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
    
    private func sortCalculation(result: String, at index: Int) {
        /// We place the result instead of the left operand
        self.calculation[index - 1] = result
        /// and we remove the operator and the right operand
        self.calculation.removeSubrange(index...index+1)
    }
    
    func addOperator(newOperator: String) {
        if canAddOperator {
            calculation.append(newOperator)
        } else {
            self.error = .operatorAlreadyExist
        }
    }
    
    func resetCalculator() {
        calculation = []
        self.error = nil
        self.equalButtonHasBeenPressed = false
    }
}
