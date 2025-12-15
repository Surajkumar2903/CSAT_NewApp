//
//  CSATViewModel.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

//
//  CSATViewModel.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

import SwiftUI
import Combine

final class CSATViewModel: ObservableObject {

    // MARK: - Visibility & UI State

    @Published var isVisible: Bool = false

    @Published var state: State = .collapsed

    private var thankYouTask: DispatchWorkItem?
    private var autoThankYouTask: DispatchWorkItem?

    // MARK: - User Input

    @Published var selectedQuickOption: String? = nil

    @Published var Comment: String = ""

    @Published var showConfetti: Bool = false

    // MARK: - CSAT State Enum

    enum State {
        case collapsed
        case expanded
        case thankYou
    }

    // MARK: - Rating Handling

    @Published var rating: Int = 0 {
        didSet {
            guard rating > 0 else { return }

            // Expand feedback section when a rating is selected
            withAnimation {
                state = .expanded
            }

            // Auto-submit flow for positive feedback (4–5 stars)
            if rating > 3 {
                logFeedback(source: "Auto (Rating > 3)")

                // Cancel any previous auto transitions
                autoThankYouTask?.cancel()

                // Show confetti immediately
                showConfetti = true

                let task = DispatchWorkItem { [weak self] in
                    guard let self else { return }

                    // Transition to Thank You screen
                    withAnimation(.easeInOut(duration: 0.45)) {
                        self.state = .thankYou
                    }

                    // Stop confetti after Thank You is stable
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                        self.showConfetti = false
                    }
                }

                autoThankYouTask = task

                // Small intentional delay to avoid animation race
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
            }
        }
    }

    // MARK: - Thank You Scheduling

    private func scheduleThankYou() {
        thankYouTask?.cancel()

        let task = DispatchWorkItem { [weak self] in
            withAnimation(.smooth(duration: 0.35)) {
                self?.state = .thankYou
            }
        }

        thankYouTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: task)
    }

    // MARK: - Quick Feedback Options
    
    func quickOptions(for rating: Int) -> [String] {
        switch rating {

        case 1:
            return [
                "Could not complete my task",
                "Very frustrating experience"
            ]

        case 2:
            return [
                "Features felt limited",
                "Too many steps to complete a task"
            ]

        case 3:
            return [
                "Average experience",
                "Some features worked well"
            ]

        case 4:
            return [
                "Good experience",
                "Worked as expected"
            ]

        case 5:
            return [
                "Excellent experience",
                "Loved using the app"
            ]

        default:
            return []
        }
    }

    // MARK: - Submit Actions

    func submit() {
        logFeedback(source: "Submit Button")

        // Transition immediately to Thank You
        withAnimation(.smooth(duration: 0.35)) {
            state = .thankYou
        }

        // Play confetti animation
        showConfetti = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            self.showConfetti = false
        }
    }

    // MARK: - Dismiss / Reset

    func dismiss() {
        thankYouTask?.cancel()
        state = .collapsed
    }

    func closeCompletely() {
        thankYouTask?.cancel()

        rating = 0
        selectedQuickOption = nil
        Comment = ""
        state = .collapsed
        isVisible = false
    }

    func showCSAT() {
        rating = 0
        selectedQuickOption = nil
        Comment = ""
        state = .collapsed
        isVisible = true
    }

    func showCSATWithDelay(_ delay: Double = 1.5) {
        isVisible = false

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self else { return }
            withAnimation(.easeInOut) {
                self.showCSAT()
            }
        }
    }

    // MARK: - Debug / Logging

    func logFeedback(source: String) {
        print("----- CSAT Feedback (\(source)) -----")
        print("Stars Selected: \(rating)")

        if let selectedQuickOption {
            print("Quick Option: \(selectedQuickOption)")
        } else {
            print("Quick Option: none")
        }

        if Comment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            print("Additional Comment: none")
        } else {
            print("Additional Comment: \(Comment)")
        }

        print("-----------------------------------")
    }
}
