//
//  PortfolioDataService.swift
//  StockApp
//
//  Created by 서원지 on 2022/09/27.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    //MARK: - core data 셋팅
    private let container : NSPersistentContainer
    private let containerName: String = "PortofolioModel"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntites: [PortfolioEntity] = [ ]
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_ , error) in
            if let error = error {
                debugPrint("Error loading Core Data! \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    //MARK: - 보유 수량 값을 뷰모델 또는 다른 파일에 전달
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // 보유 수량이 코인 이 있는 확인
        if let entity = savedEntites.first(where: {$0.coinId == coin.id}) {
            if amount > .zero {
                update(entity: entity, amunt: amount)
            } else {
                removePortfolio(entity: entity)
            }
        } else{
            addPortfolio(coin: coin, amount: amount)
        }
    }
    
    //MARK: - 보유 수량  저장 한데이터 가져오기
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntites = try container.viewContext.fetch(request)
        } catch let error {
            debugPrint("Error fetching portfolio Entites . \(error.localizedDescription)")
        }
    }
    
    //MARK:  - 보유 수량  core data 추가 하기
    private func addPortfolio(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChange()
    }
    //MARK:  - 보유 수량 값  업데이트
    private func update(entity: PortfolioEntity, amunt: Double) {
        entity.amount = amunt
        applyChange()
    }
    //MARK:  - 보유 수량 값  삭제
    private func removePortfolio(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChange()
    }
    
    //MARK:  - 코어 데이터에 저장하기
    private func savePortfolio() {
        do {
            try container.viewContext.save()
        } catch let error {
            debugPrint("Error saving to Core Data . \(error.localizedDescription)")
        }
    }
    //MARK:  - 저장한 값 적용
    private func applyChange() {
        savePortfolio()
        getPortfolio()
    }
    
}
