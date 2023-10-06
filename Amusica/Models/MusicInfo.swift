//
//  MusicInfo.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 9/25/23.
//

import AVFoundation
import Foundation
import UIKit

class MusicInfo: Identifiable, Equatable {
    static func == (lhs: MusicInfo, rhs: MusicInfo) -> Bool {
        return lhs.song == rhs.song && lhs.artist == rhs.artist && lhs.artwork == rhs.artwork
    }

    let song: String
    let artist: String
    let artwork: UIImage

    init(song: String, artist: String, artwork: UIImage) {
        self.song = song
        self.artist = artist
        self.artwork = artwork

//        let mamad = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print(mamad)
//        let itemsInDirectory = try! FileManager.default.contentsOfDirectory(at: mamad[0], includingPropertiesForKeys: nil)
//        print(itemsInDirectory)
//        let ali = Bundle.main.resourcePath
//        print(ali)
//        let itemsInDirectory = try! FileManager.default.contentsOfDirectory(atPath: "/Users/ama25/Documents/Amusica/Amusica/Library")
//        print(itemsInDirectory)
//        let fileName : NSString = NSString(string: itemsInDirectory[0])
//        print(fileName.deletingPathExtension)
    }
}
