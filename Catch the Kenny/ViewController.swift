//
//  ViewController.swift
//  Catch the Kenny
//
//  Created by Alper on 26.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    

    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 30
    var kennyArray = [UIImageView]()


    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let highScore = UserDefaults.standard.object(forKey: "highScore")
        if highScoreLabel.text == nil {
            highScoreLabel.text = "0"
            
        }
        if let newScore = highScore as? Int{
            highScoreLabel.text = "\(newScore)"
        }
       
        scoreLabel.text = "Score: \(score) "
        // MARK: Creating Timer
        timeLabel.text = "\(counter)"
        setupTimers()
//        Setup Tap Recognizer
        setupTapRecognizer()
//        Creating Array
        [kenny1,kenny2,kenny3,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9].forEach{kennyArray.append($0) }
        hideKenny()
    }
    
    fileprivate func setupTapRecognizer() {
        let tapRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScores))
        let tapRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScores))
        let tapRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScores))
        let tapRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScores))
        let tapRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScores))
        let tapRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScores))
        let tapRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScores))
        let tapRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScores))
        let tapRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScores))
        
        kenny1.addGestureRecognizer(tapRecognizer1)
        kenny2.addGestureRecognizer(tapRecognizer2)
        kenny3.addGestureRecognizer(tapRecognizer3)
        kenny4.addGestureRecognizer(tapRecognizer4)
        kenny5.addGestureRecognizer(tapRecognizer5)
        kenny6.addGestureRecognizer(tapRecognizer6)
        kenny7.addGestureRecognizer(tapRecognizer7)
        kenny8.addGestureRecognizer(tapRecognizer8)
        kenny9.addGestureRecognizer(tapRecognizer9)
        
        [kenny1,kenny2,kenny3,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9].forEach{$0?.isUserInteractionEnabled = true }
    }
    
    
    fileprivate func setupTimers() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
    @objc func increaseScores(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func countDown(){
        timeLabel.text = "\(counter)"
        counter -= 1
        if counter == 0 {
            [timer,hideTimer].forEach{$0.invalidate() }
            timeLabel.text = "0"
            if self.score > Int(highScoreLabel.text!)!{
                UserDefaults.standard.set(self.score, forKey: "highScore")
                highScoreLabel.text = String(self.score)
            }
            showAlert()
        
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Time", message: "Your time is up", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let replay = UIAlertAction(title: "Replay", style: .default) { (UIAlertAction) in
            self.replay()
        }
        [okBtn,replay].forEach{alert.addAction($0) }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func replay(){
        score = 0
        scoreLabel.text = "Score: \(score)"
        counter = 30
        timeLabel.text = "\(counter)"
        setupTimers()
        
        
    }
    
    
    @objc func hideKenny(){
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        let randomNumber = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[randomNumber].isHidden = false
    }
    
    
    
    
    
    
    
}

