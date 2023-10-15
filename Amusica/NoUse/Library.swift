//
//  Library.swift
//  Amusica
//
// This is a library created by the music files
// it does not enclude the actual file but it
// stores the name and artist name and artwork
// image
//
//  Created by Amir Mahdi Abravesh on 10/6/23.
//

import Foundation
import UIKit

struct Library {
    static var library: [MusicInfo] {
        var temp: [MusicInfo] = []
        for item in AmusicaApp.library {
            // adding items to the list, library
            temp.append(MusicInfo(song: item.song!, // handle the optional
                      artist: item.artist!,          // handle the optional
                      artwork: item.artwork!))       // handle the optional
        }
        return temp
    }
}
