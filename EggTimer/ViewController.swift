//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timer = Timer()
    var player : AVAudioPlayer?
    let eggTimes = ["Soft":30, "Medium":42, "Hard":72]
    
    var totalTime = 0
    var secondsPast = 0
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3") else{return}
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func updateCounter() {
        if secondsPast < totalTime {
            let percentageProgress = Float(secondsPast) / Float(totalTime)
            progressBar.progress = percentageProgress
            secondsPast += 1
            print(percentageProgress)
        } else {
            progressBar.progress = 1
            timer.invalidate()
            playSound()
            mainLabel.text = "DONE !!!"
        }
    }

    @IBAction func hardnesSelected(_ sender: UIButton) {
        totalTime = 0
        secondsPast = 0
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        mainLabel.text = hardness
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

    }
}
