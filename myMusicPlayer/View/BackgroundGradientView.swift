//
//  BackgroundGradientView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct BackgroundGradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(stops:  [
            .init(color: Color(red: 0.37, green: 0.17, blue: 0.17), location: 0),
            .init(color: Color(red: 0.06, green: 0.06, blue: 0.06), location: 0.95),
            ]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct BackgroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView()
    }
}
