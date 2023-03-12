//
//  AlbumInfoView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct AlbumInfoView: View {
    var album: Artist.Album
    let artist: Artist
    @State var isPlayer = false
    @StateObject var audioManager = PlayerManager.shared
    @State var currentTrackNumber = 1
    var body: some View {
        ZStack {
            BackgroundGradientView()
            VStack {
                GeometryReader { geo in
                    List(content: {
                        Section {
                            ForEach(album.tracks, id: \.id) { track in
                                Button {
                                    isPlayer.toggle()
                                    currentTrackNumber = track.trackNumber
                                } label: {
                                    HStack {
                                        AsyncImage(url: album.URLImageS) { Image in
                                            Image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 60)
                                        } placeholder: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .fill(.gray)
                                                ProgressView()
                                            }
                                                .frame(width: 60, height: 60)
                                        }
                                        
                                        Text("\(track.trackNumber). \(track.name)")
                                            .foregroundColor(.white)
                                    }
                                    .sheet(isPresented: $isPlayer, content: {
                                        PlayerView(album: album, track: track, artist: artist, currentTrackNumber: $currentTrackNumber, audioManager: audioManager)
                                    })
                                }
                            }
                        } header: {
                            Text(album.releaseDate, style: .date)
                        }
                    })
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: geo.size.height * 0.9)
                }
                
                Spacer()
                
            }
            .navigationTitle(album.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
