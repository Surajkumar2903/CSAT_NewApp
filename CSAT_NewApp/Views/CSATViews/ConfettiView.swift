//
//  ConfettiView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

import SwiftUI

struct ConfettiPiece: View {
    enum ShapeType { case rectangle, circle, star }

    let color: Color
    let shape: ShapeType

    @State private var rotation = Double.random(in: 0...360)
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    @State private var opacity: Double = 1

    var body: some View {
        Group {
            switch shape {
            case .rectangle:
                Rectangle().fill(color).frame(width: 10, height: 6)
            case .circle:
                Circle().fill(color).frame(width: 8, height: 8)
            case .star:
                Image(systemName: "star.fill").foregroundColor(color)
            }
        }
        .rotationEffect(.degrees(rotation))
        .offset(x: xOffset, y: yOffset)
        .opacity(opacity)
        .onAppear {
            yOffset = UIScreen.main.bounds.height / 2

            withAnimation(.easeOut(duration: 1.8)) {
                xOffset = CGFloat.random(in: -200...200)
                yOffset = CGFloat.random(in: -450...(-300))
                rotation += 360
            }

            withAnimation(.easeOut(duration: 1.2).delay(0.8)) {
                opacity = 0
            }
        }
    }
}

struct ConfettiView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .pink]
    let shapes: [ConfettiPiece.ShapeType] = [.rectangle, .circle, .star]

    var body: some View {
        ZStack {
            ForEach(0..<40, id: \.self) { _ in
                ConfettiPiece(
                    color: colors.randomElement()!,
                    shape: shapes.randomElement()!
                )
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}
//