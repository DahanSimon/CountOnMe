//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
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
        NotificationCenter.default.addObserver(self, selector: #selector(error), name: name, object: nil)
    }
    
    // MARK: - Method
    
    @objc func updateTextView() {
        if let elementToPrint = simpleCalc.calculation.last {
            self.textView.text.append(elementToPrint.last!)
        }
    }
    
    @objc func error() {
        switch simpleCalc.error {
        case .operatorAlreadyExist:
            printAlert(title: "Attention un operateur existe déjà!")
        case .missingElements:
            printAlert(title: "Il manque une valeur après votre operateur")
        case .divisionByZero:
            printAlert(title: "La division par zero n'existe pas !")
        case .notEnoughElement:
            printAlert(title: "Il manque des elements a votre calcul !")
        case .unknownOperand:
            printAlert(title: "Un element est inconnu")
        case .unknownOperator:
            printAlert(title: "L'operateur est inconnu")
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
        if simpleCalc.calculation.count != 0 {
            if let _ = Float(simpleCalc.calculation.last!) {
                simpleCalc.calculation[simpleCalc.calculation.count - 1] = simpleCalc.calculation.last! + numberText
            } else {
                simpleCalc.calculation.append(numberText)
            }
            
        } else {
            simpleCalc.calculation.append(numberText)
        }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        simpleCalc.addOperator(newOperator: "+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        simpleCalc.addOperator(newOperator: "-")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
        simpleCalc.addOperator(newOperator: "*")
    }
    @IBAction func tappedDivisionButton(_ sender: Any) {
        simpleCalc.addOperator(newOperator: "/")
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

