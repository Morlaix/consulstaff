//
//  Quote.swift
//  KrasamoStockTracker
//
//  Created by Antonio Mayorga on 2/5/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import Foundation

struct Quote: Decodable {
    let symbol: String?
    let companyName: String?
    let primaryExchange: String?
    let sector: String?
    let calculationPrice: String?
    let open: Float?
    let openTime: Int?
    let close: Float?
    let closeTime: Int?
    let high: Float?
    let low: Float?
    let latestPrice: Float?
    let latestSource: String?
    let latestTime: String?
    let latestU