//
//  TabBarButton.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/27.
//

import SwiftUI

struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    
    var body: some View{
        
        // For getting mid Point of each button for curve Animation....
        GeometryReader{reader -> AnyView in
            
            // extracting MidPoint and Storing....
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                
                // avoiding junk data....
                if tabPoints.count <= 4{
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
            
                Button(action: {
                    // changing tab...
                    // spring animation...
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)){
                        selectedTab = image
                    }
                }, label: {
                    
                    // filling the color if it' selected...
                    
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color.colorAssets.navy.opacity(0.8))
                    // Lifting View...
                    // if its selected...
                        .offset(y: selectedTab == image ? -10 : 0)
                })
                // Max Frame...
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
            )
        }
        // maxHeight..
        .frame(height: 40)
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(image: "flame", selectedTab: .constant("house"), tabPoints: .constant([1]))
    }
}
