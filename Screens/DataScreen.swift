//
//  DataScreen.swift
//  Day Dreamer
//
//  Created by Adam Strickland on 2/9/24.
//

import SwiftUI

struct DataScreen: View {
    var body: some View {
        Color("PrimaryBackground")
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Text("Hello, World!")
            )
    }
}

#Preview {
    DataScreen()
}
