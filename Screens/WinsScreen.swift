//
//  WinsScreen.swift
//  Day Dreamer
//
//  Created by Adam Strickland on 2/9/24.
//

import SwiftUI

struct WinsScreen: View {
    var body: some View {
        Color("PrimaryBackground")
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Text("Hello, World!")
            )
    }
}

#Preview {
    WinsScreen()
}
