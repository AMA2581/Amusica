//
//  MusicControlsView.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/11/23.
//

import SwiftUI

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
            Button {
                musicManager.playPrevious()
            } label: {
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(color)
            }
            Button {
                musicManager.playPauseToggle()
            } label: {
                Image(systemName: musicManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(color)
            }
            Button {
                musicManager.playNext()
            } label: {
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(color)
            }
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
