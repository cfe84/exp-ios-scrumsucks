//
//  MadnessStore.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-14.
//

import Foundation

@MainActor
class MadnessStore: ObservableObject {
    @Published var madnesses: [DailyMadness] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("madness.data")
    }
    
    func load() async throws {
//        let task = Task<[DailyMadness], Error> {
            let fileUrl = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileUrl) else {
                self.madnesses = DailyMadness.sampleData
                return
            }
            let madnesses = try JSONDecoder().decode([DailyMadness].self, from: data)
        self.madnesses = madnesses
//        }
//        let madnesses = try await task.value
    }
    
    func save() async throws {
        let fileUrl = try Self.fileURL()
        guard let data = try? JSONEncoder().encode(self.madnesses) else {
            return
        }
        try data.write(to: fileUrl)
    }
}
