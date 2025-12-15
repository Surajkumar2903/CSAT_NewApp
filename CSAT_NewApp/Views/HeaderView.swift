//
//  HeaderView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 15/12/25.
//


import SwiftUI

struct HeaderView: View {

    let closeAction: () -> Void

    var body: some View {
        HStack {
            Spacer()

            Button(action: closeAction) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                    .frame(width: 28, height: 28)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())
            }
        }
    }
}
