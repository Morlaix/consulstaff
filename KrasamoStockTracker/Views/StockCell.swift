//
//  StockTrackerTableViewCell.swift
//  KrasamoStockTracker
//
//  Created by Antonio Mayorga on 2/5/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {

    @IBOutlet weak var stockSymbol: UILabel!
    @IBOutlet weak var currentStockPrice: UILabel!
    @IBOutlet weak var maximumStockPrice: UILabel!
    @IBOutlet weak var 