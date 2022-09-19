//
//  CircleButtonAnimationVIew.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/20.
//

import SwiftUI

struct CircleButtonAnimationVIew: View {
    //MARK: - 홈 뷰에서 바인딩에서 사용할수 있게 구현
    
    @Binding  var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0: .zero)
            .opacity(animate ? .zero : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)
        //MARK: - 뷰에서 클릭 했을경우 또는 실행됐을 경우
            .onAppear {
                animate.toggle()
            }
    }
}

struct CircleButtonAnimationVIew_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationVIew(animate: .constant(false))
            .foregroundColor(Color.red)
            .frame(width: 100, height: 100)
    }
}
