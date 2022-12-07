//
//  UserService.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/14.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    //MARK: - user fetch
    func fetchUser(withUid uid: String,  completion: @escaping(UserModel) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                debugPrint("[🔥] 유저 정보를 가져오는데 실패 하였습니다 \(error.localizedDescription)")
                }
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: UserModel.self) else {return}
                completion(user)
            }
    }
}
