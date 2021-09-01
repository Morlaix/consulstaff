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
            
            self.convertData(data, completion: { (result, error) in
                guard error == nil else {
                    sendError("Error converting stock data into readable format.")
                    return
                }
                
                guard let quote = result  else {
                    sendError("Couldn't convert stock data to readable format.")
                    return
                }
                
                completion(quote, nil)
            })
        }
        
        urlTask.resume()
    }
    
    func convertData(_ data: Data, completion: (_ result: Quote?, _ error: NSError?) -> Void) {
        
        var quote: Quote
        
        do {
            let decoder = JSONDecoder()
            quote = try decoder.decode(Quote.self, from: data)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey: "Could not parse the data into encodable format"]
            completion(nil, NSError(domain: "convertData", code: 1, userInfo: userInfo))
            return
        }
        
        completion(quote, nil)
 