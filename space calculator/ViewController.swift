//
//  ViewController.swift
//  space calculator
//
//  Created by Eric Cuevas on 5/7/16.
//  Copyright © 2016 mackenstein. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
   
    enum Operation: String{
        case divide = "/"
        case multiply = "*"
        case subtract = "-"
        case add = "+"
        case empty = "empty"
    }
    
    @IBOutlet weak var outputlbl : UILabel!
    
    var btnsound: AVAudioPlayer!
    var runningnumber = ""
    var leftValstr = ""
    var rightValstr = ""
    var currentoperation : Operation = Operation.empty
    var result = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundurl = NSURL(fileURLWithPath: path!)
        do{
            try btnsound = AVAudioPlayer(contentsOfURL: soundurl)
            btnsound.prepareToPlay()
        } catch let err as NSError{
          print(err.debugDescription)
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func numpressed(btn : UIButton!){
        playsound()
        runningnumber += "\(btn.tag)"
        outputlbl.text = runningnumber
    }

    @IBAction func equalpressed(sender: AnyObject) {
        processoperation(currentoperation)
    }
    
    @IBAction func addpressed(sender: AnyObject) {
        processoperation(Operation.add)
    }
    
    @IBAction func subtractpressed(sender: AnyObject) {
        processoperation(Operation.subtract)
    }
    
    @IBAction func multiplypressed(sender: AnyObject) {
        processoperation(Operation.multiply)
    }
    
    @IBAction func Dividepressed(sender: AnyObject) {
        processoperation(Operation.divide)
    }
    @IBAction func clearPressed(sender :AnyObject) {
        playsound()
        runningnumber = ""
        leftValstr = ""
        rightValstr = ""
        currentoperation = Operation.empty
        result = ""
        outputlbl.text = "0"
    
    }
    
    func processoperation(op: Operation) {
        playsound()
        if currentoperation != Operation.empty {
            //run math
            if runningnumber != ""{
                rightValstr = runningnumber
                runningnumber = ""
                if currentoperation == Operation.multiply {
                    result = "\(Double(leftValstr)! * Double(rightValstr)!)"
                }else if currentoperation == Operation.divide {
                    result = "\(Double(leftValstr)! / Double(rightValstr)!)"
                }else if  currentoperation == Operation.add {
                    result = "\(Double(leftValstr)! + Double(rightValstr)!)"
                }else if currentoperation == Operation.subtract {
                    result = "\(Double(leftValstr)! - Double(rightValstr)!)"
                }
                leftValstr = result
                outputlbl.text = result
            }
            
            currentoperation = op
            
    
        } else {
            // first time operator is pressed
            leftValstr = runningnumber
            runningnumber = ""
            currentoperation = op
        }
        
    }
    func playsound (){
        if btnsound.playing{
            btnsound.stop()
        }
        btnsound.play()
    }
}

