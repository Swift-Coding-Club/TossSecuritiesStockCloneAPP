//
//  PersonalInformationView.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/22.
//

import SwiftUI
import AttributedText

struct PersonalInformationView: View {
    
   
    @State private var desc: String = ProfileSetttingModel.personalInformation
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 4)
            Text("개인 정보 처리 방침")
                .spoqaHan(family: .Medium, size: 30)
                .foregroundColor(Color.fontColor.mainFontColor)
            
            Spacer()
                .frame(height: 20)
            
      
            
           
            
            
                Spacer()
        }
        .padding(.horizontal, 5)
    }
}

struct PersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInformationView()
    }
}
//코인모여 개인정보처리방침
//코인모여(이하 ‘코인모여’)는 서비스 기획부터 종료까지 개인정보보호법 등 국내의 개인정보 보호 법령을 철저히 준수합니다. 또한 OECD의 개인정보 보호 가이드라인 등 국제 기준을 준수하여 서비스를 제공합니다.본 개인정보처리방침의 목차는 아래와 같습니다.
//관계법령이 요구하는 개인정보처리방침의 필수 사항과 웨더 자체적으로 이용자 개인정보 보호에 있어 중요하게 판단하는 내용을 포함하였습니다.
//1.개인정보처리방침의 의의
//2.수집하는 개인정보 (필수 안내사항)
//3.수집한 개인정보의 이용 (필수 안내사항)
//4.개인정보의 제공 및 위탁 (필수 안내사항)
//5.개인정보의 파기 (필수 안내사항)
//6.이용자 및 법정대리인의 권리와 행사 방법 (필수 안내사항)
//7.개인정보보호를 위한 네이버의 노력 (필수 안내사항)
//8.개인정보 보호책임자 및 담당자 안내 (필수 안내사항)
//9.개인위치정보의 처리 (필수 안내사항)
//10.본 개인정보처리방침의 적용 범위
////11.개정 전 고지 의무
