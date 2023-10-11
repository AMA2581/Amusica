//
//  ContentView.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 9/24/23.
//

import AVFoundation
import SwiftUI

struct LibraryView: View {
    @State private var isShowingItemSheet = false
    @EnvironmentObject private var musicManager: MusicManager
    @State private var index: Int!

    var library: [MusicInfo] = Library.library

    var body: some View {
        NavigationStack {
            List {
                ForEach(library) { item in
                    MusicSingleListView(song: item.song,
                                        artist: item.artist,
                                        artwork: item.artwork)
                        .onTapGesture {
//                            isShowingItemSheet = true
                            musicManager.stopMusic()
//                            musicManager = MusicManager(songName: item.song)
                            musicManager.playMusic(item.song)
                            index = library.firstIndex(of: item) ?? 0
                        }
                }
            }
            .navigationTitle("Amusica")
            .sheet(isPresented: $isShowingItemSheet, content: {
                MusicView(musicInfo: library[index ?? 0])
            })

// MARK: - BottomStatusView
            if musicManager.player != nil {
                HStack(alignment: .center) {
                    MusicSingleListView(song: library[index ?? 0].song,
                                        artist: library[index ?? 0].artist,
                                        artwork: library[index ?? 0].artwork)
                    Spacer()
                    Button {
                        musicManager.playPauseToggle()
                    } label: {
                        Image(systemName: musicManager.isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.horizontal, 30)
                .onTapGesture {
                    isShowingItemSheet = true
                }
                .sheet(isPresented: $isShowingItemSheet) {
                    MusicView(musicInfo: library[index ?? 0])
                }
            }
//            .sheet(isPresented: $isShowingItemSheet) {
//              MusicView(musicInfo: library[0])
//            }
                
        }
        
    }
    
}

#Preview {
    LibraryView()
        .environmentObject(MusicManager())
}

// MARK: - MusicSingleListView

struct MusicSingleListView: View {
    let song: String
    let artist: String
    let artwork: UIImage

    var body: some View {
        HStack {
            Image(uiImage: artwork)
                .resizable()
                .frame(width: 50.0, height: 50.0)
                .cornerRadius(15)

            VStack(alignment: .leading) {
                Text(song)
                    .fontWeight(.semibold)
                    .font(.system(size: 22))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text(artist)
                    .fontWeight(.medium)
                    .font(.system(size: 18))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .opacity(0.6)
            }.padding(.horizontal, 15.0)
        }
    }
}
