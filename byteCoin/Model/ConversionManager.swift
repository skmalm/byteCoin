//
//  ConversionManager.swift
//  byteCoin
//
//  Created by Sebastian Malm on 3/4/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import Foundation

struct ConversionManager {
    
    // MARK: - Properties
    
    private let endpoint = "https://rest-sandbox.coinapi.io/"
    private let request = "v1/exchangerate/BTC?invert=false"
    
    // MARK: - Methods
    
    func fetchAllRates() {
        let url = URL(string: endpoint + request)
        assert(url != nil, "Error creating URL from urlString")
        var request = URLRequest(url: url!)
        request.addValue(SensitiveConstants.coinAPIKey, forHTTPHeaderField: "X-CoinAPI-Key")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            assert(data != nil, "Error getting data")
            assert(response != nil, "No response from server")
            if let httpResponse = response as? HTTPURLResponse {
                print("Response code: \(httpResponse.statusCode)")
                self.parseJSON(exchangeRateData: data!)
            }
        }
        task.resume()
    }
    
    func parseJSON( exchangeRateData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ConversionData.self, from: exchangeRateData)
            print(decodedData)
        } catch {
            print(error)
        }
    }
}

// MARK: - Sample API Call

/*
 curl https://rest.coinapi.io/v1/exchangerate/BTC?invert=false \
 --request GET
 --header "X-CoinAPI-Key: 73034021-THIS-IS-SAMPLE-KEY"
 */
