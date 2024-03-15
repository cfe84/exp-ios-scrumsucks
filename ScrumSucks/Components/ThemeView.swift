//
//  ThemeView.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-13.
//

import SwiftUI

struct ThemeView: View {
    let theme: UglyColor
    
    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .foregroundColor(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    return ThemeView(theme: .blue)
}
