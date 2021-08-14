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
    let latestUpdate: Int?
    let latestVolume: Int?
    let iexRealtimePrice: Float?
    let iexRealtimeSize: Float?
    let iexLastUpdated: Int?
    let delayedPrice: Float?
    let delayedPriceTime: Int?
    let extendedPrice: Float?
    let extendedChange: Float?
    let extendedChangePercent: Float?
    let extendedPriceTime: Int?
    let previousClose: Float?
    let change: Float?
    let changePercent: Float?
    let iexMarketPercent: Float?
    let iexVolume: Int?
    let avgTotalVolume: Int?
    let iexBidPrice: Float?
    let iexBidSize: Float?
    let iexAskPrice: Float?
    let iexAskSize: Int?
    let marketCap: Float?
    let peRatio: Float?
    