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
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var resultBackgroundView: UIView! { didSet {
        resultBackgroundView.layer.cornerRadius = resultBackgroundView.frame.height / 2
    }}
    
    // MARK: - Methods

    override func viewDidLoad() {
        currencyPicker.delegate = currencyModel
        currencyPicker.dataSource = self
    }
}

extension ByteCoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyModel.currencies.count
    }
    
}
