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

    var musicInfo: MusicInfo
    let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()

//    @Binding var isShowing: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView(artwork: musicInfo.artwork)

                VStack {
                    Button {
                        dismiss()
                    } label: {
                        DismissButton()
                    }

                    AlbumCoverView(artwork: musicInfo.artwork)
                        .padding(.all, 15.0)
                    TitleView(song: musicInfo.song, color: Color(musicInfo.artwork.averageColor!))
                    ArtistView(artist: musicInfo.artist, color: Color(musicInfo.artwork.averageColor!))
                    Spacer()

                    if let player = musicManager.player {
                        Slider(value: $value, in: 0 ... player.duration) { editing in
                            isEditing = editing
                            if !editing {
                                player.currentTime = value
                            }
                        }
                        .frame(width: 320.0)

                        MusicControlsView(shuffle: true, color: Color(musicInfo.artwork.averageColor!))
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
    MusicView(musicInfo: Library.library.first!)
        .environmentObject(MusicManager())
}

// MARK: - AlbumCoverView

struct AlbumCoverView: View {
    let artwork: UIImage
    var body: some View {
        Image(uiImage: artwork)
            .resizable()
            .frame(width: 300.0, height: 300.0)
            .cornerRadius(30.0)
            .shadow(color: Color(artwork.averageColor!), radius: 25)
    }
}

// MARK: - MusicControlsView

struct MusicControlsView: View {
    @EnvironmentObject private var musicManager: MusicManager
    let shuffle: Bool
    let color: Color

    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: "shuffle")
                .resizable()
                .frame(width: 35, height: 30)
                .foregroundColor(color)
                .disabled(shuffle)
            Image(systemName: "backward.end.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(color)
            Button {
                musicManager.playPauseToggle()
            } label: {
                Image(systemName: musicManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(color)
            }
            Image(systemName: "forward.end.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(color)
            Button {
                musicManager.toggleRepeatOne()
            } label: {
                Image(systemName: "repeat")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(color)
                    .disabled(!musicManager.isRepeatingOne)
            }
        }.padding(.vertical, 40)
    }
}

// MARK: - BackgroundView

struct BackgroundView: View {
    let artwork: UIImage
    var body: some View {
        Image(uiImage: artwork)
            .resizable()
            .edgesIgnoringSafeArea(.all)
//            .frame(width: 900, height: 900)
            .scaledToFill()
//            .aspectRatio(contentMode: .fill)
            .blur(radius: 10)
            .opacity(0.8)
    }
}

// MARK: - DismissButton

struct DismissButton: View {
    var body: some View {
        Image(systemName: "chevron.down")
            .resizable()
            .frame(width: 20, height: 10)
            .padding(.top, 30)
            .opacity(0.6)
    }
}

// MARK: - TitleView

struct TitleView: View {
    var song: String
    var color: Color

    var body: some View {
        Text(song)
            .fontWeight(.bold)
            .padding([.top, .leading, .trailing], 15.0)
            .dynamicTypeSize(.accessibility1)
            .foregroundColor(color)
    }
}

// MARK: - ArtistView

struct ArtistView: View {
    var artist: String
    var color: Color

    var body: some View {
        Text(artist)
            .opacity(0.6)
            .fontWeight(.semibold)
            .dynamicTypeSize(.xxLarge)
            .foregroundColor(color)
    }
}
