//
//  ViewController.swift
//  CatchForrest
//
//  Created by Atilla Ertürk on 23.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image9: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var timeBar: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    var timer = Timer()
    var progressTimer = Timer()
    var counter = 11;
    var progressValue = 1.0;
    var score = 0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighscore == nil {
            highScore = 0
            highscoreLabel.text = ""
        }
        if let newScore = storedHighscore as? Int {
            highScore = newScore
            highscoreLabel.text = String(highScore)
        }
        
        let recognizer1 = UITapGestureRecognizer(target:self, action: #selector(addScore))
        let recognizer2 = UITapGestureRecognizer(target:self, action: #selector(addScore))
        let recognizer3 = UITapGestureRecognizer(target:self, action: #selector(addScore))
        let recognizer4 = UITapGestureRecognizer(target:self, action: #selector(addScore))
        let recognizer5 = UITapGestureRecognizer(target:self, action: #selector(addScore))
        let recognizer6 = UITapGestureRecognizer(target:self, action: #selector(addScore))
        let recognizer7 = UITapGestureRecognizer(target:self, action: #selector(addScore))
        let recognizer8 = UITapGestureRecognizer(target:self, action: #selector(addScore))
        let recognizer9 = UITapGestureRecognizer(target:self, action: #selector(addScore))
        
    
        
        let imageList = [image1, image2, image3, image4, image5, image6, image7, image8, image9]
        for i in imageList {
            i!.isHidden = true
            i!.isUserInteractionEnabled = true
            
        }
        image1.addGestureRecognizer(recognizer1)
        image2.addGestureRecognizer(recognizer2)
        image3.addGestureRecognizer(recognizer3)
        image4.addGestureRecognizer(recognizer4)
        image5.addGestureRecognizer(recognizer5)
        image6.addGestureRecognizer(recognizer6)
        image7.addGestureRecognizer(recognizer7)
        image8.addGestureRecognizer(recognizer8)
        image9.addGestureRecognizer(recognizer9)
        score = 0
        scoreLabel.text = "\(score)"
        counter = 10;
        timeLabel.text = "10"
        timeBar.setProgress(1.0, animated: true)
        timer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeCount), userInfo: nil, repeats: true)
        progressTimer = .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(progressTime), userInfo: nil, repeats: true)
        
        
    }
    
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message + String(score), preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        let restartButton = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.score = 0
            self.counter = 10
            self.scoreLabel.text = String(self.score)
            self.progressValue = 1
            self.timeLabel.text = "10"
            self.timer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeCount), userInfo: nil, repeats: true)
            self.progressTimer = .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.progressTime), userInfo: nil, repeats: true)
            
            
            
        }
        alert.addAction(button)
        alert.addAction(restartButton)
        
        self.present(alert, animated: true)
    }
    
    @objc func addScore(){
    
        score += 1
        scoreLabel.text = "\(score)"
        
    }
    @objc func progressTime(){
        progressValue -= 0.009
        timeBar.setProgress(Float(progressValue), animated: true)
    }
    
    @objc func timeCount(){
        let imageList = [image1, image2, image3, image4, image5, image6, image7, image8, image9]
        timeLabel.text = "\(counter)"
        counter -= 1
        
        for i in imageList {
            i!.isHidden = true
        }
        
        let randomInt = Int.random(in: 0..<9)
        imageList[randomInt]!.isHidden = false
        
        
        
        if counter < 0 {
            timer.invalidate()
            progressTimer.invalidate()
            timeLabel.text = "Time's out!"
            timeBar.progress = 0
            showAlert(title: "Game Over!", message: "Your score is: ")
            for i in imageList {
                i!.isHidden = true
            }
            
            if score > highScore {
                highScore = score
                highscoreLabel.text = String(highScore)
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
        }
    }


}

