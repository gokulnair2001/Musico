//
//  HttpClient.swift
//  Musico
//
//  Created by Gokul Nair on 08/12/21.
//

import Foundation
import SwiftUI

enum HttpError: Error{
    case badURl, badResponse, errorDecodingData, invalidURL
}

class HttpClient {
    
    private init() {}
    
    static let shared = HttpClient()
    
    func fetch<T: Codable>(url: URL) async throws -> [T] {

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else {
            throw HttpError.errorDecodingData
        }
        
        return object
    }
}
