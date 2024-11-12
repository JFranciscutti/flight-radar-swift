//
//  SideMenuOptionModel.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 11/11/2024.
//

import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    case home
    case favorites
    case help
    
    var title: String {
        switch self {
        case .home: return "Inicio"
        case .favorites: return "Favoritos"
        case .help: return "Ayuda"
        }
    }
    
    var image: String {
        switch self {
        case .home: return "house"
        case .favorites: return "star.fill"
        case .help: return "questionmark.circle"
        }
    }
}

extension SideMenuOptionModel: Identifiable {
    var id: Int { return self.rawValue}
}
