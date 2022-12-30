//
//  ImageUploader.swift
//  StockApp
//
//  Created by 권승용 on 2022/12/09.
//
import FirebaseStorage
import Firebase
import UIKit

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping(URL) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        
        guard let fileName = Auth.auth().currentUser?.uid else {
            debugPrint("[ERROR] : ImageUploader에서 유저 세션 nil")
            return
        }
        
        let storageReference = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        storageReference.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("[ERROR] : 프로필 이미지 업로드 실패 : \(error.localizedDescription)")
            }
            
            storageReference.downloadURL { imageURL, error in
                if let error = error {
                    print("[ERROR] : URL 다운로드 실패 : \(error.localizedDescription)")
                }
                
                guard let imageURL = imageURL else { return }
                completion(imageURL)
            }
        }
    }
}
