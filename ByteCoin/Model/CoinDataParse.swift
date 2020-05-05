//
//  CoinDataParse.swift
//  ByteCoin
//
//  Created by Ghayoor ul Haq on 05/05/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinDataParse: Decodable {
    let rates: [Items]
    
}

struct Items: Decodable {
    let time: String
    let asset_id_quote: String
    let rate: Double
}
