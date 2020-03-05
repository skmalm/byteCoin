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
    
    private var conversionManager = ConversionManager()
    private var allRates = [String: Double]() { didSet {
        DispatchQueue.main.async {
            self.currencyPicker.reloadComponent(0)
            if let usdRow = self.allRates.keys.sorted().firstIndex(of: "USD") {
                assert(self.currencyPicker.numberOfRows(inComponent: 0) == self.allRates.count, "Picker row count doesn't match allRates count")
                self.currencyPicker.selectRow(usdRow, inComponent: 0, animated: true)
                self.currencyPicker.delegate?.pickerView?(self.currencyPicker, didSelectRow: usdRow, inComponent: 0)
            }
            self.currencyPicker.isUserInteractionEnabled = true
        }
    }}
    
    @IBOutlet weak private var resultLabel: UILabel!
    @IBOutlet weak private var currencyLabel: UILabel!
    @IBOutlet weak private var currencyPicker: UIPickerView!
    @IBOutlet weak private var resultBackgroundView: UIView! { didSet {
        resultBackgroundView.layer.cornerRadius = resultBackgroundView.frame.height / 2
    }}
    
    // MARK: - Methods

    override func viewDidLoad() {
        currencyPicker.isUserInteractionEnabled = false
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
        let allCurrencyKeysSorted = allRates.keys.sorted()
        assert(allCurrencyKeysSorted.count == pickerView.numberOfRows(inComponent: 0), "Number of picker rows doesn't match currency count")
        return allCurrencyKeysSorted[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let allCurrencyKeysSorted = allRates.keys.sorted()
        assert(allCurrencyKeysSorted.count == pickerView.numberOfRows(inComponent: 0), "Number of picker rows doesn't match currency count")
        let currencyString = allCurrencyKeysSorted[row]
        currencyLabel.text = currencyString
        if let value = allRates[currencyString] {
            resultLabel.text = String(format: "%.2f", value)
        }
    }
}

extension ByteCoinViewController: ConversionManagerDelegate {
    func didGetRates(_ conversionManager: ConversionManager, rates: [String : Double]) {
        allRates = rates
        URLSession.shared.invalidateAndCancel()
    }
    
    func didFailWithError(_ conversionManager: ConversionManager, error: ConversionManagerError) {
        print(error)
        URLSession.shared.invalidateAndCancel()
    }
    
    
}
