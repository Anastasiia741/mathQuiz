//
//  PlaySounds.swift
//  mathQuiz
//
//  Created by Анастасия Набатова on 13/8/24.
//

import SwiftUI
import AVKit

enum SoundOption: String {
    case nope
    case winner
}

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
            return
        }
    
        
        do {
            player = try AVAudioPlayer(contentsOf:  url)
            player?.play()
        } catch let error {
            print("Sound error: \(error.localizedDescription)")
        }
    }
}
