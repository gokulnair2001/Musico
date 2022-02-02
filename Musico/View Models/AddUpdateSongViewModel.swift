//
//  AddUpdateSongViewModel.swift
//  Musico
//
//  Created by Gokul Nair on 01/02/22.
//

import Foundation

final class AddUpdateSongViewModel: ObservableObject {
    
    @Published var songTitle: String = ""
    
    var songID: UUID?
    
    var isUpdating: Bool {
        songID != nil
    }
    
    var buttonTitle: String {
        songID != nil ? "Update Song" : "Add Song"
    }
    
    init() { }
    
    init(currentSong: Song) {
        self.songTitle = currentSong.title
        self.songID = currentSong.id
    }
    
    func addUpdateAction(completion: @escaping () -> Void) {
        Task {
            do {
                if isUpdating {
                   try await updateSong()
                }else {
                    try await addSong()
                }
            }catch {
                print("❌Error:\(error.localizedDescription)")
            }
            completion()
        }
    }
    
    func addSong() async throws {
        let urlString = Constants.baseURL + EndPoints.songs
        
        guard let url = URL(string:  urlString) else {
            throw HttpError.badURl
        }
        
        let song = Song(id: nil, title: songTitle)
        
        try await HttpClient.shared.sendData(to: url,
                                             object: song,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func updateSong() async throws {
        let urlString = Constants.baseURL + EndPoints.songs
        
        guard let url = URL(string:  urlString) else {
            throw HttpError.badURl
        }
        
        let updateSong = Song(id: songID, title: songTitle)
        
        try await HttpClient.shared.sendData(to: url,
                                             object: updateSong,
                                             httpMethod: HttpMethods.PUT.rawValue)
    }
    
    
}
