//
//  ContentView.swift
//  Musico
//
//  Created by Gokul Nair on 08/12/21.
//

import SwiftUI

struct SongList: View {
    
    @StateObject var viewModel = SongListViewModel()
    
    @State var modal: ModalType? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.songs, id: \.id) {
                    song in
                    Button{
                        print("selected")
                    }label: {
                        Text(song.title)
                            .font(.body)
                            .foregroundColor(Color(.label))
                    }
                }
            }
            .navigationBarTitle("🎵 Songs")
            
            .toolbar {
                Button{
                    modal = .add
                }label: {
                    Image(systemName: "plus")
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.red)
                }
            }
        }
        .sheet(item: $modal, onDismiss: {
            Task {
                do {
                    try await viewModel.fetchSongs()
                }catch {
                    print("❌Error: \(error.localizedDescription)")
                }
            }
        }){ modal in
            switch modal {
            case .add:
                AddUpdateSongs(viewModel: AddUpdateSongViewModel())
            case .update(let song):
                AddUpdateSongs(viewModel: AddUpdateSongViewModel(currentSong: song))
            }
        }
        .onAppear {
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
