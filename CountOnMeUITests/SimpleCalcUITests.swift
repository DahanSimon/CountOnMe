//
//  SimpleCalcUITests.swift
//  SimpleCalcUITests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest

class SimpleCalcUITests: XCTestCase {
    
    func testAdditionCalculation() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["2"].tap()
        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["8"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(app.textViews["textView"].value as! String, "12+24+0+85 = 121")
    }
    
    func testSubtractionCalculation() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["-"].tap()
        app.buttons["2"].tap()
        app.buttons["4"].tap()
        app.buttons["-"].tap()
        app.buttons["0"].tap()
        app.buttons["-"].tap()
        app.buttons["8"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(app.textViews["textView"].value as! String, "12-24-0-85 = -97")
    }
    
    func testMultiplicationCalculation() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["*"].tap()
        app.buttons["2"].tap()
        app.buttons["4"].tap()
        app.buttons["*"].tap()
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["*"].tap()
        app.buttons["8"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(app.textViews["textView"].value as! String, "12*24*10*85 = 244800")
    }
    
    func testDivisionCalculation() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["/"].tap()
        app.buttons["2"].tap()
        app.buttons["4"].tap()
        app.buttons["/"].tap()
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["/"].tap()
        app.buttons["8"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(app.textViews["textView"].value as! String, "12/24/10/85 = 0.0005882353")
    }
    
    
    func testMixedCalculation() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["/"].tap()
        app.buttons["2"].tap()
        app.buttons["4"].tap()
        app.buttons["*"].tap()
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["8"].tap()
        app.buttons["5"].tap()
        app.buttons["-"].tap()
        app.buttons["2"].tap()
        app.buttons["8"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(app.textViews["textView"].value as! String, "12/24*10+85-28 = 62")
    }
    
    func testDivisionByZero() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["/"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        XCTAssertTrue(app.alerts["La division par zero n\'existe pas !"].exists)
    }
    
    func testTryToAddTwoOperators() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["/"].tap()
        app.buttons["+"].tap()
        
        XCTAssertTrue(app.alerts["Attention un operateur existe déjà!"].exists)
    }
    
    func testTryToPressEqualWhenLastEntrieIsAnOperator() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["/"].tap()
        app.buttons["2"].tap()
        app.buttons["/"].tap()
        app.buttons["="].tap()
        
        XCTAssertTrue(app.alerts["Il manque une valeur après votre operateur"].exists)
    }
    
    func testTryToPressEqualWhenThereAreNotEnoughElementsToMakeACaclculation() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        
        XCTAssertTrue(app.alerts["Il manque des elements a votre calcul !"].exists)
    }
    
    func testClearButton() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["2"].tap()
        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["8"].tap()
        app.buttons["5"].tap()
        app.buttons["AC"].tap()
        
        XCTAssertEqual(app.textViews["textView"].value as! String, "")
    }
    
    func testNewCalculationAfterResult() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["/"].tap()
        app.buttons["2"].tap()
        app.buttons["4"].tap()
        app.buttons["*"].tap()
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["8"].tap()
        app.buttons["5"].tap()
        app.buttons["-"].tap()
        app.buttons["2"].tap()
        app.buttons["8"].tap()
        app.buttons["="].tap()
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["/"].tap()
        app.buttons["2"].tap()
        app.buttons["4"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(app.textViews["textView"].value as! String, "12/24 = 0.5")
    }
    
}

