//
//  ViewController.swift
//  byteCoin
//
//  Created by Sebastian Malm on 3/1/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit

class ByteCoinViewController: UIViewController {
    
    // MARK: - Properties
    
    let currencyModel = CurrencyModel()
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var resultBackgroundView: UIView! { didSet {
        resultBackgroundView.layer.cornerRadius = resultBackgroundView.frame.height / 2
    }}
    
    // MARK: - Methods

    override func viewDidLoad() {
        currencyPicker.delegate = self
        currencyPicker.dataSource = currencyModel
    }
}

extension ByteCoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        assert(row <= currencyModel.currencies.count, "Not enough currencies for picker rows")
        return currencyModel.currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        assert(row <= currencyModel.currencies.count, "No currency for selected picker row")
        currencyLabel.text = currencyModel.currencies[row]
    }
}
