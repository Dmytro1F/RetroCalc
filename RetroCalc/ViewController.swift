//
//  ViewController.swift
//  RetroCalc
//
//  Created by Dmytro Fedorov on 9/28/16.
//  Copyright © 2016 Dmytro Fedorov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    

    @IBOutlet weak var outputLbl: UILabel!
    
    @IBAction func numberPressed(sender: UIButton) { //Buttons Connected to play Sound
        
        playSound()
        
        runningNumber += "\(sender.tag)" //making btn tags work as a magic
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed (sender: AnyObject) {
        
        processOperation(operation : .Divide)
        
    }
    @IBAction func onMultiplyPressed (sender: AnyObject) {
        
        processOperation(operation : .Multiply)
        
    }
    @IBAction func onSubtractPressed (sender: AnyObject) {
        
        processOperation(operation : .Subtract)
        
    }
    @IBAction func onAddPressed (sender: AnyObject) {
        
        processOperation(operation : .Add)
        
    }
    
    @IBAction func onEauqlPressed (sender: AnyObject) {
        
        processOperation(operation: currentOperation)
        
    }
    
    @IBAction func onClearPressed (sender: UIButton) {
        
        processOperation(operation: .Clear)
        
        }
    
    func playSound() { // Function to play Sound
        
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    var currentOperation = Operation.Empty
    
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            //A user selected operator, and then selected another operator without first entering number
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                switch operation {
                case .Add: result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                case .Divide:   result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                case .Multiply: result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                case .Subtract:  result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                case .Empty:
                    leftValStr.removeAll()
                    rightValStr.removeAll()
                    result = "0"
                default :
                    result = "?"
                }
              
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        }
        else {
            
            // this is the first time operator being pressed
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
    }

    override func viewDidLoad() { // Making code for the Sound!
        
        super.viewDidLoad()
        
         outputLbl.text = "0"
        
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav") //Finding the path of our audio file
        let soundURL = URL(fileURLWithPath: path!) // Declaring that path (URL)
        
        do { //Making cross check
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as Error { //This needed in case if there is a possibility that the audio file that we need is missing
            
            print("Error!")
            
        }
    }
}
