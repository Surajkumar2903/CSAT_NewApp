//
//  CSATHostView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//
import SwiftUI
struct CSATHostView: View {
    @StateObject private var viewModel = CSATViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {

            // 1️⃣ Background content (UNCHANGED)
            VStack(spacing: 12) {
                Image(systemName: "gamecontroller.fill")
                    .resizable()
                    .frame(width: 120, height: 80)
                    .foregroundColor(.purple)
                    .padding(.top, 12)

                Text("Game Setup")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top ,12)

                Text("Campaigns: 0")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.top, 12)
                    .padding(.bottom, 24)

                Text("No campaings for this screen")
                    .font(.footnote)
                    .foregroundColor(.gray)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            // 2️⃣ CSAT Overlay (UNCHANGED)
            if viewModel.isVisible {
                CSATView(viewModel: viewModel)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeInOut, value: viewModel.isVisible)
            }

            // 3️⃣ ✅ CONFETTI OVERLAY (ADD ONLY THIS)
            if viewModel.showConfetti {
                ConfettiView()
                    .transition(.opacity)
                    .zIndex(999)
            }
        }
        .navigationTitle("Third Setup")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.showCSATWithDelay(0.8)
        }
    }
}
