//
//  SongListViewModel.swift
//  Musico
//
//  Created by Gokul Nair on 08/12/21.
//

import SwiftUI

class SongListViewModel: ObservableObject {
    
    @Published var songs = [Song]()
    
    func fetchSongs() async throws {
        let urlString = Constants.baseURL + EndPoints.songs
        
        guard let url = URL(string:  urlString) else {
            throw HttpError.badURl
        }
        
        let songResponse:[Song] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.songs = songResponse
        }
    }
    
    func delete(at offset: IndexSet) {
        offset.forEach { i in
            guard let songID = songs[i].id else {
                return
            }
            
            guard let url = URL(string: Constants.baseURL + EndPoints.songs + "/\(songID)") else {
                return
            }
            
            Task {
                do {
                    try await HttpClient.shared.delete(at: songID, url: url)
                }catch {
                    print("❌Error: \(error.localizedDescription)")
                }
            }
        }
        songs.remove(atOffsets: offset)
    }
}

