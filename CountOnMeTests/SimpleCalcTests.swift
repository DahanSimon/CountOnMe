//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe
class SimpleCalcTests: XCTestCase {
    var simpleCalc: SimpleCalc!
    override func setUp() {
        super.setUp()
        simpleCalc = SimpleCalc()
    }
    
    func testGivenClalculationIs1Plus1_WhenPressingOnEqualButton_ThenResultIs2() {
        
        simpleCalc.calculation.append("1")
        simpleCalc.addOperator(newOperator: "+")
        simpleCalc.calculation.append("1")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "2")
        XCTAssertEqual(simpleCalc.error, nil)
    }
    
    func testGivenClalculationIs1Minus1_WhenPressingOnEqualButton_ThenResultIs0() {
        
        simpleCalc.calculation.append("1")
        simpleCalc.addOperator(newOperator: "-")
        simpleCalc.calculation.append("1")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "0")
        XCTAssertEqual(simpleCalc.error, nil)

    }
    func testGivenClalculationIs1PlusNothing_WhenPressingOnEqualButton_ThenAnErrorOccured() {
        
        simpleCalc.calculation.append("8")
        simpleCalc.addOperator(newOperator: "+")
        
        let result = simpleCalc.getResult()
        
        XCTAssertNil(result, "This should be nil")
        XCTAssertEqual(simpleCalc.error, CalcError.missingElements)
    }
    
    func testGivenMultipleAddition_WhenPressingOnEqualButton_ThenTheResultShouldBeCorrect() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "+")
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "-")
        simpleCalc.calculation.append("5")
        simpleCalc.addOperator(newOperator: "+")
        simpleCalc.calculation.append("43")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "58")
        XCTAssertEqual(simpleCalc.error, nil)

    }
    
    func testGivenMultipleAdditionWithTheLastElementMissing_WhenPressingOnEqualButton_ThenTheResultShouldBeNil() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "+")
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "-")
        simpleCalc.calculation.append("5")
        simpleCalc.addOperator(newOperator: "+")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenNoElementEntered_WhenPressingEqualButton_ThenResultShouldBeNil() {
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenCalculationIs1by1_WHenPressingEqualButton_ThenResultShouldBe1() {
        simpleCalc.calculation.append("1")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("1")
        
        let result = simpleCalc.getResult()
        XCTAssertEqual(result, "1")
        XCTAssertEqual(simpleCalc.error, nil)
    }
    
    func testGivenMultipleMultiplication_WhenPressingOnEqualButton_ThenTheResultShouldBeCorrect() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("5")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("43")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "21500")
        XCTAssertEqual(simpleCalc.error, nil)
    }
    
    func testGivenMultiplicationIsPrioritary_WhenPressingOnEqualButton_ThenTheResultShouldBeCorrect() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "+")
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("5")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "60")
        XCTAssertEqual(simpleCalc.error, nil)
    }
    
    func testGivenMultipleMultiplicationWithTheLastElementMissing_WhenPressingOnEqualButton_ThenTheResultShouldBeNil() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "-")
        simpleCalc.calculation.append("5")
        simpleCalc.addOperator(newOperator: "*")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenMultipleMultiplicationWithZero_WhenPressingOnEqualButton_ThenTheResultShouldBeZero() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("10")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("5")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("0")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "0")
        XCTAssertEqual(simpleCalc.error, nil)
    }
    
    func testGivenCalculationIs4DividedBy2_WhenPressingOnEqualButton_ThenTheResult2() {
        simpleCalc.calculation.append("4")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("2")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "2")
        XCTAssertEqual(simpleCalc.error, nil)
    }
    
    func testGivenCalculationWithMultipleElementToDivide_WhenPressingOnEqualButton_ThenTheResultShouldBeRight() {
        simpleCalc.calculation.append("4")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("2")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("4")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("2")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "0.25")
        XCTAssertEqual(simpleCalc.error, nil)
    }
    
    func testGivenCalculationWithDivisionByZero_WhenPressingOnEqualButton_ThenTheResultShouldBeNil() {
        simpleCalc.calculation.append("4")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("2")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("4")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("0")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenDivisionWithMissingElement_WhenPressingOnEqualButton_ThenTheResultShouldBeNil() {
        simpleCalc.calculation.append("4")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("2")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("4")
        simpleCalc.addOperator(newOperator: "/")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenCalculationIsZeroDividedBy2_WhenPressingOnEqualButton_ThenTheResultShouldBeZero() {
        simpleCalc.calculation.append("0")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("2")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "0")
        XCTAssertEqual(simpleCalc.error, nil)
    }
    
    func testGivenCalculationIsZeroDividedBy2_WhenTryingToAddNewOperator_ThenTheResultShouldBeNil() {
        simpleCalc.calculation.append("0")
        simpleCalc.addOperator(newOperator: "/")
        simpleCalc.calculation.append("2")
        
        simpleCalc.addOperator(newOperator: "+")
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(simpleCalc.error, CalcError.missingElements)
        XCTAssertEqual(result, nil)
    }
    
    func testGivenCalculationIsMinus25_WhenTryingToAdd10_ThenTheResultShouldBeMinus15() {
        simpleCalc.calculation.append("-25")
        simpleCalc.addOperator(newOperator: "+")
        simpleCalc.calculation.append("10")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "-15")
        XCTAssertEqual(simpleCalc.error, nil)
    }
    
    func testGivenCalculationIsMinus25_WhenTryingToAddTheLetterA_ThenTheResultShouldBeNil() {
        simpleCalc.calculation.append("-25")
        simpleCalc.addOperator(newOperator: "*")
        simpleCalc.calculation.append("A")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
        XCTAssertEqual(simpleCalc.error, CalcError.unknownOperand)
        
    }
    
    func testGivenClalculationIs1PlusNothing_WhenTryingToAddNewOperator_ThenAnErrorOccured() {
        
        simpleCalc.calculation.append("8")
        simpleCalc.addOperator(newOperator: "+")
        simpleCalc.addOperator(newOperator: "+")
        
        XCTAssertEqual(simpleCalc.error, CalcError.operatorAlreadyExist)
    }
}
