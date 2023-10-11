//
//  MusicManager.swift
//  Amusica
//
//  This is the back bone of the player app
//  it manages the player and all the playing
//  pausing and repeat one song
//
//  It gets data from MusicInfo (this will cause lots of issues fix it asap)
//  and playes the song
//
//  it is accessable from whole app and this
//  object is the same through whole app
//
//  Created by Amir Mahdi Abravesh on 9/25/23.
//

import AVFoundation
import Foundation

class MusicManager: ObservableObject {
    var player: AVAudioPlayer!
    @Published private(set) var isPlaying: Bool = false       // returns the playing status
    @Published private(set) var isRepeatingOne: Bool = false  // returns the repeating one song status
    

    // playes the music for the first time
    func playMusic(_ songName: String) {
        let url = Bundle.main.url(forResource: songName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!) // handle the try and catch
        player.play()
        isPlaying = true
    }

    // stops the Music
    func stopMusic() {
        guard let player = player else { return }
        player.stop()
        isPlaying = false
    }

    // toggles between play and pause
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
    
    // toggles between repeat for one song or no
    func toggleRepeatOne() {
        guard let player = player else { return }
        
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isRepeatingOne = player.numberOfLoops != 0
    }
}
