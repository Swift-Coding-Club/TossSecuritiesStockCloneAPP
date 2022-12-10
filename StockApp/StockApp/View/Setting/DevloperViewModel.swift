//
//  DevloperViewModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/11.
//

import Foundation

enum DevloperViewModel: Int ,CaseIterable , CustomStringConvertible {
    case roy
    case eric
    case lia
    case nadine
    case ruby
    
    var description: String {
        switch self {
        case .roy:
            return "로이(Roy)"
        case .eric:
            return "에릭(Eric)"
        case .lia:
            return "리아(Lia)"
        case .nadine:
            return "나디(Nadine)"
        case .ruby:
            return "루비(ruby)"
        }
    }
    
    var information: String {
        switch self {
        case .roy:
            return "개인보다는 함께를 선호하며\n 지식의 나눔을 실천하는\n 개발자입니다."
        case .eric:
            return "같이 성장하는 개발자 입니다"
        case .lia:
            return "함께 성장하는 개발자 입니다"
        case .nadine:
            return "같이 성장하는 PM 입니다"
        case .ruby:
            return "다양한 디자인을 하는  디자이너 입니다"
        }
    }
    
    var githublink: String {
        switch self {
        case .roy:
            return "https://github.com/Roy-wonji"
        case .eric:
            return "https://github.com/KSYong"
        case .lia:
            return "https://github.com/est22"
        case .nadine:
            return "https://github.com/seonghyeonOrNot"
        case .ruby:
            return "https://velog.io/@blessoms2017"
        }
    }
    
    var instagram : String {
        switch self {
        case .roy:
            return "https://www.instagram.com/iosdev.roy/"
        case .eric:
            return ""
        case .lia:
            return ""
        case .nadine:
            return ""
        case .ruby:
            return "https://instagram.com/rubyellowishgold?igshid=Zjc2ZTc4Nzk="
        }
    }
    
    var profileImage: String {
        switch self {
        case .roy:
            return "로이"
        case .eric:
            return "승융"
        case .lia:
            return "리아"
        case .nadine:
            return "성현"
        case .ruby:
            return "루비"
        }
    }
}
