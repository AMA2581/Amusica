//
//  AmusicaApp.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 9/24/23.
//

import SwiftUI

@main
struct AmusicaApp: App {
    @StateObject var musicManager = MusicManager()
    static var musicModel: [MusicModel] = []

    init() {
        let assetFolderUrl = Bundle.main.resourceURL
//        print(assetFolderUrl?.absoluteString ?? "nothing")
        do {
            if let assetFolderUrl {
                let itemsInDirectory = try FileManager.default.contentsOfDirectory(at: assetFolderUrl, includingPropertiesForKeys: nil)
                for item in itemsInDirectory {
                    let fileName: NSString = NSString(string: item.absoluteString)
                    if fileName.pathExtension == "mp3" {
                        let parsed = fileName.lastPathComponent.replacingOccurrences(of: "%20", with: " ")
                        let anotherFileName: NSString = NSString(string: parsed)
//                        print(anotherFileName.deletingPathExtension)
//                        print(anotherFileName.pathExtension)
                        AmusicaApp.musicModel.append(MusicModel(path: item, name: anotherFileName.deletingPathExtension, ext: anotherFileName.pathExtension))
//                        print(AmusicaApp.musicModel.count)
                    }
                }
            }
        } catch {
            print(error)
        }
    }

    var body: some Scene {
        WindowGroup {
            LibraryView()
                .environmentObject(musicManager)
        }
    }
}
