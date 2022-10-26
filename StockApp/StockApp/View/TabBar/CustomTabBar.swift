//
//  CustomTabBar.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/27.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    
    @State var tabPoints : [CGFloat] = []
    var body: some View {
        
        HStack(spacing: 0){
            // Tab Bar Buttons...
            
            TabBarButton(image: "house", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "bookmark", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "message", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints)
        }
        .padding()
        .background(
            Color.white
                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
        )
        .overlay(
        
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20)
            
            ,alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    
    // extracting point...
    func getCurvePoint()->CGFloat{
        
        // if tabpoint is empty...
        if tabPoints.isEmpty{
            return 10
        }
        else{
            switch selectedTab {
            case "house":
                return tabPoints[0]
            case "bookmark":
                return tabPoints[1]
            case "message":
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant("house"))
    }
}
