//
//  AlbumCoverView.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/11/23.
//

import SwiftUI

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
