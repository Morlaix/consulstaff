//
//  IEXClient.swift
//  KrasamoStockTracker
//
//  Created by Antonio Mayorga on 2/5/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import Foundation

class IEXClient {
    
    func getQuote(ForSymbol symbol: String, completion: @escaping(_ quote: Quote?, _ error: Error?) -> Void) {
        
        func sendError(_ error: String) {
            print(error)
            let userInfo = [NSLocalizedDescriptionKey: error]
            completion(nil, NSError(domain: "getQuote", code: 1, userInfo: userInfo))
        }
        
        let request = [IEXConstants.IEXRequest.Stock, "/\(symbol.lowercased()