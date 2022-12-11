//
//  StockSymbol.swift
//  StockApp
//
//  Created by 서원지 on 2022/11/23.
//

import Foundation

enum StockSymbol: Int , CaseIterable, CustomStringConvertible {
    case nsdSymbol
    case newyorkSymbol
    case nsdSymbolBest5
    case newyorkSymbolBest5
    
    var description: String {
        switch self {
        case .nsdSymbol:
            return "AAPL,MS,GOOG,GOOGL,AMZN,TSLA,NVDA,META,PEP,ASML,COST,AVGO,AZN,CSCO,TMUS,TXN,AMGN,ADBE,CMCSA,HON,QCOM,NFLX,INTC,AMD,SBUX"
        case .newyorkSymbol:
            return "UNH,XOM,JNJ,V,TSM,WMT,JPM,CVX,SPY,PG,LLY,HD,MA,BAC,ABBV,PFE,MRK,KO,NVO,IVV,ORCL,TMO,BABA,SHEL"
        case .nsdSymbolBest5:
            return "AAPL,MS,GOOG,GOOGL,AMZN,TSLA,NVDA"
        case .newyorkSymbolBest5:
            return "UNH,XOM,JNJ,V,TSM,WMT,JPM"
        }
        
    }
    
}
