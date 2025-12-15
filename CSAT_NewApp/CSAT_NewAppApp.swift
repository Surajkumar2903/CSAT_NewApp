//
//  CSAT_NewAppApp.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

import SwiftUI

@main
struct CSAT_NewAppApp: App {

    @State private var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                StartView()
            } else {
                IntroView(hasCompletedOnboarding: $hasCompletedOnboarding)
                    .environment(\.colorScheme, .dark)
            }
        }
    }
}

