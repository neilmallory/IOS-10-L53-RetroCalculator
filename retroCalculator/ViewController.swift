//
//  ViewController.swift
//  retroCalculator
//
//  Created by neil mallory on 15/05/2017.
//  Copyright © 2017 neil mallory. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftVal = ""
    var rightVal = ""
    var result = ""
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    let path = Bundle.main.path(forResource: "btn", ofType: "wav")
    let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay();
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    outputLabel.text = "0"
    
    }

    @IBAction func clearButtonPressed(_ sender: Any) {
        playSound()
        
        leftVal = ""
        rightVal = ""
        result = ""
        currentOperation = .Empty
        runningNumber = ""
        outputLabel.text = "0"
    }
    
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumber += ("\(sender.tag)")
        outputLabel.text = runningNumber
        
    }
    
    @IBAction func multiplyButtonPressed(sender: UIButton){
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func divideButtonPressed(sender: UIButton){
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func addButtonPressed(sender: UIButton){
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func subtractButtonPressed(sender: UIButton){
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func equalButtonPressed(sender: UIButton){
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        
        btnSound.play()
    }

    func processOperation(operation: Operation)  {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightVal = runningNumber
                runningNumber = ""
                
                // catch leftVal = "" when operation button pressed first
                // output label = 0 so should add rightVal to 0
                if leftVal == "" {
                    leftVal = "0"
                }
                
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVal)! * Double(rightVal)!)"
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                }
                
                leftVal = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {
     
            // this is the first time an operator is pressed
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}

