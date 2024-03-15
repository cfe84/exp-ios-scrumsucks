//
//  ScrumSucksApp.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-12.
//

import SwiftUI

@main
struct ScrumSucksApp: App {
    @StateObject private var store = MadnessStore()
    
    var body: some Scene {
        WindowGroup {
            SuppliceListView(supplices: $store.madnesses) {
                Task {
                    do {
                        try await store.save()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
