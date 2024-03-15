//
//  History.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-13.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var victims: [DailyMadness.Victim]
    
    init(id: UUID = UUID(), date: Date = Date(), victims: [DailyMadness.Victim]) {
        self.id = id
        self.date = date
        self.victims = victims
    }
}
