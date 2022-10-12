//
//  CheckRegister.swift
//  StockApp
//
//  Created by 서원지 on 2022/10/11.
//

import Foundation

struct CheckRegister{
    //MARK:  이메일 체크
    static func isValidateEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    static func isValidateId(_ id:String) -> Bool {
        let idRegEx = "[A-Za-z0-9]{5,13}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", idRegEx)
        return predicate.evaluate(with: id)
    }
    
    static func isValidateNickName(_ nick: String) -> Bool {
        let nickRegEx = "[가-힣A-Za-z0-9]{2,7}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
        return predicate.evaluate(with: nick)
        
    }
    
    static func isValidatePassword(_ pass: String) -> Bool {
        let passwordRegEx = "^[A-Za-z0-9!_@$%^&+=]{8,20}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: pass)
    }
    
    static func isValidatePhoneNumber(_ phone: String) -> Bool {
        let regex = "^01[0-1, 7][0-9]{7,8}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return phonePredicate.evaluate(with: phone)
    }
}
