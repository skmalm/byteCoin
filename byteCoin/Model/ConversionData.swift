//
//  ConversionData.swift
//  byteCoin
//
//  Created by Sebastian Malm on 3/4/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import Foundation

struct ConversionData: Decodable {
    let rates: [FullRate]
}

struct FullRate: Decodable {
    let time: String
    let asset_id_quote: String
    let rate: Double
}

extension ConversionData: CustomStringConvertible {
    var description: String {
        assert(rates.count > 0, "No fullRates were received")
        var outputString = ""
        for fullRate in rates {
            outputString += "\(fullRate.asset_id_quote): \(fullRate.rate)\n"
        }
        return outputString
        }
}
