//
//  UglyColorPickerView.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-13.
//

import SwiftUI

struct UglyColorPickerView: View {
    @Binding var uglyColor: UglyColor
    
    var body: some View {
        Picker("Ugly color", selection: $uglyColor) {
            ForEach(UglyColor.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

#Preview {
    @State var color: UglyColor = .blue
    return UglyColorPickerView(uglyColor: $color)
}
