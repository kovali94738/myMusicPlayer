//
//  MainButtonView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct MainButtonView: View {
    
    @State private var iconX1 = 0.0
    @State private var iconY1 = 0.0
    
    @State private var iconX2 = 0.0
    @State private var iconY2 = 0.0
    
    @State private var iconX3 = 0.0
    @State private var iconY3 = 0.0
    
    @State private var iconX4 = 0.0
    @State private var iconY4 = 0.0
    
    @Binding var backgroundAnimation: Bool
    
    let text = ["Home", "Explore", "","", "Library", "Settings"]
    let activeSF = ["music.note.house.fill", "magnifyingglass", "","", "bookmark.fill", "gearshape.fill"]
    let passiveSF = ["music.note.house", "magnifyingglass", "","", "bookmark", "gearshape"]
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            
            //items
            ZStack {
             
                VStack {
                    Image(systemName: "person")
                        .font(.custom("", fixedSize: 40))
                    Text("Artist")
                }
                .offset(x: iconX1, y: backgroundAnimation ? iconY1 : height * -0.053)
                
                VStack {
                    Image(systemName: "note")
                        .font(.custom("", fixedSize: 40))
                    Text("Album")
                }
                .offset(x: iconX2, y: backgroundAnimation ? iconY2 : height * -0.053)
                
                VStack {
                    Image(systemName: "heart")
                        .font(.custom("", fixedSize: 40))
                    Text("Liked")
                }
                .offset(x: iconX3, y: backgroundAnimation ? iconY3 : height * -0.053)
                
                VStack {
                    Image(systemName: "clock")
                        .font(.custom("", fixedSize: 40))
                    Text("Recent")
                }
                .offset(x: iconX4, y: backgroundAnimation ? iconY4 : height * -0.053)
                
            }
            .opacity(backgroundAnimation ? 1 : 0)
            
            //первая кнопка
            ZStack {
                Circle()
                    .fill(Color(red: 168/255, green: 59/255, blue: 83/255))
                    .frame(width: width * 0.18)//
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.3)) {
                            backgroundAnimation.toggle()
                            
                            iconX1 = width * -0.32
                            iconY1 = height * -0.2
                            
                            iconX2 = width * -0.12
                            iconY2 = height * -0.23
                            
                            iconX3 = width * 0.12
                            iconY3 = height * -0.23
                            
                            iconX4 = width * 0.32
                            iconY4 = height * -0.2
                        }
                    }
                
                Image(systemName: "wave.3.left")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .offset(y: height * -0.05)
            .opacity(backgroundAnimation ? 0 : 1)
            
            
            //вторая кнопка
            ZStack {
                
                //вторая кнопка
                Group {
                    Circle()
                        .fill(.gray)
                        .frame(width: width * 0.18)
                        .overlay(content: {
                            Image(systemName: "arrow.down.forward.and.arrow.up.backward")
                                .font(.custom("", fixedSize: 23))
                                .fontWeight(.medium)
                                .scaleEffect(x: -1, y: 1)
                        })
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.3)) {
                                backgroundAnimation.toggle()
                                
                                iconX1 = 0
                                iconX2 = 0
                                iconX3 = 0
                                iconX4 = 0
                            }
                        }
                        .offset(y: height * -0.05)
                }
                
                .opacity(backgroundAnimation ? 1 : 0)
            }

        }
        
    }
}
