import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class AccountManageViewModel: ObservableObject {
    
    static let cache = NSCache<NSString, UIImage>()
    
    @Published var userName: String?
    @Published var userNickName: String?
    @Published var userEmail: String?
    @Published var userPhoneNumber: String?
    @Published var userImageURL: URL?
    @Published var userImage: UIImage?
    
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
                self.userNickName = document.document.get("nickname") as? String
                self.userEmail = document.document.get("email") as? String
                self.userPhoneNumber = document.document.get("phonenumber") as? String
            }
        }
        
        self.userImageURL = Auth.auth().currentUser?.photoURL
        
        print("[DEBUG] 유저 이미지 URL : \(String(describing: userImageURL))")
        
        if userImageURL != nil {
            self.getProfileImage()
        }
        
        print("[DEBUG] 유저 이름: \(String(describing: self.userName))")
    }
    
    func saveUserInformation(name: String, nickName: String, phoneNumber: String) {
        let collectionPath = Firestore.firestore().collection("users")
        let userID = Auth.auth().currentUser?.uid
        
        collectionPath.document("\(userID!)").updateData(["username": name, "nickname": nickName, "phonenumber": phoneNumber]) { error in
            if error != nil {
                print("[❌] ERROR : 유저 정보 저장 실패")
                print((error?.localizedDescription)!)
                return
            }
        }
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        changeRequest?.displayName = nickName
        changeRequest?.commitChanges(){ error in
            if let error = error {
                print("[ERROR] : photoURL 변경 중 에러 발생 \(error.localizedDescription)")
            }
            else {
                print("[DEBUG] : dispalyName 변경 성공")
                
            }
        }
        
        Auth.auth().currentUser?.reload()
    }
    
    func saveProfileImage(_ image: UIImage) {
        ImageUploader.uploadImage(image: image) { profileImageURL in
            
            let dataTask = URLSession.shared.dataTask(with: profileImageURL) { data, responseURL, error in
                print("[DEBUG] : data 출력 : \(String(describing: data))")
                
                if error != nil {
                    print("[ERROR] : 이미지 다운로드 실패 \(String(describing: error?.localizedDescription))")
                }
                
                var downloadedImage: UIImage?
                
                if let data = data {
                    print("[DEBUG] : 데이터 언랩 후 UIImage 형태로 저장 성공")
                    downloadedImage = UIImage(data: data)
                }
                
                if downloadedImage != nil {
                    print("[DEBUG] : 이미지 캐시에 저장 완료")
                    AccountManageViewModel.cache.setObject(downloadedImage!, forKey: profileImageURL.absoluteString as NSString)
                }
                
                DispatchQueue.main.async {
                    print("[DEBUG] : 유저 이미지 저장")
                    self.userImage = downloadedImage
                }
                print("[DEBUG] : 유저 이미지 : \(String(describing: self.userImage))")
            }
            dataTask.resume()
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            
            changeRequest?.photoURL = profileImageURL
            changeRequest?.commitChanges(){ error in
                if let error = error {
                    print("[ERROR] : photoURL 변경 중 에러 발생 \(error.localizedDescription)")
                }
                else {
                    print("[DEBUG] : photoURL 업로드 성공")
                }
            }
        }
    }
    
    func downloadProfileImage() {
        print("[DEBUG] : downloadImaeg 실행")
        
        if let url = userImageURL {
            print("[DEBUG] : 이미지 url 옵셔널 언래핑 성공")
            let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
                print("[DEBUG] : data 출력 : \(String(describing: data))")
                
                if error != nil {
                    print("[ERROR] : 이미지 다운로드 실패 \(String(describing: error?.localizedDescription))")
                }
                
                var downloadedImage: UIImage?
                
                if let data = data {
                    print("[DEBUG] : 데이터 언랩 후 UIImage 형태로 저장 성공")
                    downloadedImage = UIImage(data: data)
                }
                
                if downloadedImage != nil {
                    print("[DEBUG] : 이미지 캐시에 저장 완료")
                    AccountManageViewModel.cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
                }
                
                DispatchQueue.main.async {
                    print("[DEBUG] : 유저 이미지 저장")
                    self.userImage = downloadedImage
                }
                print("[DEBUG] : 유저 이미지 : \(String(describing: self.userImage))")
            }
            
            dataTask.resume()
        } else {
            print("[ERROR] : 이미지 uRL = nil, \(String(describing: userImageURL))")
        }
    }
    
    func getProfileImage() {
        print("[DEBUG] : getProfileImage 실행")
        
        if let cacheImage = AccountManageViewModel.cache.object(forKey: self.userImageURL!.absoluteString as NSString) {
            self.userImage = cacheImage
        } else {
            Task {
                downloadProfileImage()
            }
        }
    }
}
