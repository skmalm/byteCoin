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
    
    @IBOutlet weak var resultBackgroundView: UIView! { didSet {
        resultBackgroundView.layer.cornerRadius = resultBackgroundView.frame.height / 2
    }}
    
}

