//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CoinManagerDelegate {

    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        coinManager.delegate = self
//        currencyPicker.dataSource = UIPickerViewDataSource
    }
    
    func didCoinUpdate(_ coinManager: CoinManager, currency: String) {
        DispatchQueue.main.async {
            self.bitCoinLabel.text = currency
        }
        
    }

    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
                   self.bitCoinLabel.text = "Error loading rates for "
               }
    }
    
}

 //MARK: - UIPickerDelegateMethods
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let curreny = coinManager.currencyArray[row]
        DispatchQueue.main.async {
            self.currencyLabel.text = curreny
            self.bitCoinLabel.text = "loading..."
        }
        coinManager.getCoinPrice(for: curreny)
    }
    
    // return displays number of columns in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    
    // return return rows in components
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

