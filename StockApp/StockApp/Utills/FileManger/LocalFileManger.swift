//
//  LocalFileManger.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/24.
//

import SwiftUI

class LocalFileManger {
    
    static let instaince = LocalFileManger()
    private init() { }
    
    //MARK: - 이미지 다운로드 함수
    func savedImage(image: UIImage, imageName: String, folderName: String) {
        
        //MARK:  - 폴더 생성
        createFolderIfNeeded(folderName: folderName)
        //MARK:  - 이미지르 png 형식으로 바꿔서 다운로드 및  위치 저장
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        do  {
            try data.write(to: url)
        } catch let error{
            debugPrint("잘못된 이미지 입니다 imageName: \(imageName) . \(error.localizedDescription)")
        }
    }
    
    //MARK: - 이미지 가져오기
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
        FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
     
    //MARK:  - 폴더 생성
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                debugPrint("잘못된  디렉토리 입니다  folderName: \(folderName) , \(error.localizedDescription)")
            }
        }
    }
    
    //MARK:  - url Foleder
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL?  {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}

