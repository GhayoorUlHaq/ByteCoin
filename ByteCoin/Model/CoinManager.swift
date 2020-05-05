//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate {
    func didCoinUpdate(_ coinManager: CoinManager, currency: String)
    func didFailWithError(error: Error)
}
struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)?apikey=\(apiKey)"
        
        // Create URL
        if let url = URL(string: urlString){
            // Create URL Session
            let session = URLSession(configuration: .default)
            // Assign session a task
            let task = session.dataTask(with: url, completionHandler: {data, response, error in
                if let e = error {
                    self.delegate?.didFailWithError(error: e)
                    return
                }
                
                if let safeData = data {
                    if let array = self.parseJSON(safeData){
                        for i in 0...array.count {
                            if array[i].asset_id_quote == currency {
                                self.delegate?.didCoinUpdate(self, currency: String(format: "%.3f", array[i].rate))
                                break
                            }
                        }
                    }
                }
                
            })
            // Resume Task
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> [Items]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinDataParse.self, from: coinData)
            let rates = decodedData.rates
            return rates
            
        } catch {
            delegate?.didFailWithError(error: error)
                return nil
        }
        
    }
    
}
