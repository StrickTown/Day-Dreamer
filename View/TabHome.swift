//
//  Home.swift
//  Day Dreamer
//
//  Created by Adam Strickland on 2/9/24.
//

import SwiftUI

struct TabHome: View {
    /// View Properties
    @State private var activeTab: Tab = .home
    /// For Smooth Shape Sliding Effect, We're going to use Matched Geometry Effect
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    init() {
        /// Hiding Tab Bar Due To SwiftUI iOS 16.4 Bug
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                HomeScreen()
                    .tag(Tab.home)
                    /// Hiding Native Tab Bar
                    /// Bug on iOS 16.4
                    // .toolbar(.hidden, for: .tabBar)
                
                DataScreen()
                    .tag(Tab.data)
                    /// Hiding Native Tab Bar
                    /// Bug on iOS 16.4
                    // .toolbar(.hidden, for: .tabBar)
                
                AddScreen()
                    .tag(Tab.add)
                    /// Hiding Native Tab Bar
                    /// Bug on iOS 16.4
                    // .toolbar(.hidden, for: .tabBar)
                
                WinsScreen()
                    .tag(Tab.wins)
                    /// Hiding Native Tab Bar
                    /// Bug on iOS 16.4
                    // .toolbar(.hidden, for: .tabBar)
                
                ShareScreen()
                    .tag(Tab.share)
                    /// Hiding Native Tab Bar
                    /// Bug on iOS 16.4
                    // .toolbar(.hidden, for: .tabBar)
            }
            
            CustomTabBar()
                .padding(.top, -25)
        }
    }
    
    /// Custom Tab Bar
    /// With More Easy Customization
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("ActiveBackground"), _ inactiveTint: Color = Color("TabBlue")) -> some View {
        /// Moving all the Remaining Tab Item's to Bottom
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab,
                    position: $tabShapePosition
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(content: {
            TabShape(midpoint: tabShapePosition.x)
                .fill(Color("PrimaryBackground"))
                .ignoresSafeArea()
                /// Adding Blur + Shadow
                /// For Shape Smoothening
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        /// Adding Animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

/// Tab Bar Item
struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    
    /// Each Tab Item Position on the Screen
    @State private var tabPosition: CGPoint = .zero
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                /// Increasing Size for the Active Tab
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            
            /// Updating Active Tab Position
            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        TabHome()
    }
}
