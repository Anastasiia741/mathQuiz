//  PlaySounds.swift
//  mathQuiz
//  Created by Анастасия Набатова on 13/8/24.

import SwiftUI
import AVKit

enum SoundOption: String {
    case nope
    case winner
}

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    var isSoundEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Accesses.isOnSounds)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Accesses.isOnSounds)
            if !newValue {
                player?.stop()
                player = nil
            }
        }
    }
    
    func playSound(sound: SoundOption) {
        guard isSoundEnabled else { return }
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Sound error: \(error.localizedDescription)")
        }
    }
}
