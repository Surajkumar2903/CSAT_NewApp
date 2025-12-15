//
//  CSATView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

import SwiftUI

struct CSATView: View {
    @ObservedObject var viewModel: CSATViewModel
    @State private var showCloseAlert = false

    var body: some View {
        VStack(spacing: 16) {
            
            if viewModel.state == .thankYou {
                ThankYouView(rating: viewModel.rating)
            } else {
                
                Text("How would you rate your experience?")
                    .font(.headline)
                    .foregroundStyle(Color(.black))
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text("We value your feedback!")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.top, -8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                StarRatingView(rating: $viewModel.rating)
                
                if viewModel.state == .expanded {
                    FeedbackSectionView(viewModel: viewModel)
                }
            }
            
        }
        .alert("Discard feedback?", isPresented: $showCloseAlert) {
            Button("Discard", role: .destructive) {
                withAnimation(.easeInOut) {
                    viewModel.closeCompletely()
                }
            }

            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Your feedback will be lost.")
        }
        .padding()
        
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        )
        .overlay(alignment: .topTrailing) {
            HeaderView(closeAction: {
                if viewModel.state == .thankYou {
                        withAnimation(.easeInOut) {
                            viewModel.closeCompletely()
                        }
                    } else {
                        showCloseAlert = true
                    }
            })

                .padding(12)
        }
        
        .padding()
    }


}
