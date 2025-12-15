//
//  StarRatingView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int

    @State private var animatedFillUpto: Int = 0
    @State private var hintActive = false

    private let starSize: CGFloat = 40

    var body: some View {
        HStack(spacing: 16) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: starImage(for: star))
                    .resizable()
                    .frame(width: starSize, height: starSize)
                    .foregroundColor(starColor(for: star))
                    .onTapGesture {
                        rating = star
                        stopHint()
                    }
            }
        }
        .onAppear {
            scheduleHint()
        }
        .onChange(of: rating) { newValue in
            if newValue > 0 {
                stopHint()
            }
        }
        .animation(.easeInOut(duration: 0.35), value: animatedFillUpto)
    }

    // MARK: - Helpers

    private func starImage(for star: Int) -> String {
        if rating > 0 {
            return star <= rating ? "star.fill" : "star"
        } else {
            return star <= animatedFillUpto ? "star.fill" : "star"
        }
    }

    private func starColor(for star: Int) -> Color {
        if rating > 0 {
            return star <= rating ? .red : .gray.opacity(0.35)
        } else {
            return star <= animatedFillUpto ? .red : .gray.opacity(0.35)
        }
    }

    // MARK: - Hint Animation Logic

    private func scheduleHint() {
        guard rating == 0 else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            guard rating == 0 else { return }
            hintActive = true
            runFillAnimation()
        }
    }

    private func runFillAnimation() {
        guard hintActive else { return }

        animatedFillUpto = 0

        for i in 1...5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5) {
                guard hintActive, rating == 0 else { return }
                animatedFillUpto = i
            }
        }

        // Pause, then repeat
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) {
            guard hintActive, rating == 0 else { return }
            runFillAnimation()
        }
    }

    private func stopHint() {
        hintActive = false
        animatedFillUpto = 0
    }
}

