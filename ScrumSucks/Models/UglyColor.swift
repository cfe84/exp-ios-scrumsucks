//
//  Theme.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-12.
//

import SwiftUI

enum UglyColor: String, CaseIterable, Identifiable, Codable {
    case brown
    case indigo
    case red
    case blue
    case orange
    case mint
    case pink
    case purple
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .mint, .orange, .teal, .yellow, .pink: return .black
        case .red, .indigo, .brown, .blue, .purple: return .white
        }
    }
    
    var mainColor: Color {
        switch self {
        case .brown: Color.brown
        case .indigo: Color.indigo
        case .red: Color.red
        case .blue: Color.blue
        case .orange: Color.orange
        case .mint: Color.mint
        case .pink: Color.pink
        case .purple: Color.purple
        case .teal: Color.teal
        case .yellow: Color.yellow
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
