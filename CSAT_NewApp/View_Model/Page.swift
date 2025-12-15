//
//  Page.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 16/12/25.
//

import SwiftUI

enum Page: String, CaseIterable{
    case page1 = "gamecontroller.fill"
    case page2 = "link.icloud.fill"
    case page3 = "text.bubble.fill"

    var Ptitle: String {
        switch self {
        case .page1:
            return "Game Controller"
        case .page2:
            return "iCloud"
        case .page3:
            return "Text Bubble"
        }
    }
    
    var subTitle: String {
        switch self {
        case .page1:
            return "Connect your game controller to your device"
        case .page2:
            return "Connect your device to the internet"
        case .page3:
            return "Use the text bubble to share your score"
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
