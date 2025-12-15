//
//  IntroView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 16/12/25.
//

import SwiftUI

struct IntroView: View {
    @State private var activePage : Page = .page1
    @Binding var hasCompletedOnboarding: Bool

    var body: some View {
        GeometryReader{
            let size = $0.size
            
            VStack{
                Spacer(minLength: 0)
                
                MorphingSymbolView(
                    symbol: activePage.rawValue,
                    config: .init(
                        font: .system(size: 150, weight: .bold),
                        frame: .init(width: 250, height: 200),
                        radius: 30,
                        foregroundColor: .white,
                  )
                )
          
                TextContent(size: size)
                
                Spacer(minLength: 0)
                
                IndicatorView()
                
                ContinueButton()
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top){
                headerView()
            }
        }
        .background {
            Rectangle()
                .fill(.black.gradient)
                .ignoresSafeArea()
        }
    }
    @ViewBuilder
    func TextContent(size : CGSize) -> some View {
        VStack(spacing: 8){
            HStack(alignment: .top, spacing: 0){
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.Ptitle)
                        .lineLimit(1)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .kerning(1.1)
                        .frame(width: size.width)
                }
            }
            //Sliding left right based on pages
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.7, extraBounce: 0.1), value: activePage)
            
            HStack(alignment: .top, spacing: 0){
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.subTitle)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                        .frame(width: size.width)
                }
            }
            //Sliding left right based on pages
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.9, extraBounce: 0.1), value: activePage)
        }
        .padding(.top , 15)
        .frame(width: size.width, alignment: .leading)
    }
    
    @ViewBuilder
    func IndicatorView() -> some View {
        HStack(spacing: 20){
            ForEach(Page.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 : 0.3))
                    .frame(width: activePage == page ? 25 : 8, height: 8)
            }
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
        .padding(.bottom, 12)
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack{
            Button{
                let prevIndex = Int(activePage.index) - 1
                if prevIndex >= 0 {
                    activePage = Page.allCases[prevIndex]
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(.rect)
                    .foregroundStyle(.white)
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            Button("Skip"){
                activePage = .page3
            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .opacity(activePage != .page3 ? 1: 0)
        }
        .animation(.snappy(duration: 0.35, extraBounce: 0), value: activePage)
        .padding(15)
    }
    
    //Continue Button
    @ViewBuilder
    func ContinueButton() -> some View {
        Button {
            if activePage == .page3 {
                hasCompletedOnboarding = true
            } else {
                activePage = activePage.nextpage
            }
        } label: {
            Text(activePage == .page3 ? "Let's go" : "Continue")
                .contentTransition(.identity)
                .foregroundStyle(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: activePage == .page3 ? 220 : 180)
                .background(.white, in: .capsule)
        }
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }

}

#Preview {
    ContentView()
}
