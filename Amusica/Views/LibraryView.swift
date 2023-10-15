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

    var library: [MusicModel] = AmusicaApp.library

    var body: some View {
        NavigationStack {
            List {
                ForEach(library) { item in
                    MusicSingleListView(song: item.song ?? "Unknown",
                                        artist: item.artist ?? "Unknown",
                                        artwork: item.artwork!) // handle the optional
                        .onTapGesture {
                            musicManager.stopMusic()
                            musicManager.playMusic(item.name, extension: item.ext)
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
                    MusicSingleListView(song: library[index ?? 0].song ?? "Unknown",
                                        artist: library[index ?? 0].artist ?? "Unknown",
                                        artwork: library[index ?? 0].artwork!) // handle the optional
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
