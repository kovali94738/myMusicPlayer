//
//  MusicViewModel.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

class MusicVM: ObservableObject {
    @Published var artists = [Artist]()
        
    init() {
        self.fetchData()
        
    }
    
    func fetchData() {
        
        struct ArtistProperties {
            let albums: Array<String>
            let singles: Array<String>
        }
        
        let totalArtists = ["Mac Miller": ArtistProperties(albums: ["Swimming"], singles: Array<String>()), "Anderson .Paak": ArtistProperties(albums: ["Oxnard"], singles: Array<String>())]
        
        for artist in totalArtists {
            
            let artistData = Bundle.main.decode(ArtistData.self, from: "\(artist.key).json")
            
            let id = artistData.artists?.items?.first?.id ?? ""
            let name = artistData.artists?.items?.first?.name ?? ""
            let URLImageL = URL(string: artistData.artists?.items?.first?.images?[0].url ?? "")!
            let URLImageM = URL(string: artistData.artists?.items?.first?.images?[1].url ?? "")!
            let URLImageS = URL(string: artistData.artists?.items?.first?.images?[2].url ?? "")!
            let genres = artistData.artists?.items?.first?.genres ?? [String]()
            var albums = [Artist.Album]()
            
            for album in artist.value.albums {
                let albumData = Bundle.main.decode(AlbumData.self, from: "\(artist.key).\(album).json")
                
                let albumId = albumData.albums?.items?.first?.id ?? ""
                let albumName = albumData.albums?.items?.first?.name ?? ""
                let albumURLImageL = URL(string: albumData.albums?.items?.first?.images?[0].url ?? "")!
                let albumURLImageM = URL(string: albumData.albums?.items?.first?.images?[1].url ?? "")!
                let albumURLImageS = URL(string: albumData.albums?.items?.first?.images?[2].url ?? "")!
                let albumReleaseDate = albumData.albums?.items?.first?.releaseDate ?? Date.now
                let albumTotalTracks = albumData.albums?.items?.first?.totalTracks ?? 0
                
                var albumTracks = [Artist.Album.Track]()
                
                let trackData = Bundle.main.decode(TrackData.self, from: "tracks.\(artist.key).\(album).json")
                for track in trackData.items {
                    let trackId = track.id ?? ""
                    let trackName = track.name ?? ""
                    let trackNumber = track.trackNumber ?? 0
                    //print("\(name) - \(trackName)")
                    let trackBundlePath = Bundle.main.url(forResource: "\(name) - \(trackName)", withExtension: "mp3")!
                    
                    let reternedTrack = Artist.Album.Track(id: trackId, name: trackName, trackNumber: trackNumber, bundlePath: trackBundlePath)
                    albumTracks.append(reternedTrack)
                }
                
                let returnedAlbum = Artist.Album(id: albumId, name: albumName, URLImageL: albumURLImageL, URLImageM: albumURLImageM, URLImageS: albumURLImageS, releaseDate: albumReleaseDate, totalTracks: albumTotalTracks, tracks: albumTracks)
                albums.append(returnedAlbum)
            }
            
            let reternedArtist = Artist(id: id, name: name, URLImageL: URLImageL, URLImageM: URLImageM, URLImageS: URLImageS, genres: genres, albums: albums, singles: [Artist.Single]())
            artists.append(reternedArtist)
        }
    }
}
