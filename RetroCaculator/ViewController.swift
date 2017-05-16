//
//  ViewController.swift
//  RetroCaculator
//
//  Created by Ben on 2017/5/14.
//  Copyright © 2017年 Boyce. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var OutputLbl: UILabel!
    
    var soundBtn: AVAudioPlayer!
    
    enum Operation: String {
        case add = "+"
        case subtract = "-"
        case divide = "/"
        case multiply = "*"
        case empty = "empty"
    }
    
    var runningNumber = ""
    var leftHNumber = ""
    var rightHNumber = ""
    var result = ""
    var currentOperation = Operation.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)

        do {
            try soundBtn = AVAudioPlayer(contentsOf: soundURL)
            soundBtn.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        OutputLbl.text = "0.0"
    }
    
    @IBAction func numbersPressed(sender: UIButton) {
        playSound()
        if !(sender.tag == 0 && OutputLbl.text == "0") {
            runningNumber += "\(sender.tag)"
            OutputLbl.text = runningNumber
        }
        
    }
    
    @IBAction func addPressed(sender: AnyObject) {
        processOperation(operation: .add)
    }
    @IBAction func subtractPressed(sender: AnyObject) {
        processOperation(operation: .subtract)
    }
    @IBAction func mutiplyPressed(sender: AnyObject) {
        processOperation(operation: .multiply)
    }
    @IBAction func dividePressed(sender: AnyObject) {
        processOperation(operation: .divide)
    }
    @IBAction func equalPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    @IBAction func clearPressed(_ sender: Any) {
        clearAll()
    }
    
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.empty {
            print("Hell")
            if runningNumber != "" {
                rightHNumber = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.multiply {
                    result = "\(Double(leftHNumber)! * Double(rightHNumber)!)"
                } else if currentOperation == Operation.divide {
                    result = "\(Double(leftHNumber)! / Double(rightHNumber)!)"
                } else if currentOperation == Operation.subtract {
                    result = "\(Double(leftHNumber)! - Double(rightHNumber)!)"
                } else if currentOperation == Operation.add {
                    result = "\(Double(leftHNumber)! + Double(rightHNumber)!)"
                }
                
                leftHNumber = result
                OutputLbl.text = result
            }
            
            currentOperation = operation
            
        } else {
            leftHNumber = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func clearAll() {
        playSound()
        runningNumber = ""
        leftHNumber = ""
        rightHNumber = ""
        result = ""
        currentOperation = Operation.empty
        OutputLbl.text = "0.0"
    }
    
    
    func playSound() {
        if soundBtn.isPlaying {
            soundBtn.stop()
        }
        soundBtn.play()
    }
}

