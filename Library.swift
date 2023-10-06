//
//  Library.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/6/23.
//

import Foundation
import UIKit

struct Library {
    static var library: [MusicInfo] {
        var temp: [MusicInfo] = [MusicInfo(song: AmusicaApp.musicModel[0].trackLabel!,
                                           artist: AmusicaApp.musicModel[0].artistLabel!,
                                           artwork: AmusicaApp.musicModel[0].artistImage!)]
        var flag = true
        for item in AmusicaApp.musicModel {
            temp.append(MusicInfo(song: item.trackLabel!,
                      artist: item.artistLabel!,
                      artwork: item.artistImage!))
            if flag {
                temp.removeFirst()
                flag = false
            }
        }
        return temp
    }
}
