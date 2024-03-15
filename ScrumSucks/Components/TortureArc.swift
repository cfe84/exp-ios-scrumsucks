//
//  TortureArc.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-14.
//

import SwiftUI

struct TortureArc: Shape {
    let currentTorturerIndex: Int
    let victimCount: Int
    let diameter: Double
    
    private var degreesPerSpeaker: Double {
        get {
            return 360.0 / Double(victimCount)
        }
    }
    
    private var currentAngle: Angle {
        get {
            return Angle(degrees: Double(currentTorturerIndex) * degreesPerSpeaker)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let radius = (min(rect.size.height, rect.size.width) - CGFloat(diameter)) / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: Angle(), endAngle: currentAngle, clockwise: false)
        }
    }
   
}
