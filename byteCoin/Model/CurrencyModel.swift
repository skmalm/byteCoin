//
//  CurrencyModel.swift
//  byteCoin
//
//  Created by Sebastian Malm on 3/3/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit

class CurrencyModel: NSObject {
    
    private let currencies = [
        "AUD",
        "BRL",
        "CAD",
        "CNY",
        "EUR",
        "GBP",
        "HKD",
        "IDR",
        "ILS",
        "INR",
        "JPY",
        "MXN",
        "NOK",
        "NZD",
        "PLN",
        "RON",
        "RUB",
        "SEK",
        "SGD",
        "USD",
        "ZAR"
    ]
}

extension CurrencyModel: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        assert(row <= currencies.count, "Not enough currencies for picker rows")
        return currencies[row]
    }
}

extension CurrencyModel: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
}
