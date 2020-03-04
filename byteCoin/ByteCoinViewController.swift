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
    
    var conversionManager = ConversionManager()
    var allRates = [String: Double]() { didSet {
        DispatchQueue.main.async {
            self.currencyPicker.reloadComponent(0)
        }
    }}
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var resultBackgroundView: UIView! { didSet {
        resultBackgroundView.layer.cornerRadius = resultBackgroundView.frame.height / 2
    }}
    
    // MARK: - Methods

    override func viewDidLoad() {
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        conversionManager.delegate = self
        conversionManager.fetchAllRates()
    }
}

extension ByteCoinViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allRates.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let allCurrencyKeys = Array(allRates.keys)
        assert(allCurrencyKeys.count == pickerView.numberOfRows(inComponent: 0), "Number of picker rows doesn't match currency count")
        if component == 0 {
            return allCurrencyKeys[row]
        } else {
            return "?"
        }
    }
}

extension ByteCoinViewController: ConversionManagerDelegate {
    func didGetRates(_ conversionManager: ConversionManager, rates: [String : Double]) {
        allRates = rates
    }
    
    func didFailWithError(_ conversionManager: ConversionManager, error: ConversionManagerError) {
        print(error)
    }
    
    
}
