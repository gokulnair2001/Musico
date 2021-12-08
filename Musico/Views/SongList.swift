//
//  ContentView.swift
//  Musico
//
//  Created by Gokul Nair on 08/12/21.
//

import SwiftUI

struct SongList: View {
    
    @StateObject var viewModel = SongListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.songs, id: \.id) {
                    song in
                    Button{
                        print("selected")
                    }label: {
                        Text(song.title)
                            .font(.title3)
                            .foregroundColor(Color(.label))
                    }
                }
            }
            .navigationBarTitle("🎵 Songs")
        }.onAppear {
            Task {
                do {
                    try await viewModel.fetchSongs()
                }
                catch {
                    print("error ❌")
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}
