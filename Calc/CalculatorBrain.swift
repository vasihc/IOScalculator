//
//  CalculatorBrain.swift
//  Calc
//
//  Created by Василий on 11.03.17.
//  Copyright © 2017 vasihc. All rights reserved.
//

import Foundation


class calculatorBrain
{
    private var accumulator = 0.0
    func setOperand (operand: Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation>  = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "±" : Operation.UnaryOperation({-$0}),
        "×" : Operation.BinaryOperation({$0 * $1 }),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "−" : Operation.BinaryOperation({$0 - $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value) :
                accumulator = value
            case .UnaryOperation(let foo) :
                accumulator = foo(accumulator)
            case .BinaryOperation(let foo) :
                executePendingBinaryOperation() 
                pending = PendingBinaryOperationInfo(binaryFunction: foo, firstOperand: accumulator)
            case .Equals :
                executePendingBinaryOperation()
                
            }
        }
    }
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    private var  pending: PendingBinaryOperationInfo?
    
   private struct PendingBinaryOperationInfo {
        var binaryFunction : (Double, Double) -> Double
        var firstOperand : Double
        
    }
    var result: Double {
        get {
            return accumulator
        }
    }
}
