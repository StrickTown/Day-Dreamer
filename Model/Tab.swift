//
//  Tab.swift
//  Day Dreamer
//
//  Created by Adam Strickland on 2/9/24.
//

import SwiftUI

/// App Tab's
enum Tab: String, CaseIterable {
    case home = "Home"
    case data = "Data"
    case add = "Add"
    case wins = "Wins"
    case share = "Share"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .data:
            return "chart.line.uptrend.xyaxis"
        case .add:
            return "plus"
        case .wins:
            return "trophy"
        case .share:
            return "square.and.arrow.up"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
