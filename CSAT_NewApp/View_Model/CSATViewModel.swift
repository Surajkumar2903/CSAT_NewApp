//
//  CSATViewModel.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

import SwiftUI
internal import Combine
final class CSATViewModel: ObservableObject {
 
    @Published var isVisible: Bool = false
    @Published var state: State = .collapsed
    private var thankYouTask: DispatchWorkItem?
    private var autoThankYouTask: DispatchWorkItem?

    @Published var selectedQuickOption: String? = nil
    @Published var Comment = ""
    @Published var showConfetti: Bool = false


    enum State {
        case collapsed
        case expanded
        case thankYou
    }

    @Published var rating: Int = 0 {
        didSet {
            guard rating > 0 else { return }

            withAnimation {
                state = .expanded
            }
            
            if rating > 3 {
                logFeedback(source: "Auto (Rating > 3)")

                // Cancel any previous auto flow
                autoThankYouTask?.cancel()

                // 1️⃣ Start confetti immediately
                showConfetti = true

                let task = DispatchWorkItem { [weak self] in
                    guard let self else { return }

                    // 2️⃣ Move to Thank You AFTER confetti is visible
                    withAnimation(.easeInOut(duration: 0.45)) {
                        self.state = .thankYou
                    }

                    // 3️⃣ Stop confetti AFTER Thank You is stable
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                        self.showConfetti = false
                    }
                }

                autoThankYouTask = task

                // Small intentional pause (prevents race)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
            }




        }
    }



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




    func quickOptions(for rating: Int) -> [String] {
        switch rating {
        case 1:
            return [
                "Very frustrating",
                "App did not work properly"
            ]

        case 2:
            return [
                "Slow or unresponsive",
                "Not easy to use"
            ]

        case 3:
            return [
                "Average experience",
                "Could be better"
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


    func submit() {
        logFeedback(source: "Submit Button")

        // Move to thank-you immediately
        withAnimation(.smooth(duration: 0.35)) {
            state = .thankYou
        }

        // Confetti over thank-you
        showConfetti = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            self.showConfetti = false
        }
    }



    
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
