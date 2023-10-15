//
//  TitleView.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/11/23.
//

import SwiftUI

struct MusicTitleView: View {
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
