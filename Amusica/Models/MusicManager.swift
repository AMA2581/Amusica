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

class MusicManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer!
    var nextSong: MusicModel!
    var previousSong: MusicModel!
    var library = AmusicaApp.library
    @Published private(set) var currentMusic: MusicModel!
    @Published private(set) var index: Int = 0
    @Published private(set) var isPlaying: Bool = false // returns the playing status
    @Published private(set) var isRepeatingOne: Bool = false // returns the repeating one song status

    override init() {
        super.init()
    }

    // playes the music for the first time
    func playMusic(_ songName: String, extension ext: String) {
        let url = Bundle.main.url(forResource: songName, withExtension: ext)
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player.delegate = self
            currentMusic = library[index]
            player.play()
            isPlaying = true
        } catch {
            print("file did not found")
        }
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

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if !isRepeatingOne {
            // play next
            isPlaying = false
            playNext()
        } else {
            // loop same song
            print("loops the same song")
            isPlaying = false
        }
    }

    // saves the next song
    func nextSong(_ musicModel: MusicModel) {
        nextSong = musicModel
    }

    // saves the previous song
    func previousSong(_ musicModel: MusicModel) {
        previousSong = musicModel
    }

    // playes the next song
    func playNext() {
        setNextSongIndex()
        nextSong(library[index])
        playMusic(nextSong.name, extension: nextSong.ext)
    }

    // playes the previous song
    func playPrevious() {
        setPreviousSongIndex()
        previousSong(library[index])
        playMusic(previousSong.name, extension: previousSong.ext)
    }

    func setIndex(_ index: Int) {
        self.index = index
    }

    func setNextSongIndex() {
        if index < (library.count - 1) {
            index = index + 1
        } else {
            index = 0
        }
    }

    func setPreviousSongIndex() {
        if index > 0 {
            index = index - 1
        } else {
            index = library.count - 1
        }
    }
}
