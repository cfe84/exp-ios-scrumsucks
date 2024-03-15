//
//  DailyMadness.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-12.
//

import Foundation

struct DailyMadness: Identifiable, Codable {
    let id: UUID
    var excuse: String
    var victims: [Victim]
    var suppliceDurationInMinutes: Int
    var uglyColor: UglyColor
    var history: [History] = []
    
    init(id: UUID = UUID(), excuse: String, victims: [String], suppliceDurationInMinutes: Int, theme: UglyColor) {
        self.id = id
        self.excuse = excuse
        self.victims = victims.map { victim in Victim(denomination: victim) }
        self.suppliceDurationInMinutes = suppliceDurationInMinutes
        self.uglyColor = theme
    }
}

extension DailyMadness {
    struct Victim: Identifiable, Codable {
        var id: UUID = UUID()
        let denomination: String
    }
    
    var durationInMinutesAsDouble: Double {
        get {
            Double(suppliceDurationInMinutes)
        }
        set {
            suppliceDurationInMinutes = Int(newValue)
        }
    }
    
    static var emptyTorture: DailyMadness {
        DailyMadness(excuse: "", victims: [], suppliceDurationInMinutes: 5, theme: .mint)
    }
}

extension DailyMadness {
    static let sampleData: [DailyMadness] = [
        DailyMadness(excuse: "Prisoners", victims: ["Bernardo", "Richie", "Carlotina"], suppliceDurationInMinutes: 10, theme: .mint),
        DailyMadness(excuse: "Torturers", victims: ["Josephine", "Stephanie", "Chad", "Jet"], suppliceDurationInMinutes: 15, theme: .orange),
        DailyMadness(excuse: "Predators", victims: ["Glorg", "Flex", "Blurp", "Pikachu"], suppliceDurationInMinutes: 3, theme: .purple)
    ]
}

