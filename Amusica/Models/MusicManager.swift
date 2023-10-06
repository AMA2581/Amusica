//
//  MusicManager.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 9/25/23.
//

import AVFoundation
import Foundation

class MusicManager: ObservableObject {
    var player: AVAudioPlayer!
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var isRepeatingOne: Bool = false
    

    func playMusic(_ songName: String) {
        let url = Bundle.main.url(forResource: songName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        isPlaying = true
    }

    func stopMusic() {
        guard let player = player else { return }
        player.stop()
        isPlaying = false
    }

    func playPauseToggle() {
        guard let player = player else { return }
        if isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func toggleRepeatOne() {
        guard let player = player else { return }
        
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isRepeatingOne = player.numberOfLoops != 0
    }

//    func isPlaying() -> Bool {
//        if player != nil {
//            return player.isPlaying
//        } else {
//            return false
//        }
//    }
}
