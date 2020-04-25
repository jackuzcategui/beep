//
//  MainViewModel.swift
//  Beep
//
//  Created by Jack Uzcategui on 25/04/2020.
//  Copyright © 2020 __jackdaw__. All rights reserved.
//

import Foundation
import AVFoundation

class MainViewModel {
    var time: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        let seconds = Calendar.current.component(.second, from: date)
        if seconds % 2 == 0 {
            dateFormatter.dateFormat = "HH mm"
        } else {
            dateFormatter.dateFormat = "HH:mm"
        }
        return dateFormatter.string(from: date)
    }
    
    var timer: Timer?
    var notifyTimeChange: (() -> Void)?
    var player: AVAudioPlayer?
    var previousMinute: Int
    
    init() {
        try! AVAudioSession.sharedInstance().setActive(true)
        self.previousMinute = Calendar.current.component(.minute, from: Date())
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            self?.changeTime()
        })
    }
    
    func setupAudio() {
        do {
            try AVAudioSession
                .sharedInstance()
                .setCategory(.playback,
                             mode: .default,
                             options: [.duckOthers])
        } catch {
                print(error)
        }
    }
    
    func changeTime() {
        player?.stop()
        notifyTimeChange?()
        isTimeToChime()
    }
    
    func isTimeToChime() {
        let date = Date()
        let minutes = Calendar.current.component(.minute, from: date)
        if minutes != previousMinute && minutes == 0 && isNotSleepyTime() {
            chime()
            previousMinute = minutes
        }
    }
    
    func isNotSleepyTime() -> Bool {
        let date = Date()
        let hour = Calendar.current.component(.hour, from: date)
        if hour <= 23 && hour >= 6 {
            return true
        }
        
        return false
    }
    
    func chime() {
        let url = Bundle.main.url(forResource: "casio", withExtension: "wav")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error)
        }
    }
}
