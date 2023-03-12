//
//  PlayerView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct PlayerView: View {
    let album: Artist.Album
    let track: Artist.Album.Track
    let artist: Artist
    @Binding var currentTrackNumber: Int
    @ObservedObject var audioManager: PlayerManager
    @State private var isEnableLoop = false
    @State private var isInfinityLoop = false
    
    var color: Color = .white
    var normalFillColor: Color { color.opacity(0.5) }
    var emptyColor: Color { color.opacity(0.3) }
    
    @State var value: TimeInterval = 0
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var currentTrack: Artist.Album.Track {
        let track = album.tracks.first(where: { $0.trackNumber == currentTrackNumber })!
        return track
    }
    
    enum Loop {
        case zeroLoop, oneLoop, infinityLoop
    }
    @State private var loop = Loop.zeroLoop
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            VStack {
                AsyncImage(url: album.URLImageL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: 300)
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.gray)
                        ProgressView()
                    }
                        .frame(width: 300, height: 300)
                }
                Text(currentTrack.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                VStack {
                    if let player = audioManager.player {
                        MusicProgressSlider(value: $value, inRange: 0...player.duration, activeFillColor: color, fillColor: normalFillColor, emptyColor: emptyColor, height: 40) { started in
                            if !started {
                                player.currentTime = value
                            }
                        }
                        
                        HStack {
                            PlaybackButton(systemName: "shuffle") {
                                
                            }
                            Spacer()
                            PlaybackButton(systemName: "backward.fill") {
                                currentTrackNumber -= 1
                                if currentTrackNumber < 1 {
                                    currentTrackNumber = album.tracks.count
                                }
                                audioManager.startPlayer(track: currentTrack.bundlePath)
                                audioManager.playPause()
                            }
                            Spacer()
                            PlaybackButton(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill", fontSize: 50) {
                                audioManager.playPause()
                                audioManager.setupNowPlayingInfo(title: currentTrack.name, artist: artist.name, album: album.name, duration: player.duration)
                            }
                            Spacer()
                            PlaybackButton(systemName: "forward.fill") {
                                currentTrackNumber += 1
                                if currentTrackNumber > album.tracks.count {
                                    currentTrackNumber = 1
                                }
                                audioManager.startPlayer(track: currentTrack.bundlePath)
                                audioManager.playPause()
                            }
                            Spacer()
                            switch loop {
                            case .zeroLoop:
                                
                                PlaybackButton(systemName: "repeat", color: .gray) {
                                    loop = .oneLoop
                                    audioManager.toggleLoop()
                                }
                            case .oneLoop:
                                PlaybackButton(systemName: "repeat.1", color: .white) {
                                    loop = .infinityLoop
                                    audioManager.toggleLoop()
                                    isInfinityLoop.toggle()
                                }
                            case .infinityLoop:
                                PlaybackButton(systemName: "repeat", color: .white) {
                                    loop = .zeroLoop
                                    isInfinityLoop.toggle()
                                }
                            }
                        }
                    }
                }
                .padding(20)
                .onAppear(perform: {
                    audioManager.startPlayer(track: currentTrack.bundlePath)
                })
                .onReceive(timer) { _ in
                    guard let player = audioManager.player else { return }
                    value = Double(player.currentTime)
                    
                    if isInfinityLoop {
                    let errorMargin = 0.1 // Погрешность в секундах, на которую время воспроизведения может не точно совпадать с общим временем трека
                    if (player.duration - player.currentTime) <= errorMargin {
                        currentTrackNumber += 1
                        if currentTrackNumber > album.tracks.count {
                            currentTrackNumber = 1
                        }
                        audioManager.startPlayer(track: currentTrack.bundlePath)
                        audioManager.playPause()
                    }
                }
                }
            }
            .padding(.bottom, 30)
        }
    }
}
