//
//  MusicModel.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/5/23.
//

import AVKit
import Foundation

class MusicModel: ObservableObject {
    var playerItem: AVPlayerItem?
    var metadataList: [AVMetadataItem]?
    let name: String
    let ext: String
    var trackLabel: String?
    var artistLabel: String?
    var artistImage: UIImage?

    init() {
        name = "something"
        ext = "something"
    }

    init(path: URL, name: String, ext: String) {
        self.name = name
        self.ext = ext
        playerItem = AVPlayerItem(url: path)
        metadataList = playerItem!.asset.metadata as! [AVMetadataItem]
        for item in metadataList! {
            if item.commonKey == nil {
                continue
            }

            if let key = item.commonKey, let value = item.value {
                // println(key)
                // println(value)
                if key.rawValue == "title" {
                    trackLabel = value as? String
                }
                if key.rawValue == "artist" {
                    artistLabel = value as? String
                }
                if key.rawValue == "artwork" {
                    if let audioImage = UIImage(data: (value as! NSData) as Data) {
                        // println(audioImage.description)
                        artistImage = audioImage
                    }
                }
            }
        }
        
//        print(trackLabel)
//        print(artistLabel)
    }
}
