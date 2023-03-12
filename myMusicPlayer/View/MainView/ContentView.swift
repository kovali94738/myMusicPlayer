//
//  ContentView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct ContentView: View {
        
    @State private var backgroundAnimation = false
    @State private var selectedTag = 0
    
    @StateObject var vm = MusicVM()
        
    var body: some View {
        GeometryReader { geo in
            ZStack {
                BackgroundGradientView()
                
                VStack {
//                    if selectedTag == 0 {
//                        HomeView(width: geo.size.width, height: geo.size.height, backgroundAnimation: $backgroundAnimation)
//                    }
                    switch selectedTag {
                    case 0:
                        HomeView(width: geo.size.width, height: geo.size.height, backgroundAnimation: $backgroundAnimation)
                    case 1:
                        LibraryView(musicVm: vm)
                    case 4:
                        Text("4")
                    case 5:
                        Text("5")
                    default:
                        Text("error")
                    }
                }
                .blur(radius: backgroundAnimation ? 5 : 0)
                
                if backgroundAnimation {
                    Color.white.opacity(0)
                }
                
                if backgroundAnimation {
                    Circle()
                        .fill(.black)
                        .opacity(0.9)
                        .offset(y: geo.size.height * 0.3)
                        .frame(height: geo.size.height * 0.99)
                        .clipped()
                        .blur(radius: 20)
                }
                
                VStack {
                    Spacer()
                    TabBarView(currentTag: $selectedTag, backgroundAnimation: $backgroundAnimation, width: geo.size.width, height: geo.size.height)
                        .background(Color(red: 16/255, green: 16/255, blue: 16/255))
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
