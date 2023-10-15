//
//  MusicBackgroundView.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/11/23.
//

import SwiftUI

struct MusicBackgroundView: View {
    let artwork: UIImage
    var body: some View {
        Image(uiImage: artwork)
            .resizable()
            .edgesIgnoringSafeArea(.all)
            .scaledToFill()
            .blur(radius: 10)
            .opacity(0.8)
    }
}
