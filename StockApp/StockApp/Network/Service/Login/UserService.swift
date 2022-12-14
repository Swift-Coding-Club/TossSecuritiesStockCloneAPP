//
//  UserService.swift
//  StockApp
//
//  Created by μμμ§ on 2022/11/14.
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
                debugPrint("[π₯] μ μ  μ λ³΄λ₯Ό κ°μ Έμ€λλ° μ€ν¨ νμμ΅λλ€ \(error.localizedDescription)")
                }
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: UserModel.self) else {return}
                completion(user)
            }
    }
}
