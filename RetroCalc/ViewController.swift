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

    
    @IBAction func numberPressed(sender: UIButton) { //Buttons Connected to play Sound
        
        playSound()
        
    }
    
    func playSound() { // Function to play Sound
        
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() { // Making code for the Sound!
        
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav") //Finding the path of our audio file
        let soundURL = URL(fileURLWithPath: path!) // Declaring that path (URL)
        
        do { //Making cross check
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as Error { //This needed in case if there is a possibility that the audio file that we need is missing
            
            print("Error!")
            
        }
        
 

    }}
