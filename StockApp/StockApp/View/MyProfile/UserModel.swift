//
//  UserModel.swift
//  StockApp
//
//  Created by 서원지 on 2022/12/16.
//

import FirebaseFirestoreSwift

struct UserModel: Identifiable, Decodable{
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let phonenumber: String
    let email: String
}
