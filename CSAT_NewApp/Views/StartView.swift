//
//  StartView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//


import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Spacer()

                NavigationLink {
                    CSATHostView()
                } label: {
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(Color.text)
                        .frame(width: 160, height: 50)
                        .background(Color.themeColour)
                        .cornerRadius(25)
                }

                Text("Press on Start Button to show CSAT")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()
            }
        }
    }
}
