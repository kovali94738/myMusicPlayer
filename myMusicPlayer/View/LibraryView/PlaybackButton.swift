//
//  PlaybackButton.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct PlaybackButton: View {
    var systemName: String = "play"
    var fontSize: CGFloat = 24
    var color: Color = .white
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.system(size: fontSize))
                .foregroundColor(color)
        }

    }
}

struct PlaybackButton_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackButton( action: {})
    }
}
