//
//  HomeScreen.swift
//  Day Dreamer
//
//  Created by Adam Strickland on 2/9/24.
//
import SwiftUI

struct HomeScreen: View {
    var body: some View {
        Color("PrimaryBackground")
            .edgesIgnoringSafeArea(.all)
            .overlay(
                ScrollView(showsIndicators: false) { // Enables scrolling
                    VStack(spacing: 20) { // Vertically arranges your cards with spacing
                        ForEach(0..<10) { _ in // Example loop to create multiple cards
                            DayDreamCard()
                        }
                    }
                    .padding() // Adds padding around the VStack content
                }
            )
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
