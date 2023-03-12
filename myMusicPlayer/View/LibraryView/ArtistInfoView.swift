//
//  ArtistInfoView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct ArtistInfoView: View {
    var atrist: Artist
    var body: some View {
        ZStack {
            BackgroundGradientView()
            List(content: {
                Section(atrist.albums.count == 1 ? "Album" : "Albums") {
                    ForEach(atrist.albums, id: \.id) { album in
                        NavigationLink {
                            AlbumInfoView(album: album, artist: atrist)
                        } label: {
                            HStack {
                                AsyncImage(url: album.URLImageS) { Image in
                                    Image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60)
                                } placeholder: {
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 60, height: 60)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(album.name)
                                        .font(.headline)
                                    Text(album.releaseDate, style: .date)
                                        .foregroundColor(.secondary)
                                }
                                
                            }
                        }
                        
                    }
                }
            })
            .scrollContentBackground(.hidden)
            .navigationTitle(atrist.name)
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}
