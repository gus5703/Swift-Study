//
//  GameView.swift
//  구구단을 외자
//
//  Created by 왕승현 on 2016. 2. 17..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class GameView: UIViewController {
    
    @IBOutlet weak var num1Label: UILabel!
    @IBOutlet weak var num2Label: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let CountFrame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
    let hideView = UIView()
    
    var countImage: CountImage!
    var numArray: [Int] = [0,1,2,3,4,5,6,7,8,9]
    var num1: Int = 0
    var num2: Int = 0
    var answer: Int = 0
    var timer: NSTimer = NSTimer()
    var timerCount: Int = 60
    var score: Int = 0
    var count: [Int] = [0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countImage = CountImage(frame: self.CountFrame)
        gameStart()
    }
    
    override func viewWillAppear(animated: Bool) {
        //countImage.count()
        //self.view.addSubview(countImage)
        
        enterButton.addTarget(self, action: "next", forControlEvents: UIControlEvents.TouchUpInside)
        enterButton.layer.cornerRadius = 10
        
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerAction", userInfo: nil, repeats: true)
    }
    
    // timer 
    func timerAction(){
        --timerCount
        timeLabel.text = String(timerCount)
        if timerCount == 0 {
            timer.invalidate()
            gameEnd()
        }
    }
    // numArray random shuffle
    func shuffle(){
        for var i = 10; i >= 1; i-- {
            var randomNumber = Int(arc4random_uniform(UInt32(i)))
            var temp = numArray[i - 1]
            numArray[i - 1] = numArray[randomNumber]
            numArray[randomNumber] = temp
        }
    }
    // button's Image set
    func buttonSet(){
        for i in 0...9{
            buttonArray[i].setImage(UIImage(named: "number_\(numArray[i]).png"), forState: UIControlState.Normal)
            buttonArray[i].setTitle(String(numArray[i]), forState: UIControlState.Normal)
            buttonArray[i].layer.cornerRadius = 10
            buttonArray[i].addTarget(self, action: "addButtonNumber:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    // random number multiple
    func question() {
        num1 = Int(arc4random_uniform(9))
        num2 = Int(arc4random_uniform(9))
        answer = num1 * num2
        self.num1Label.text = String(num1)
        self.num2Label.text = String(num2)
        self.answerLabel.text = ""
    }
    // button's number add to answerText
    func addButtonNumber(sender: UIButton) {
        let button: UIButton = sender
        let buttonNumber: Character! = Character(button.currentTitle!)
        var inputText: [Character] = Array(answerLabel.text!.characters)
        var inputSave: String = ""
        if inputText.count < 2 {
            inputText.append(buttonNumber)
            for i in inputText {
                inputSave.append(i)
            }
            answerLabel.text = "\(inputSave)"
        } else if inputText.count == 2{
            inputText[0] = inputText[1]
            inputText[1] = buttonNumber
            answerLabel.text = "\(inputText[0])\(inputText[1])"
        }
    }
    
    func check() {
        let answerText: String = answerLabel.text!
        if Int(answerText) == answer {
            count[0]++
            score += 100
            scoreLabel.text = String(score)
            print("[*] correct!")
        } else {
            count[1]++
            score -= 50
            if score < 0{
                score = 0
            }
            scoreLabel.text = String(score)
            print("[!] Wrong!!")
        }
    }
    
    func gameStart() {
        question()
        shuffle()
        buttonSet()
    }
    
    func gameEnd() {
        let backGroundView = UIView()
        let endView = UIView()
        let endViewSize = CGSize(width: 300, height: 400)
        let endButton = UIButton()
        let endButtonSize = CGSize(width: 100, height: 50)
        let scoreTitle = UILabel()
        let scoreSize = CGSize(width: 200, height: 20)
        let scoreLabel = UILabel()
        let scoreLabelSize = CGSize(width: 200, height: 60)
        let correctCountTitle = UILabel()
        let correctCountLabel = UILabel()
        
        
        backGroundView.frame = self.view.bounds
        backGroundView.backgroundColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 0.7)
        self.view.addSubview(backGroundView)
        
        endView.frame.size = endViewSize
        endView.backgroundColor =
            UIColor(red: 255/255.0, green: 211/255.0, blue: 70/255.0, alpha: 0.99)
        endView.center.x = self.view.center.x
        print(endView.center.x)
        endView.center.y = self.view.center.y
        endView.layer.cornerRadius = 6
        backGroundView.addSubview(endView)
        
        endButton.backgroundColor =
            UIColor(red: 204/255.0, green: 102/255.0, blue: 0, alpha: 1.0)
        endButton.frame.size = endButtonSize
        endButton.layer.cornerRadius = 6
        endButton.center.x = 150
        endButton.center.y = 340
        endButton.setTitle("확인", forState: UIControlState.Normal)
        endButton.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
        endView.addSubview(endButton)
        
        scoreTitle.frame.size = scoreSize
        scoreTitle.center.x = 150
        scoreTitle.frame.origin.y = 50
        scoreTitle.text = "점수"
        scoreTitle.textAlignment = .Center
        scoreTitle.textColor =
            UIColor(red: 255/255.0, green: 128/255.0, blue: 0, alpha: 1.0)
        endView.addSubview(scoreTitle)
        
        scoreLabel.frame.size = scoreLabelSize
        scoreLabel.backgroundColor = UIColor.whiteColor()
        scoreLabel.center.x = 150
        scoreLabel.frame.origin.y = 90
        scoreLabel.layer.cornerRadius = 6
        scoreLabel.textAlignment = .Center
        scoreLabel.clipsToBounds = true
        scoreLabel.text = String(score)
        endView.addSubview(scoreLabel)
        
        correctCountTitle.frame.size = scoreSize
        correctCountTitle.center.x = 150
        correctCountTitle.frame.origin.y = 170
        correctCountTitle.text = "맞은개수/틀린개수"
        correctCountTitle.textAlignment = .Center
        correctCountTitle.textColor =
            UIColor(red: 255/255.0, green: 128/255.0, blue: 0, alpha: 1.0)
        endView.addSubview(correctCountTitle)
        
        correctCountLabel.frame.size = scoreLabelSize
        correctCountLabel.backgroundColor = UIColor.whiteColor()
        correctCountLabel.center.x = 150
        correctCountLabel.frame.origin.y = 210
        correctCountLabel.layer.cornerRadius = 6
        correctCountLabel.textAlignment = .Center
        correctCountLabel.clipsToBounds = true
        correctCountLabel.text = String("\(count[0])/\(count[1])")
        endView.addSubview(correctCountLabel)
        
        
        
    }
    func back(sender: UIButton) {
        self.performSegueWithIdentifier("main", sender: self)
    }
    
    func next(){
        check()
        question()
        shuffle()
        buttonSet()
    }
    
}
