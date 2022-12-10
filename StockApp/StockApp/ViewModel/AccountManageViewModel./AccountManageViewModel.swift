import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class AccountManageViewModel: ObservableObject {
    
    @Published var userName: String?
    @Published var userEmail: String?
    @Published var userPhoneNumber: String?
    
    init() {
        getUserInformation()
    }
    
    func getUserInformation() {
        
        let collectionPath = Firestore.firestore().collection("users")
        let userID = Auth.auth().currentUser?.uid
        
        guard let userID = userID else { return }
        
        collectionPath.whereField("uid", isEqualTo: userID).addSnapshotListener { (snap, error) in
            if error != nil {
                print("[❌] ERROR: 유저 가져오기 실패")
                print((error?.localizedDescription)!)
                return
            }
            
            for document in snap!.documentChanges {
                self.userName = document.document.get("username") as? String
                self.userEmail = document.document.get("email") as? String
                self.userPhoneNumber = document.document.get("phonenumber") as? String
            }
        }
        print("유저 이름: \(self.userName)")
    }
    
    func saveUserInformation(name: String, phoneNumber: String) {
        let collectionPath = Firestore.firestore().collection("users")
        let userID = Auth.auth().currentUser?.uid
        let currentUser = Auth.auth()
        
        collectionPath.document("\(userID!)").updateData(["username": name, "phonenumber": phoneNumber]) { error in
            if error != nil {
                print("[❌] ERROR : 유저 정보 저장 실패")
                print((error?.localizedDescription)!)
                return
            }
        }
    }
    
    // UIImage 사용 이유 : UIImage만이 imageData로 변환 가능함
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageURL in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageURL": profileImageURL]) { error in
                    if error != nil {
                        print("[❌] ERROR : 유저 프로필 이미지 업로드 실패")
                    }
                }
        }
        
    }
}
