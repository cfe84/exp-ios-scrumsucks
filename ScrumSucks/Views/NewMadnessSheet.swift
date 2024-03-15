//
//  NewMadnessSheet.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-13.
//

import SwiftUI

struct NewMadnessSheet: View {
    @State private var newMadness = DailyMadness.emptyTorture
    @Binding var isShowingTheForm: Bool
    @Binding var existingMadnesses: [DailyMadness]
        
    var body: some View {
        NavigationStack {
            TortureEditView(torture: $newMadness)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Noooes") {
                            isShowingTheForm = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("YEAH") {
                            existingMadnesses.append(newMadness)
                            isShowingTheForm = false
                        }
                    }
                }
        }
    }
}

#Preview {
    @State var existingMadnesses = DailyMadness.sampleData
    return NewMadnessSheet(isShowingTheForm: .constant(true), existingMadnesses: $existingMadnesses)
}
