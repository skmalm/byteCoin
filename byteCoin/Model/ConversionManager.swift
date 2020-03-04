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
    var delegate: ConversionManagerDelegate?
    
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
                if let conversionModel = self.parseJSON(exchangeRateData: data!) {
                    self.delegate?.didGetRates(self, rates: conversionModel.rates)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON( exchangeRateData: Data) -> ConversionModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ConversionData.self, from: exchangeRateData)
            return ConversionModel(fromConversionData: decodedData)
        } catch {
            delegate?.didFailWithError(self, error: .decodingError(error))
            return nil
        }
    }
}

protocol ConversionManagerDelegate {
    func didGetRates(_ conversionManager: ConversionManager, rates: [String: Double])
    func didFailWithError(_ conversionManager: ConversionManager, error: ConversionManagerError)
}

enum ConversionManagerError: Error {
    case decodingError(Error)
}

// MARK: - Sample API Call

/*
 curl https://rest.coinapi.io/v1/exchangerate/BTC?invert=false \
 --request GET
 --header "X-CoinAPI-Key: 73034021-THIS-IS-SAMPLE-KEY"
 */
