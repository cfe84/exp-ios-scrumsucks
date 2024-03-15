//
//  Supplices.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-12.
//

import SwiftUI

struct SuppliceListView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Binding var supplices: [DailyMadness]
    @State private var isCreatingAdditionalMadness = false
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            List ($supplices){ $supplice in
                NavigationLink(destination: TortureDetailsView(nonsense: $supplice)) {
                    CardView(ceremony: supplice)
                }
                .listRowBackground(supplice.uglyColor.mainColor)
            }
            .navigationTitle("All the torture")
            .toolbar {
                Button(action: {
                    isCreatingAdditionalMadness = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add some pain")
            }
        }
        .sheet(isPresented: $isCreatingAdditionalMadness)  {
            NewMadnessSheet(isShowingTheForm: $isCreatingAdditionalMadness, existingMadnesses: $supplices)
        }
        .onChange(of: scenePhase, initial: false) { fromPhase, toPhase in
            if toPhase == .inactive {
                saveAction()
            }
        }
    }
}

#Preview {
    @State var supplices = DailyMadness.sampleData
    let view = SuppliceListView(supplices: $supplices, saveAction: {})
    return view
}
