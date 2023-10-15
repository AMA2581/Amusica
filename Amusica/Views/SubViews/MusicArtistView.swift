//
//  ArtistView.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/11/23.
//

import SwiftUI

struct MusicArtistView: View {
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
