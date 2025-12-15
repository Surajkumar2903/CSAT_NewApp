//
//  ContentView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var hasCompletedOnboarding = false

    var body: some View {
        IntroView(hasCompletedOnboarding: $hasCompletedOnboarding)
            .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
