//
//  JSONDecoders.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import Foundation
struct ArtistData: Codable {
    let artists: Artist?
    
    struct Artist: Codable {
        let href: String?
        let items: [Item]?
        let limit: Int?
        let next: String?
        let offset: Int?
        let total: Int?
        
        struct Item: Codable {
            let externalUrls: ExternalUrls?
            let followers: Followers?
            let genres: [String]?
            let href: String?
            let id: String?
            let images: [Image]?
            let name: String?
            let releaseDate: Date?
            let popularity: Int?
            let type, uri: String?
            
            struct ExternalUrls: Codable {
                let spotify: String?
            }
            
            struct Followers: Codable {
                let total: Int?
            }
            struct Image: Codable {
                let height: Int?
                let url: String?
                let width: Int?
            }
        }
    }
}

struct AlbumData: Codable {
    let albums: Albums?
    
    struct Albums: Codable {
        let href: String?
        let items: [Item]?
        let limit: Int?
        let next: String?
        let offset: Int?
        let total: Int?
        
        struct Item: Codable {
            let albumType: String?
            let artists: [Artist]?
            let externalUrls: ExternalUrls?
            let href: String?
            let id: String?
            let images: [Image]?
            let name, releaseDatePrecision: String?
            let releaseDate: Date?
            let totalTracks: Int?
            let type, uri: String?
            
            struct Artist: Codable {
                let externalUrls: ExternalUrls?
                let href: String?
                let id, name, type, uri: String?
            }
            
            struct ExternalUrls: Codable {
                let spotify: String?
            }
            
            struct Image: Codable {
                let height: Int?
                let url: String?
                let width: Int?
            }
        }
    }
}

struct TrackData: Codable {
    let href: String?
    let items: [Item]
    let limit: Int?
    let offset: Int?
    let total: Int?
    
    struct Item: Codable {
        let artists: [Artist]?
        let discNumber, durationMS: Int?
        let explicit: Bool?
        let externalUrls: ExternalUrls?
        let href: String?
        let id: String?
        let isLocal, isPlayable: Bool?
        let name: String?
        let previewURL: String?
        let trackNumber: Int?
        let type: String?
        let uri: String?

        struct Artist: Codable {
            let externalUrls: ExternalUrls?
            let href: String?
            let id: String?
            let name: String?
            let type: String?
            let uri: String?
        }
        
        struct ExternalUrls: Codable {
            let spotify: String?
        }
        
    }
}
