//
//  MusicInfo.swift
//  Amusica
//
// It stores information about the song and
// we can use it later for playing the song
// and displaying the information in MusicView
// and BottomStatusView that you can find in
// LibraryView
//
//  Created by Amir Mahdi Abravesh on 9/25/23.
//

import AVFoundation
import Foundation
import UIKit

class MusicInfo: Identifiable, Equatable {
    let song: String // song's name
    let artist: String // artist name
    let artwork: UIImage // artwork Image for displaying

    init(song: String, artist: String, artwork: UIImage) {
        self.song = song
        self.artist = artist
        self.artwork = artwork
    }

    static func == (lhs: MusicInfo, rhs: MusicInfo) -> Bool {
        return lhs.song == rhs.song && lhs.artist == rhs.artist && lhs.artwork == rhs.artwork
    }
}
