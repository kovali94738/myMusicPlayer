//
//  HomeView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct HomeView: View {
    var width: CGFloat
    var height: CGFloat
    
    @Binding var backgroundAnimation: Bool
    
    var musicVM = MusicVM()
    
    var body: some View {
        VStack {
            
            
            HStack() {
                
                Text("SoundHub")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "bell.badge")
                    .font(.custom("", fixedSize: 23))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.indigo, .primary)
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 15)
            .scaleEffect(backgroundAnimation ? 0.9 : 1)
            
            ScrollView {
                
                ScrollView(.horizontal) {
                    HStack(spacing: backgroundAnimation ? 0 : 20) {
                        ForEach(musicVM.artists, id: \.id) { item in
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.gray)
                                    .frame(width: 200, height: 140)

                                AsyncImage(url: item.URLImageL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 140)
                                } placeholder: {
                                    ProgressView()
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                                HStack {
                                    VStack {
                                        Spacer()
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(item.name)
                                                .foregroundColor(.white)
                                                .font(.custom("", size: 15))
                                                .fontWeight(.bold)
                                                .lineLimit(1)
                                            HStack {
                                                Text(item.id)
                                            }
                                            .font(.custom("", size: 10))
                                        }
                                        .padding(5)
                                        .background(.ultraThinMaterial.opacity(0.7))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    Spacer()
                                }
                                .frame(maxWidth: 200)
                            }
                            .onTapGesture {
                                print("Tap on song box")
                            }
                            .scaleEffect(backgroundAnimation ? 0.9 : 1)
                        }
                    }
                    .padding(.leading, 15)

                }
                .padding(.bottom, 10)

                
                VStack(spacing: 30) {
                    HStack {
                        Text("Tap what you feel")
                            .font(.headline)
                        Spacer()
                        Text("Play my rhythm")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    TapView()
                        .frame(height: height * 0.18 )
                }
                .padding(.horizontal, 15)
                .scaleEffect(backgroundAnimation ? 0.9 : 1)
                
                HStack {
                    Text("Favourity artists")
                        .font(.headline)
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .scaleEffect(backgroundAnimation ? 0.9 : 1)
                
                ScrollView(.horizontal) {
                    HStack(spacing: backgroundAnimation ? 0 : 20) {
                        ForEach(musicVM.artists, id: \.id) { item in
                            VStack(alignment: .leading) {
                                AsyncImage(url: item.URLImageL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 140, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .onTapGesture {
                                    print("Tap on favourity artist box")
                                }
                                Text(item.name)
                            }
                            .scaleEffect(backgroundAnimation ? 0.9 : 1)
                        }
                    }
                    .padding(.leading, 15)
                }
            }
            .scrollIndicators(.hidden)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(width: 600, height: 1000, backgroundAnimation: .constant(false))
    }
}
