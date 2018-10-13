//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Costin Valu on 7/17/18.
//  Copyright © 2018 Andreea Goder. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
        
    var currentOperation = Operation.Empty

  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
            } catch let err as NSError {
            print(err.debugDescription)
            }
        
        outputLbl.text = "0"
    
    }
    
    func playSound() {
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
   
    func processOperation(operation: Operation) {
         playSound()
        if currentOperation != Operation.Empty {
            
                if runningNumber != "" {
                    rightValStr = runningNumber
                    runningNumber = ""
                    
                    if currentOperation == Operation.Multiply {
                        result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    } else if currentOperation == Operation.Divide {
                        result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    } else if currentOperation == Operation.Subtract {
                        result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    } else if currentOperation == Operation.Add {
                        result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    }
                    
                    leftValStr = result
                    outputLbl.text = result
                }
                
                currentOperation = operation
            } else {
                //This is the first time an operator has been pressed
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = operation
            }
        }
        
        
}









