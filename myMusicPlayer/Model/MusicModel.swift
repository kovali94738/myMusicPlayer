//
//  MusicModel.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import Foundation

struct Artist {
    let id: String
    let name: String
    let URLImageL: URL
    let URLImageM: URL
    let URLImageS: URL
    let genres: [String]
    var albums: [Album]
    var singles: [Single]
    
    struct Album {
        let id: String
        let name: String
        let URLImageL: URL
        let URLImageM: URL
        let URLImageS: URL
        let releaseDate: Date
        let totalTracks: Int
        var isLiked: Bool = false
        let tracks: [Track]
        
        struct Track {
            let id: String
            let name: String
            let trackNumber: Int
            let bundlePath: URL
            var isLiked: Bool = false
        }
    }
    
    struct Single {
        let id: String
        let name: String
        let releaseDate: Date
        let URLImageL: URL
        let URLImageM: URL
        let URLImageS: URL
        let bundlePath: String
        var isLiked: Bool = false
    }
}
