//
//  PlayerManager.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//
import Foundation
import AVKit
import MediaPlayer

class PlayerManager: ObservableObject {
    static let shared = PlayerManager()
    @Published var player: AVAudioPlayer?
    @Published var isPlaying = true
    @Published var isLooping = false
    
    func startPlayer(track: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: track)
            player?.prepareToPlay()
        } catch {
            print("Fail to init player")
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay, .allowBluetooth])
                } catch {
                    print("Failed to set audio session category.")
                }

                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch {
                    print("Failed to activate audio session.")
                }
            } else {
                print("Failed to get permission to play audio in background.")
            }
        }
    }
    
    func playPause() {
        guard let player = player else {
            print("Instance of audio player is not found")
            return
        }
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func toggleLoop() {
        guard let player = player else { return }
        isLooping.toggle()
        player.numberOfLoops = isLooping ? -1 : 0
    }
    
    func setupNowPlayingInfo(title: String, artist: String, album: String, duration: Double) {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = album
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration

        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
}
