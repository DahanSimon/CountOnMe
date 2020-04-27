//
//  ViewController.swift
//  CountOnMe
//
//  Created by Simon Dahan on 04/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Propreties
    let simpleCalc = SimpleCalc()
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - View Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationName = Notification.Name("newElementAddedToCalculation")
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: notificationName, object: nil)
        let name = Notification.Name("errorOccured")
        NotificationCenter.default.addObserver(self, selector: #selector(handleError), name: name, object: nil)
    }
    
    // MARK: - Method
    
    @objc func updateTextView() {
        if let elementToPrint = simpleCalc.calculation.last {
            self.textView.text.append(elementToPrint.last!)
        }
    }
    
    @objc func handleError() {
        switch simpleCalc.error {
        case .operatorAlreadyExist:
            printAlert(title: "Attention un opérateur existe déjà!")
        case .missingElements:
            printAlert(title: "Il manque une valeur après votre operateur")
        case .divisionByZero:
            printAlert(title: "La division par zero n'existe pas !")
        case .notEnoughElement:
            printAlert(title: "Il manque des elements à votre calcul !")
        case .unknownOperand:
            printAlert(title: "Un élément est inconnu")
        case .unknownOperator:
            printAlert(title: "L'opérateur est inconnu")
        case .none:
            break
        }
    }
    
    private func printAlert(title: String){
        let alertVC = UIAlertController(title: title, message: "Demarrer un nouveau calcul !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
        simpleCalc.resetCalculator()
    }
    
    // MARK: - Actions
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        /// if the dictionnary already has an element in it
        if simpleCalc.calculation.count != 0 {
            /// If the last entered element is a number and not an operator
            if let _ = Float(simpleCalc.calculation.last!) {
                /// we add to the string the digit that user tapped on
                simpleCalc.calculation[simpleCalc.calculation.count - 1] = simpleCalc.calculation.last! + numberText
            } else {
                /// if the last element of the calculation is an operator we add a new element to the table
                simpleCalc.calculation.append(numberText)
            }
            
        } else {
            simpleCalc.calculation.append(numberText)
        }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if !expressionHaveResult {
            simpleCalc.addOperator(newOperator: "+")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if !expressionHaveResult {
            simpleCalc.addOperator(newOperator: "-")
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
        if !expressionHaveResult {
            simpleCalc.addOperator(newOperator: "*")
        }
    }
    @IBAction func tappedDivisionButton(_ sender: Any) {
        if !expressionHaveResult {
            simpleCalc.addOperator(newOperator: "/")
        }
    }
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if let result = simpleCalc.getResult() {
            textView.text.append(" = \(result)")
        } else {
            textView.text.append("=")
        }
        simpleCalc.resetCalculator()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        simpleCalc.calculation = []
        self.textView.text = ""
    }
}

