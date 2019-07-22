//
//  ViewController.swift
//  DecideRight
//
//  Created by Maxim Spiridonov on 15/07/2019.
//  Copyright © 2019 GS Develop Inc. All rights reserved.
//

import UIKit
import AVFoundation

class InfinitoViewController: UIViewController {
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblTotalCorrect: UILabel!
    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    var firstNumber : Int = 0
    var secondNumber : Int = 0
    var answer : Int = 0
    
    var buttonCorrect : Int = 0
    
    var error1 : Int = 0
    var error2 : Int = 0
    var error3 : Int = 0
    
    var totalTrue : Int = 0
    var correctFalse : String = ""
    
    var aP = AVAudioPlayer()
    var aPS = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        randomizeTheNumbers()
        
        printButtonText()
        
        printCorrectIncorrect()
        
    }
    
    func buttonPresedSoundPlay() {
        let click = NSURL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "mp3")!)
        do {
            aPS = try AVAudioPlayer(contentsOf: click as URL)
            aPS.prepareToPlay()
        } catch {
            print("Problem in getting File")
        }
        aPS.play()
    }
    
    @IBAction func btnAnswer0ACTION(_ sender: UIButton) {
        if buttonCorrect == 0 {
            button0Correct()
        }else if buttonCorrect != 0 {
            incorrectLogic()
        }
    }
    
    @IBAction func btnAnswer1ACTION(_ sender: UIButton) {
        if buttonCorrect == 1 {
            button1Correct()
        }else if buttonCorrect != 1 {
            incorrectLogic()
        }
    }
    
    @IBAction func btnAnswer2ACTION(_ sender: UIButton) {
        if buttonCorrect == 2 {
            button2Correct()
        }else if buttonCorrect != 2 {
            incorrectLogic()
        }
    }
    
    @IBAction func btbAnswer3ACTION(_ sender: UIButton) {
        if buttonCorrect == 3 {
            button3Correct()
        }else if buttonCorrect != 3 {
            incorrectLogic()
        }
    }
    @IBAction func resetButtonACTION(_ sender: UIButton) {
        resetButton()
        buttonPresedSoundPlay()
    }
    
    func randomizeTheNumbers() {
        
        firstNumber = Int(arc4random_uniform(20))
        secondNumber = Int(arc4random_uniform(20))
        
        if firstNumber < secondNumber {
            firstNumber = Int(arc4random_uniform(20))
            secondNumber = Int(arc4random_uniform(20))
            
            if firstNumber < secondNumber {
                firstNumber = Int(arc4random_uniform(20))
                secondNumber = Int(arc4random_uniform(20))
                
                if firstNumber < secondNumber {
                    firstNumber = 10
                    secondNumber = 3
                }
            }
        }
        
        answer = firstNumber - secondNumber
        
        buttonCorrect = Int(arc4random_uniform(4))
        
        error1 = Int(arc4random_uniform(20))
        error2 = Int(arc4random_uniform(20))
        error3 = Int(arc4random_uniform(20))
        
        randomNumberCheck()
        printButtonText()
        printQuestion()
    }
    
    func printQuestion() {
        lblQuestion.text = "\(firstNumber) - \(secondNumber) = ?"
    }
    
    func randomNumberCheck() {
        if answer == error1 || answer == error2 || answer == error3 {
            error1 = Int(arc4random_uniform(20))
            error2 = Int(arc4random_uniform(20))
            error3 = Int(arc4random_uniform(20))
            
            if answer == error1 || answer == error2 || answer == error3 {
                error1 = Int(arc4random_uniform(20))
                error2 = Int(arc4random_uniform(20))
                error3 = Int(arc4random_uniform(20))
                
                if answer == error1 || answer == error2 || answer == error3 {
                    error1 = Int(arc4random_uniform(20))
                    error2 = Int(arc4random_uniform(20))
                    error3 = Int(arc4random_uniform(20))
                    
                    if answer == error1 || answer == error2 || answer == error3 {
                        error1 = 40
                        error2 = -1
                        error3 = 45
                    }
                }
            }
        }
    }
    
    func printButtonText() {
        if buttonCorrect == 0 {
            btn0.setTitle("\(answer)", for: .normal)
            btn1.setTitle("\(error1)", for: .normal)
            btn2.setTitle("\(error2)", for: .normal)
            btn3.setTitle("\(error3)", for: .normal)
        }
        
        if buttonCorrect == 1 {
            btn1.setTitle("\(answer)", for: .normal)
            btn0.setTitle("\(error3)", for: .normal)
            btn2.setTitle("\(error2)", for: .normal)
            btn3.setTitle("\(error1)", for: .normal)
        }
        
        if buttonCorrect == 2 {
            btn2.setTitle("\(answer)", for: .normal)
            btn1.setTitle("\(error1)", for: .normal)
            btn0.setTitle("\(error3)", for: .normal)
            btn3.setTitle("\(error2)", for: .normal)
        }
        
        if buttonCorrect == 3 {
            btn3.setTitle("\(answer)", for: .normal)
            btn1.setTitle("\(error3)", for: .normal)
            btn2.setTitle("\(error1)", for: .normal)
            btn0.setTitle("\(error2)", for: .normal)
        }
    }
    
    func incorrectLogic() {
        // play lose sound
        let loseSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "lose", ofType: "mp3")!)
        do {
            aP = try AVAudioPlayer(contentsOf: loseSound as URL)
            aP.prepareToPlay()
        } catch {
            print("Problem in getting File")
        }
        aP.play()
        
        // Wrong answer logic
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        UIView.animate(withDuration: 0.8, animations: {
            self.view.backgroundColor = UIColor.red
            
            UIView.animate(withDuration: 0.8, animations: {
                self.view.backgroundColor = UIColor.white
            }, completion: nil)
            
        }, completion: nil)
        
        correctFalse = "false :("
        
        totalTrue = totalTrue - 1
        saveBestScore()
        
        printCorrectIncorrect()
    }
    
    func correctLogic() {
        // win sound
        let winSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "win", ofType: "mp3")!)
        do {
            aP = try AVAudioPlayer(contentsOf: winSound as URL)
            aP.prepareToPlay()
        } catch {
            print("Problem in getting File")
        }
        aP.play()
        
        // other staff
        UIView.animate(withDuration: 0.8, animations: {
            self.view.backgroundColor = UIColor.green
            
            UIView.animate(withDuration: 0.8, animations: {
                self.view.backgroundColor = UIColor.white
            }, completion: nil)
            
        }, completion: nil)
        
        totalTrue = totalTrue + 1
        saveBestScore()
        correctFalse = "true :)"
        printCorrectIncorrect()
    }
    
    func button0Correct() {
        correctLogic()
    }
    
    func button1Correct() {
        correctLogic()
    }
    
    func button2Correct() {
        correctLogic()
    }
    
    func button3Correct() {
        correctLogic()
    }
    
    func saveBestScore(){
        if totalTrue >= 0 {
            UserDefaults.standard.setValue(totalTrue, forKey: "totalCorrect")
            UserDefaults.standard.synchronize()
        }
    }
    
    func printCorrectIncorrect() {
        totalTrue = UserDefaults.standard.integer(forKey: "totalCorrect")
        lblTotalCorrect.text = "\(totalTrue)"
        reset()
    }
    
    func resetButton(){
        totalTrue = 0
        UserDefaults.standard.removeObject(forKey: "totalCorrect")
        lblTotalCorrect.text = "\(totalTrue)"
        randomizeTheNumbers()
    }
    
    func reset() {
        randomizeTheNumbers()
    }
}

