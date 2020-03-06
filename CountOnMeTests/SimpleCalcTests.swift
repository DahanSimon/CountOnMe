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
        simpleCalc.calculation.append("+")
        simpleCalc.calculation.append("1")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "2")
    }
    
    func testGivenClalculationIs1Minus1_WhenPressingOnEqualButton_ThenResultIs0() {
        
        simpleCalc.calculation.append("1")
        simpleCalc.calculation.append("-")
        simpleCalc.calculation.append("1")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "0")
    }
    func testGivenClalculationIs1PlusNothing_WhenPressingOnEqualButton_ThenAnErrorOccured() {
        
        simpleCalc.calculation.append("8")
        simpleCalc.calculation.append("+")
        
        let result = simpleCalc.getResult()
        
        XCTAssertNil(result, "This should be nil")
    }
    
    func testGivenMultipleAddition_WhenPressingOnEqualButton_ThenTheResultShouldBeCorrect() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("+")
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("-")
        simpleCalc.calculation.append("5")
        simpleCalc.calculation.append("+")
        simpleCalc.calculation.append("43")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "58")
    }
    
    func testGivenMultipleAdditionWithTheLastElementMissing_WhenPressingOnEqualButton_ThenTheResultShouldBeNil() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("+")
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("-")
        simpleCalc.calculation.append("5")
        simpleCalc.calculation.append("+")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenNoElementEntered_WhenPressingEqualButton_ThenResultShouldBeNil() {
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenCalculationIs1by1_WHenPressingEqualButton_ThenResultShouldBe1() {
        simpleCalc.calculation.append("1")
        simpleCalc.calculation.append("*")
        simpleCalc.calculation.append("1")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "1")
    }
    
    func testGivenMultipleMultiplication_WhenPressingOnEqualButton_ThenTheResultShouldBeCorrect() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("*")
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("*")
        simpleCalc.calculation.append("5")
        simpleCalc.calculation.append("*")
        simpleCalc.calculation.append("43")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "21500")
    }
    
    func testGivenMultiplicationIsPrioritary_WhenPressingOnEqualButton_ThenTheResultShouldBeCorrect() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("+")
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("*")
        simpleCalc.calculation.append("5")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "60")
    }
    
    func testGivenMultipleMultiplicationWithTheLastElementMissing_WhenPressingOnEqualButton_ThenTheResultShouldBeNil() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("*")
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("-")
        simpleCalc.calculation.append("5")
        simpleCalc.calculation.append("*")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenMultipleMultiplicationWithZero_WhenPressingOnEqualButton_ThenTheResultShouldBeZero() {
        
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("*")
        simpleCalc.calculation.append("10")
        simpleCalc.calculation.append("*")
        simpleCalc.calculation.append("5")
        simpleCalc.calculation.append("*")
        simpleCalc.calculation.append("0")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "0")
    }
    
    func testGivenCalculationIs4DividedBy2_WhenPressingOnEqualButton_ThenTheResult2() {
        simpleCalc.calculation.append("4")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("2")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "2")
    }
    
    func testGivenCalculationWithMultipleElementToDivide_WhenPressingOnEqualButton_ThenTheResultShouldBeRight() {
        simpleCalc.calculation.append("4")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("2")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("4")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("2")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "0.25")
    }
    
    func testGivenCalculationWithDivisionByZero_WhenPressingOnEqualButton_ThenTheResultShouldBeNil() {
        simpleCalc.calculation.append("4")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("2")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("4")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("0")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenDivisionWithMissingElement_WhenPressingOnEqualButton_ThenTheResultShouldBeNil() {
        simpleCalc.calculation.append("4")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("2")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("4")
        simpleCalc.calculation.append("/")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, nil)
    }
    
    func testGivenCalculationIsZeroDividedBy2_WhenPressingOnEqualButton_ThenTheResultShouldBeZero() {
        simpleCalc.calculation.append("0")
        simpleCalc.calculation.append("/")
        simpleCalc.calculation.append("2")
        
        let result = simpleCalc.getResult()
        
        XCTAssertEqual(result, "0")
    }
}
