# TossSecuritiesStockCloneAPP
토스 증권 클론 및 앱 출시 예정 프로젝트  
 

## Projects
## 초보자들을 위한 주식앱 및 NFT 마켓 앱 앱 출시 계획 
🗓 프로젝트 소개 : 초보자들을 위한 주식앱 !</br>
🗓 기간 : 2022.08.03 ~   </br>
🗓 팀원: [로이](https://github.com/Roy-wonji) ,[성현](https://github.com/seonghyeonOrNot)</br>
🗓 리뷰어:  [리아]("https://github.com/Lia316") , [리이오]("https://github.com/M1zz")

## 디자인
- [피그마디자인](https://www.figma.com/file/zR1dKPOlDJUMRL2PRlUD3A/ios%EA%B0%9C%EB%B0%9C%ED%81%B4%EB%9F%BD%3A%EA%B3%B5%EB%B6%80%EA%B0%80%EB%8B%B5%EC%9D%B4%EB%8B%A4?node-id=0%3A1)

## 앱아이콘 

##  앱 UI

## 사용한 라이브러리
- `Alamofire` , `Kingfisher` , `SwiftLint`

## 사용한 api
- [코인 게코](https://www.coingecko.com/ko)

## 사용할 협업툴 
- `jira` , `Notion` , `Figma`

## 디자인 패턴 #
- MVVM 패턴 

## 키워드 
- `@published`
- `@State`
- `Combine`
- `tabView`
- `코인 단위`
- `커스텀 폰트`
- `커스텀 컬러`
- `LIST VIEW`
- `extension view`
- `url session 통신`
- `FILEMANGER`
- `Search bar`
- `Core data`


### 폴더링
 <img src = "https://i.imgur.com/alds38X.png" width="30%"> 

## Step1 에서 구현 내용 

- 코인 리스트 생성 
- 코인 시세 가져오기
- 코인 인기 시세 확인
- 커스텀 색상 및  폰트 파일 생성해서 구현 
- 최대한 뷰를 쪼개서 구현 
- 검색창 구현 
- 자신이 보유 하고있는 코인 설정
- 카카오 로그인 구현
- 애플 로그인 구현 
- CoreData로 코인 보유 수량 저장
- FILEMANGER 로 코인 로고 파일 다운로드

## 네트워크 통신

> 코인 관련시세 및 코인 변화율 및 코인 로고 다운로드를 위해  json 및 urlSession 으로 json 방식으로 데이터 통신을 위해 네트워크통신을 사용해서 구현 
> 마케 시세 및 보유 한 코인데이터 네트워크 구현 

```swift
import Combine
import Alamofire

class CoinDataService {
    
    @Published var allcoins:  [CoinModel] = [ ]  //allcoin을  통해서 접근해서 사용
    var cancellabels = Set<AnyCancellable>()    // 구독 취소 하는 변수
    
    var coinSubscription: AnyCancellable?
    
     init() {
        getCoins()
    }
    
    //MARK:  - 데이터 통신 부분
    private func getCoins() {
        guard let url = URL(string: URLManger.coinUrl) else { return }
        
        coinSubscription =   NetworkingManger.downloadUrl(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion,
                  receiveValue: {  [weak self] (returnedCoins) in
                self?.allcoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}

```

```swift
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription : AnyCancellable?
    private let coin: CoinModel
    
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    //MARK: - 코인 이미지 다운로드 

    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription =   NetworkingManger.downloadUrl(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManger.handleCompletion,
                  receiveValue: {  [weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}

```

```swift
import Foundation
import Combine

class CoinMarketDataService {
    
    @Published var marketData:  MarketDataModel? = nil           //allcoin을  통해서 접근해서 사용
    var marketCoinSubscription: AnyCancellable?                  //구독 취소 하는 변수
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: URLManger.coinMartURL) else { return }
     
        marketCoinSubscription =   NetworkingManger.downloadUrl(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion,
                  receiveValue: {  [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketCoinSubscription?.cancel()
            })
        
    }
}

```

```swift
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

```

### viewModel 구현 

> 코인 데이터 및 코인 이미지를 viewmodel 에서 전달을 해서 이미지 다운로드및 데이터 전달 하는 형식으로 viewmodel 을 구현을 했습니다 

```swift
import Foundation
import Combine

// ObservableObject 로 뷰를 관찰및 접근
class CoinViewModel: ObservableObject {
    
    @Published var statistic: [StatisticModel] = [ ]
    
    
    @Published var allCoins: [CoinModel] = [ ]
    @Published var profilioCoins : [CoinModel] =  [ ]
    @Published var searchText: String = "" // 검색 관련
    
    private let coinDataService = CoinDataService()                    // 코인 데이터 서비스 변수
    private let marketDataService = CoinMarketDataService()
    private let portfolioDataService = PortfolioDataService()   //  보유 수량 데이터 서비스
    private var cancelables = Set <AnyCancellable>()                  // 구독 취소하는 변수
    
    //MARK:  - 데이터 받아 오기전 초기화
    init() {
        addSubscribers()
    }
    
    //MARK:  - 데이터 통신 하는부분
    func addSubscribers() {
        //MARK:  - update allcoins
        $searchText
            .combineLatest(coinDataService.$allcoins)        //데이터 서비스에서 모든 코인을 수신하면
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)      // 빠르게 입력할때  0.5 초동안  지연
            .map(fillterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
        
        //MARK: - 마켓 데이터 업데이트
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistic = returnedStats
            }
            .store(in: &cancelables)
        
        //MARK:  - 보유 수량 데이터 업데이트
        $allCoins
            .combineLatest(portfolioDataService.$savedEntites)
            .map { (coinModels, portfolioEntites)  ->  [CoinModel] in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntites.first(where:  {$0.coinId == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] (returnedCoin) in
                self?.profilioCoins = returnedCoin
            }
            .store(in: &cancelables)
        
    }
    //MARK: - 보유 수량 update
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    //MARK: - 검색창 필터
    private func fillterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        // 텍스트 대문자 또는 소문자로 입력 하면 인식
        let lowerCasedText = text.lowercased()
        return coins.filter { (coin)  -> Bool in
            return coin.name.lowercased().contains(lowerCasedText) ||
            coin.symbol.lowercased().contains(lowerCasedText) ||
            coin.id.lowercased().contains(lowerCasedText)
        }
    }
    //MARK: - 마켓 데이터
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = [ ]
        
        guard let data = marketDataModel else {
            return stats
        }
        //MARK: - 마켓 cap
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,
                                       percentageChange: data.marketCapChangePercentage24HUsd)
        //MARK: - 24시간 코인 시세
        let volume = StatisticModel(title: "24시간  코인 시세", value: data.volume)
        //MARK: - 비트 코인 시세
        let btcDomainance = StatisticModel(title: "비트코인 시세", value: data.btcDominance)
        //MARK: - 보유 수량
        let portfolio = StatisticModel(title: "보유 수량 ", value: "0.00", percentageChange: .zero)
        //MARK:- StatisticModel에 append
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDomainance,
            portfolio
        ])
        return stats
    }
}
```

```swift
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    @Published var isLodaingImage: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancelables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
    }
    
    //MARK:  - 코인이미지 다운로드 받은걸 viewmodel로 사용 

    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLodaingImage = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancelables)

    }
}
```

### Filemanger 로 코인이미지 다운로드

```swift
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

```

## 컬러및 폰트 공용 

```swift

import SwiftUI

struct ColorAsset {
    let mainColor = Color("MainColor")
    let subColor = Color("MainColor2")
    let black = Color("Black")
    let blue = Color("Blue")
    let blue2 = Color("Blue2")
    let blue3 = Color("Blue3")
    let blue4 = Color("Blue4")
    let lightBlue = Color("LightBlue")
    let green = Color("GreenColor")
    let lightgreen  = Color("LightGreen")
    let lightgreen2  = Color("LightGreen2")
    let red = Color("RedColor")
    let lightRed = Color("LightRed")
    let mauvepurple = Color("Mauve")
    let mauvepurple2 = Color("Mauve2")
    let mauvepurple3 = Color("Mauve3")
    let navy = Color("Navy")
    let navy2 = Color("Navy2")
    let navy3 = Color("Navy3")
    let pink = Color("Pink")
    let skyblue = Color("Skyblue")
    let skyblue2 = Color("Skyblue2")
    let white = Color("White")
    let white2 = Color("White2")
    let textColor = Color("SecondaryTextColor")
    let backGroundColor = Color("BackgroundColor")
}

extension Color {
    static let colorAssets = ColorAsset()
}

```

```swift
struct FontAsset {
    static let boldFont: String = "SpoqaHanSansNeo-Bold"
    static let lightFont: String = "SpoqaHanSansNeo-Light"
    static let mediumFont: String = "SpoqaHanSansNeo-Medium"
    static let regularFont: String = "SpoqaHanSansNeo-Regular"
    static let thinFont: String = "SpoqaHanSansNeo-Thin"
}
```


## Commit 규칙
> 커밋 제목은 최대 50자 입력 </br>
본문은 한 줄 최대 72자 입력 </br>
Commit 메세지 </br>

🪛[chore]: 코드 수정, 내부 파일 수정. </br>
✨[feat]: 새로운 기능 구현. </br>
🎨[style]: 스타일 관련 기능.(코드의 구조/형태 개선) </br>
➕[add]: Feat 이외의 부수적인 코드 추가, 라이브러리 추가 </br>
🔧[file]: 새로운 파일 생성, 삭제 시 </br>
🐛[fix]: 버그, 오류 해결. </br>
🔥[del]: 쓸모없는 코드/파일 삭제. </br>
📝[docs]: README나 WIKI 등의 문서 개정. </br>
💄[mod]: storyboard 파일,UI 수정한 경우. </br>
✏️[correct]: 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다. </br>
🚚[move]: 프로젝트 내 파일이나 코드(리소스)의 이동. </br>
⏪️[rename]: 파일 이름 변경이 있을 때 사용합니다. </br>
⚡️[improve]: 향상이 있을 때 사용합니다. </br>
♻️[refactor]: 전면 수정이 있을 때 사용합니다. </br>
🔀[merge]: 다른브렌치를 merge 할 때 사용합니다. </br>
✅ [test]: 테스트 코드를 작성할 때 사용합니다. </br>

### Commit Body 규칙
> 제목 끝에 마침표(.) 금지 </br>
한글로 작성 </br>
브랜치 이름 규칙

- `STEP1`, `STEP2`, `STEP3`

### Git flow
- `main` 브랜 치는 앱 출시 
- `Dev`는 테스트 및 각종 파일 merge
- 각 스텝 뱔로 브런치 생성해서 관리 


