//
//  MusicSingleListView.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/11/23.
//

import SwiftUI

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

