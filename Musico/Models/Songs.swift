//
//  Songs.swift
//  Musico
//
//  Created by Gokul Nair on 08/12/21.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID?
    let title: String
}
