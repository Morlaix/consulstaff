//
//  StockViewController.swift
//  KrasamoStockTracker
//
//  Created by Antonio Mayorga on 2/5/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet weak var stockSymbolPopupView: UIView!
    @IBOutlet weak var dismissPopupButton: UIButton!
    @IBOutlet weak var stockPopupOkButton: UIButton!
    @IBOutlet weak var stockPopupLabel: UILabel!
    @IBOutlet weak var stockPopupTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let refresher = UIRefreshControl()
    let dataSource = StockDataSource()
    let iexNetworkClient = IEXClient()
    
    @IBAction func showStockSymbolPopup(_ sender: UIBarButtonItem) {
        configurePopup()
    }
    
    @IBAction func dismissStockSymbolPopup(_ sender: UIButton) {
        dismissPopup()
    }
    
    fileprivate func configurePopup() {
        stockPopupLabel.text = "New Stock Symbol"
        dismissPopupButton.isEnabled = true
        stockPopupTextField.isHidden = false
        activityIndicator.stopAnimating()
        
        UIView.animate(withDuration: 0.3) {
            self.stockSymbolPopupView.alpha = 1.0
        }
    }
    
    fileprivate func dismissPopup() {
        stockPopupTextField.text = ""
        dismissPopupButton.isEnabled = false
        stockPopupTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.3) {
            self.stockSymbolPopupView.alpha = 0.0
        }
    }
    
    func showError(withMessage message: String) {
        configurePopup()
        stockPopupLabel.text = message
        stockPopupTextField.isHidden = true
    }
    
    @IBAction func addStockTracker(_ sender: UIBarButtonItem) {
        guard let stockSymbol = stockPopupTextField.text else {
            return
        }
        
        if dataSource.checkIfDuplicatedSymbol(stockSymbol) {
            dismissPopup()
            return
        }
        
        if !stockSymbol.isEmpty {
            getStock(WithSymbol: stockSymbol)
 