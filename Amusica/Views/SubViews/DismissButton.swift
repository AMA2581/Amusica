//
//  DismissButton.swift
//  Amusica
//
//  Created by Amir Mahdi Abravesh on 10/11/23.
//

import SwiftUI

struct DismissButton: View {
    var body: some View {
        Image(systemName: "chevron.down")
            .resizable()
            .frame(width: 20, height: 10)
            .padding(.top, 30)
            .opacity(0.6)
    }
}
