//
//  ThankYouView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//

import SwiftUI

struct ThankYouView: View {
    let rating: Int

    var body: some View {
        VStack(spacing: 16) {
            Image("Thank_you")
                .resizable()
                .frame(width: 250, height: 220)
                .foregroundColor(.blue)
                .padding(.top,16)

            Text("Thank You for your feedback!")
                .font(.system(size: 16, weight: .bold, design: .default))
                

            Text("Your insight will help us improve.")
                .font(.caption2)
                .foregroundColor(.black)

            Text(rating > 3 ? "good experience" : "bad experience")
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(22)
        }
    }
}
