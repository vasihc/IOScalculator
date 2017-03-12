//
//  ViewController.swift
//  Calc
//
//  Created by Василий on 10.03.17.
//  Copyright © 2017 vasihc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet private weak var display: UILabel!
    
    private var userIsTheMiddleOfTyping = false
    
    @IBAction private func buttonDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userIsTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsTheMiddleOfTyping = true
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = calculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsTheMiddleOfTyping = false
        }
        if let mathematicSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicSymbol)
        }
        displayValue = brain.result
    }
    
    
}


