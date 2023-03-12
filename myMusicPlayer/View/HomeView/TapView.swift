//
//  TapView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct TapView: View {
    
    @State private var sizeCircle = 0.5
    @State private var sizeStroke = 0.5
    @State private var opacity = 0.1
    
    @State private var sizeCircle1 = 0.5
    @State private var sizeStroke1 = 0.5
    @State private var opacity1 = 0.1
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.ultraThinMaterial)
                .overlay {
                    Circle()
                        .scaleEffect(sizeCircle)
                        .opacity(opacity)
                        .overlay {
                            Circle()
                                .stroke()
                                .scaleEffect(sizeStroke)
                                .opacity(opacity)
                        }
                }
                .overlay {
                    Circle()
                        .scaleEffect(sizeCircle1)
                        .opacity(opacity1)
                        .overlay {
                            Circle()
                                .stroke()
                                .scaleEffect(sizeStroke1)
                                .opacity(opacity1)
                        }
                }
                .clipped()
            
            VStack(spacing: 5) {
                HStack(alignment: .firstTextBaseline) {
                    Text("42")
                        .font(.largeTitle)
                    Text("bpm")
                }
                HStack {
                    Text("Lo-fi, slostep")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear{
            withAnimation(.timingCurve(0.2, 0.91, 0.16, 0.97, duration: 2.5).repeatForever(autoreverses: false)) {
                sizeCircle = 1.5
                opacity = 0
                sizeStroke = 2
            }
            withAnimation(.timingCurve(0.2, 0.91, 0.16, 0.97, duration: 2.5).repeatForever(autoreverses: false).delay(0.3)) {
                sizeCircle1 = 1.5
                opacity1 = 0
                sizeStroke1 = 2
            }
        }
    }
}

struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        TapView()
    }
}
