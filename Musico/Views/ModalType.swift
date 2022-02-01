//
//  ModalType.swift
//  Musico
//
//  Created by Gokul Nair on 01/02/22.
//

import Foundation

enum ModalType: Identifiable {
    
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    
    case add
    case update(Song)
}
