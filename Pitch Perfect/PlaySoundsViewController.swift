//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jeffrey Chau on 1/09/2015.
//  Copyright (c) 2015 Tigerspike. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    
    var receivedAudio:RecordedAudio!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IBAction functions

    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioAtSpeed(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioAtSpeed(2.0)
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioAtPitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioAtPitch(-1000)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        resetAudioVariables()
    }
    
    // MARK: Convenience functions
    
    func playAudioAtSpeed(speed: Float) {
        resetAudioVariables()
        audioPlayer.prepareToPlay()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioAtPitch(pitch: Float) {
        resetAudioVariables()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func resetAudioVariables() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
