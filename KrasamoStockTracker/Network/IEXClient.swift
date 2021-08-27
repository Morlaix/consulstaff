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
        
        let request = [IEXConstants.IEXRequest.Stock, "/\(symbol.lowercased())", IEXConstants.IEXRequest.Quote]
        
        guard let url = iexUrlWithUrlRequests(request) else {
            sendError("Invalid URL")
            return
        }
        
        let urlTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                sendError("Could not complete request. Check internet connection and try again.")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("No company symbol found.")
                return
            }
            
            guard let data = data else {
                sendError("No stock data found.")
                return
            }
            
            self.conver