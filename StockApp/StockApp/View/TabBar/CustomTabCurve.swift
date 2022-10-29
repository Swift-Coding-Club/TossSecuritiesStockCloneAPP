//
//  CustomTabCurve.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/29.
//

import SwiftUI

struct CustomTabCurve: Shape {
    
    var curveAxis : CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path  in
            
            let height = rect.height - 100
            
            let point1 = CGPoint(x: 0 , y:  0)
            let point2 = CGPoint(x: rect.width, y:  0)
            let point3 = CGPoint(x: rect.width, y:  height)
            let point4 = CGPoint(x: 0 , y:  height)
            
            path.move(to: point1)
            
            path.addArc(tangent1End: point1, tangent2End: point2, radius: .zero)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: .zero)
            path.addArc(tangent1End: point3, tangent2End: point4, radius: .zero)
            path.addArc(tangent1End: point4, tangent2End: point1, radius: .zero)
            
            
            let mid  = curveAxis
            let curve = rect.height - 50
            
            path.move(to: CGPoint(x: mid - 60, y: height))
            
            let to1 = CGPoint(x: mid, y:  curve)
            let control1 = CGPoint(x: mid - 30, y:  height)
            let control2 = CGPoint(x: mid - 30 , y:  curve)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            let to2 = CGPoint(x: mid + 60, y:  height)
            let control3 = CGPoint(x: mid + 30, y:  curve)
            let control4 = CGPoint(x: mid + 30 , y:  height)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
            
        }
    }
}

struct CustomTabCurve_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTabVIew()
        }
    }
}
