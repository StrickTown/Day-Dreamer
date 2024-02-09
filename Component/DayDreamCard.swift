//
//  DayDreamCard.swift
//  Day Dreamer
//
//  Created by Adam Strickland on 2/9/24.
//

import SwiftUI

struct DayDreamCard: View {
    var body: some View {
        Text("Hello, World!")
            .padding() // Add padding around the text
            .frame(width: 310, height: 200)
            .background(Color("SecondaryBackground")) // Set the card's background color to white
            .cornerRadius(10) // Round the corners of the card
            .shadow(radius: 5) // Apply a shadow with a radius of 5 to create the elevation effect
//            .padding() // Add more padding to separate the card from the edges of the screen
    }
        
}

struct DayDreamCard_Previews: PreviewProvider {
    static var previews: some View {
        DayDreamCard()
    }
}
