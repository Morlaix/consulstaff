//
//  StockDataSource.swift
//  KrasamoStockTracker
//
//  Created by Antonio Mayorga on 2/6/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class StockDataSource: NSObject, UITableViewDataSource {
    
    let CELL_REUSE_IDENTIFIER = "stockCell"
    let USER_DEFAULT_KEY      = "stockUserDefaultsArray"
    
    var stockQuotes: [Quote] = [] {
        didSet {
            stockQuotes = stockQuotes.sorted(by: { $0.symbol! < $1.symbol! })
            let stockSymbols = stockQuotes.map({ return $0.symbol })
            UserDefaults.standard.set(stockSy