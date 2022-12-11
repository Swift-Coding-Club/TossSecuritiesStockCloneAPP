//
//  ImageUploader.swift
//  StockApp
//
//  Created by 권승용 on 2022/12/09.
//
import FirebaseStorage
import UIKit

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let fileName = UUID().uuidString
        let storageReference = Storage.storage().reference(withPath: "/profile_image/\(fileName)")
        
        storageReference.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: 프로필 이미지 업로드 실패 : \(error.localizedDescription)")
            }
            
            storageReference.downloadURL { imageURL, error in
                if let error = error {
                    print("DEBUG: URL 다운로드 실패 : \(error.localizedDescription)")
                }
                
                guard let imageURL = imageURL?.absoluteString else { return }
                completion(imageURL)
            }
        }
    }
}
