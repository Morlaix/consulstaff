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
    @IBOutlet weak var minimumStockPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let fontSize: CGFloat = 14.0
        let fontColor = UIColor.white
        
        stockSymbol.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        stockSymbol.textColor = fontColor
        
        currentStockPrice.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        currentStockPrice.textColor = fontColor
        
        maximumStockPrice.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        maximumStockPrice.textColor = fontColor
        
        minimumStockPrice.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        minimumStockPrice.textColor = fontColor
        
        separatorInset.left = 16
        separatorInset.right = 16
        
        self.backgroundColor = UIColor.init(displayP3Red: 35.0/255.0, green: 31.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool,