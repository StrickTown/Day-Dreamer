//
//  DayDreamCard.swift
//  Day Dreamer
//
//  Created by Adam Strickland on 2/9/24.
//

import SwiftUI

struct DayDreamCard: View{
    
    var body: some View{
        
        let width = UIScreen.main.bounds.width
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .opacity(0.08)
                .background(
                
                    Color.white
                        .opacity(0.008)
                        .blur(radius: 10)
                )
            // Strokes...
                .background(
                
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                        
                            .linearGradient(.init(colors: [
                            
                                Color("Primary"),
                                Color.purple.opacity(0.5),
                                .clear,
                                .clear,
                                Color("Secondary"),
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            ,lineWidth: 2.5
                        )
                        .padding(2)
                )
            // Shadows...
                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            
            // COntent...
            VStack{
                
                Image(systemName: "sun.max")
                    .font(.system(size: 45, weight: .thin))
                
                Text("18")
                    .font(.system(size: 85, weight: .bold))
                    .padding(.top,2)
                    .overlay(
                    
                        Text("Days")
                            .font(.title2)
                            .foregroundColor(Color.white.opacity(0.7))
                            .offset(x: 50, y: 15)
                        
                        ,alignment: .topTrailing
                    )
                    .offset(x: -6)
                
                Text("Day Dream")
                    .font(.title3)
                    .foregroundColor(Color.white.opacity(0.4))
            }
        }
        .frame(width: 320, height: 270)
    }
}

struct DayDreamCard_Previews: PreviewProvider {
    static var previews: some View {
        DayDreamCard()
    }
}
