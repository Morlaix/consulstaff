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
        }
        
        dismissPopup()
    }
    
    fileprivate func getStock(WithSymbol symbol: String) {
        activityIndicator.startAnimating()
        
        iexNetworkClient.getQuote(ForSymbol: symbol) { (data, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.showError(withMessage: error!.localizedDescription)
                    return
                }
                
                guard let quote = data else {
                    self.showError(withMessage: "No stock data found.")
                    return
                }
                
                self.dataSource.addStockQuote(quote)
                self.stockTableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc fileprivate func refreshStocks() {
        guard let stockArray = UserDefaults.standard.array(forKey: dataSource.USER_DEFAULT_KEY) else {
            print("No stock symbols in User Defaults")
            return
        }
        
        dataSource.removeAllStockQuotes()
        
        for symbol in stockArray as! [String] {
            getStock(WithSymbol: symbol)
        }
        
        refresher.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let darkGray = UIColor.init(displayP3Red: 35.0/255.0, green: 31.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        
        stockTableView.dataSource = dataSource
        stockTableView.backgroundColor = darkGray
        stockTableView.tableFooterView = UIView()
        
        stockPopupTextField.delegate = self
        stockPopupOkButton.layer.borderWidth = 1.0
        stockPopupOkButton.layer.borderColor = UIColor.white.cgColor
        
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = darkGray
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    
        view.backgroundColor = darkGray
        
        refresher.tintColor = UIColor.white
        refresher.addTarget(self, action: #selector(refreshStocks), f