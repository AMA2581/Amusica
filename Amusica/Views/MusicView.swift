//
//  MusicView.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 9/24/23.
//

import AVFoundation
import SwiftUI

struct MusicView: View {
    @EnvironmentObject private var musicManager: MusicManager
    @Environment(\.dismiss) private var dismiss
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false

    var musicInfo: MusicModel
    let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        NavigationStack {
            ZStack {
                MusicBackgroundView(artwork: musicInfo.artwork!) // handle the optional

                VStack {
                    Button {
                        dismiss()
                    } label: {
                        DismissButton()
                    }

                    AlbumCoverView(artwork: musicInfo.artwork!) // handle the optional
                        .padding(.all, 15.0)
                    MusicTitleView(song: musicInfo.song!, color: Color((musicInfo.artwork?.averageColor!)!)) // handle the optional
                    MusicArtistView(artist: musicInfo.artist!, color: Color((musicInfo.artwork?.averageColor!)!)) // handle the optional
                    Spacer()

                    if let player = musicManager.player {
                        Slider(value: $value, in: 0 ... player.duration) { editing in
                            isEditing = editing
                            if !editing {
                                player.currentTime = value
                            }
                        }
                        .frame(width: 320.0)

                        MusicControlsView(shuffle: true, color: Color((musicInfo.artwork?.averageColor!)!)) // handle the optional
                    }
                }
            }.background(Color.black)
        }
        .onReceive(timer, perform: { _ in
            guard let player = musicManager.player, !isEditing else { return }
            value = player.currentTime
        })
//            .onAppear {
//                musicInfo.playSound()
//            }
//        .padding(.all, 20.0)
    }
}

#Preview {
    MusicView(musicInfo: AmusicaApp.library.first!)
        .environmentObject(MusicManager())
}
