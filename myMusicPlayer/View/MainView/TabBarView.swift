//
//  TabBarView.swift
//  myMusicPlayer
//
//  Created by Григорий Ковалев on 12.03.2023.
//

import SwiftUI

struct TabBarView: View {

    @Binding var currentTag: Int
    @Binding var backgroundAnimation: Bool
    
    let text = ["Home", "Explore", "","", "Library", "Settings"]
    let activeSF = ["music.note.house.fill", "magnifyingglass", "","", "bookmark.fill", "gearshape.fill"]
    let passiveSF = ["music.note.house", "magnifyingglass", "","", "bookmark", "gearshape"]
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            
            HStack {
                ForEach(0..<6) { item in
                    Spacer()
                    Button {
                        if backgroundAnimation != true {
                            currentTag = item
                        }
                        print(currentTag)
                    } label: {
                        VStack {
                            Image(systemName: currentTag == item ? activeSF[item] : passiveSF[item])
                                .font(.custom("", fixedSize: 25))
                                .padding(.bottom, -5)
                            Text(text[item])
                                .font(.custom("", fixedSize: 15))
                        }
                        .foregroundColor(currentTag == item ? .white : Color(red: 0.37, green: 0.17, blue: 0.17))
                        
                    }
                    Spacer()
                }
            }
            .blur(radius: backgroundAnimation ? 5 : 0)
            
            MainButtonView(backgroundAnimation: $backgroundAnimation, width: width, height: height)
            
        }
    }
}
