//
//  FeedbackSheetView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

import SwiftUI

struct FeedbackSectionView: View {

    @ObservedObject var viewModel: CSATViewModel
    var body: some View  {
    VStack(spacing: 14) {
        
        VStack(spacing: 10) {
            ForEach(viewModel.quickOptions(for: viewModel.rating), id: \.self) { option in
                Button {
                    viewModel.selectedQuickOption = option
                } label: {
                    HStack {
                        Text(option)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(
                                viewModel.selectedQuickOption == option
                                ? Color.black
                                : Color.gray.opacity(0.3),
                                lineWidth: 1
                            )
                    )
                }
            }
        }
        
        // ADDITIONAL COMMENTS
        Text("Additional Comments")
            .font(.caption2.weight(.semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ZStack(alignment: .topLeading) {
            
            TextEditor(text: $viewModel.Comment)
                .frame(height: 110)
                .padding(.horizontal, 8)
                .padding(.top, 8)
                .background(Color.clear)
            
            if viewModel.Comment.isEmpty {
                Text("Write your feedback...")
                    .foregroundColor(.gray.opacity(0.55))
                    .padding(.horizontal, 14)
                    .padding(.top, 14)
                    .allowsHitTesting(false)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3))
        )
    
        // SUBMIT CTA
        Button {
            viewModel.submit()
        } label: {
            Text("Submit")
            
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(26)
        }
    }
    .padding(.top, 4)
    .padding(.bottom, 200)
}
}
