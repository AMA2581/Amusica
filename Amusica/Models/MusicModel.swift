//
//  MusicModel.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/5/23.
//

import AVKit
import Foundation

class MusicModel: Identifiable, Equatable {
    var playerItem: AVPlayerItem? // accessing to the song
    var metadataList: [AVMetadataItem]? // getting metadata
    let name: String // file name of the song
    let ext: String // file extension of the song
    var song: String? // song name
    var artist: String? // song's artist
    var artwork: UIImage? // song's artwork image

    // for initializing an empty MusicModel
    init() {
        name = "something"
        ext = "something"
    }

    // an URL should be passed to know where the path of the song is
    // to get the metadata of that song
    init(path: URL, name: String, ext: String) {
        self.name = name
        self.ext = ext
        playerItem = AVPlayerItem(url: path)
        metadataList = playerItem!.asset.metadata as! [AVMetadataItem] // handle the optional
        for item in metadataList! {
            if item.commonKey == nil {
                continue
            }

            if let key = item.commonKey, let value = item.value {
                if key.rawValue == "title" {
                    song = value as? String
                }
                if key.rawValue == "artist" {
                    artist = value as? String
                }
                if key.rawValue == "artwork" {
                    if let audioImage = UIImage(data: (value as! NSData) as Data) {
                        artwork = audioImage
                    }
                }
            }
        }
    }

    static func == (lhs: MusicModel, rhs: MusicModel) -> Bool {
        return lhs.song == rhs.song && lhs.artist == rhs.artist && lhs.artwork == rhs.artwork && lhs.name == rhs.name && lhs.ext == rhs.ext && lhs.playerItem == rhs.playerItem && lhs.metadataList == rhs.metadataList
    }
}
