//
//  Page.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 16/12/25.
//

import SwiftUI

enum Page: String, CaseIterable{
    case page1 = "gamecontroller.fill"
    case page2 = "star.bubble.fill"
    case page3 = "sparkles.rectangle.stack.fill"

    var Ptitle: String {
        switch self {
        case .page1:
            return "Play & Explore"
        case .page2:
            return "Share Your Feedback"
        case .page3:
            return "Feel the Delight"
        }
    }
    
    var subTitle: String {
        switch self {
        case .page1:
            return "Enjoy an interactive experience designed to feel smooth, fun, and intuitive"
        case .page2:
            return "Your feedback helps us improve. Rate your experience and tell us what you think."
        case .page3:
            return "Celebrate your input with delightful animations that make every action rewarding."
        }
    }
    
    var index : CGFloat{
        switch self {
        case .page1:
            return 0
        case .page2:
            return 1
        case .page3:
            return 2
        }
    }
    
    var nextpage: Page {
        let nextIndex = Int(self.index) + 1
        if nextIndex < Page.allCases.count {
            return Page.allCases[nextIndex]
        }
        return self
    }

}
