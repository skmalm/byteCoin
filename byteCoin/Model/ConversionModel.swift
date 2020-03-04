//
//  CurrencyModel.swift
//  byteCoin
//
//  Created by Sebastian Malm on 3/3/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit

class ConversionModel: NSObject {
    
    var rates = [String: Double]()
    
    init(fromConversionData conversionData: ConversionData) {
        for fullRate in conversionData.rates {
            rates[fullRate.asset_id_quote] = fullRate.rate
        }
    }
}
