//
//  HomeScreen.swift
//  Day Dreamer
//
//  Created by Adam Strickland on 2/9/24.
//
import SwiftUI

//struct HomeScreen: View {
//    var body: some View {
//        Color("PrimaryBackground")
//            .edgesIgnoringSafeArea(.all)
//            .overlay(
//                ScrollView(showsIndicators: false) { // Enables scrolling
//                    VStack(spacing: 20) { // Vertically arranges your cards with spacing
//                        ForEach(0..<10) { _ in // Example loop to create multiple cards
//                            DayDreamCard()
//                        }
//                    }
//                    .padding() // Adds padding around the VStack content
//                }
//            )
//    }
//}


struct HomeScreen: View{
    
    var body: some View{
        
        ZStack{
            
            LinearGradient(
                colors: [Color("Primary"),Color("Secondary")],
                startPoint: .top,
                endPoint: .bottom)
                .ignoresSafeArea()
            
            // Gloss Background....
            GeometryReader{proxy in
                
                let size = proxy.size
                
                // Slighlty Darkening ...
                Color.black
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                Circle()
                    .fill(Color("Purple"))
                    .padding(50)
                    .blur(radius: 120)
                // Moving Top...
                    .offset(x: -size.width / 1.8, y: -size.height / 5)
                
                Circle()
                    .fill(Color("LightBlue"))
                    .padding(50)
                    .blur(radius: 150)
                // Moving Top...
                    .offset(x: size.width / 1.8, y: -size.height / 2)
                
                
                Circle()
                    .fill(Color("LightBlue"))
                    .padding(50)
                    .blur(radius: 90)
                // Moving Top...
                    .offset(x: size.width / 1.8, y: size.height / 2)
                
                // Adding Purple on both botom ends...
                
                Circle()
                    .fill(Color("Purple"))
                    .padding(100)
                    .blur(radius: 110)
                // Moving Top...
                    .offset(x: size.width / 1.8, y: size.height / 2)
                
                Circle()
                    .fill(Color("Purple"))
                    .padding(100)
                    .blur(radius: 110)
                // Moving Top...
                    .offset(x: -size.width / 1.8, y: size.height / 2)
            }
            
            // Content....
            VStack{
                
//                Spacer(minLength: 10)
                
                // GlassMorphism Card...
                
                ZStack{
                    
                    
                    // Bacground Balls...
                    Circle()
                        .fill(Color("Purple"))
                        .blur(radius: 20)
                        .frame(width: 100, height: 100)
                        .offset(x: 120, y: -80)
                    
                    Circle()
                        .fill(Color("LightBlue"))
                        .blur(radius: 40)
                        .frame(width: 100, height: 100)
                        .offset(x: -120, y: 100)
                    
                    ScrollView(showsIndicators: false) { // Enables scrolling
                        VStack(spacing: 20) { // Vertically arranges your cards with spacing
                            ForEach(0..<10) { _ in // Example loop to create multiple cards
                                DayDreamCard()
                            }
                        }
                        .padding() // Adds padding around the VStack content
                    }
                }
                
//                Spacer(minLength: 10)


            }
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
//            .padding()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

