//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let simpleCalc = SimpleCalc()
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = Notification.Name("newElementAddedToCalculation")
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: name, object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        //        On recupere le titre du bouton (le chiffre selectionner)
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        //        Si l'expression afficher a un resultat  on remet le texte a zero
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
        addOperator(newOperator: "+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        addOperator(newOperator: "-")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
        addOperator(newOperator: "*")
    }
    @IBAction func tappedDivisionButton(_ sender: Any) {
        addOperator(newOperator: "/")
    }
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if let foundError = simpleCalc.checkError() {
            error(error: foundError)
        } else {
            
            if let _ = simpleCalc.getResult() {
                textView.text.append(" = \(simpleCalc.result)")
            } else {
                textView.text.append("=")
                if let foundError = simpleCalc.error {
                    error(error: foundError)
                }
            }
        }
        simpleCalc.equalButtonHasBeenPressed = false
        simpleCalc.calculation = []
    }
    
    @objc func updateTextView() {
        if let elementToPrint = simpleCalc.calculation.last {
            self.textView.text.append(elementToPrint.last!)
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        simpleCalc.calculation = []
        self.textView.text = ""
    }
    
    private func error(error: CalcError) {
        switch error {
        case .operatorAlreadyExist:
            let alertVC = UIAlertController(title: "Attention un operateur existe déjà!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        case .missingElements:
            let alertVC = UIAlertController(title: "Il manque une valeur après votre operateur", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        case .divisionByZero:
            let alertVC = UIAlertController(title: "Division by Zero!", message: "La division par zero n'existe pas !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        case .notEnoughElement:
            let alertVC = UIAlertController(title: "Il manque des elements a votre calcul !", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
            
        case .unknownOperand:
            let alertVC = UIAlertController(title: "Un element est inconnu", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    private func addOperator(newOperator: String) {
        if simpleCalc.canAddOperator /*|| (newOperator == "+" || newOperator == "-")*/{
            simpleCalc.calculation.append(newOperator)
        } else {
            error(error: .operatorAlreadyExist)
        }
    }
}

