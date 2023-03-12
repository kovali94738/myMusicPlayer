//
//  LibraryView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var musicVm: MusicVM
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundGradientView()
                List(musicVm.artists, id: \.id) { artist in
                    NavigationLink {
                        ArtistInfoView(atrist: artist)
                    } label: {
                        HStack {
                            AsyncImage(url: artist.URLImageS) { Image in
                                Image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .frame(width: 60, height: 60)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(artist.name)
                                    .font(.headline)
                                Text(artist.genres.joined(separator: ", "))
                                    .foregroundColor(.secondary)
                            }
                                
                            Spacer()

                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Испонители")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
        
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(musicVm: MusicVM())
    }
}
