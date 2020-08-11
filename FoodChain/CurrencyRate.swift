//
//  CurrencyRate.swift
//  FoodChain
//
//  Created by Harsh Verma on 10/07/20.
//  Copyright © 2020 Harsh Verma. All rights reserved.
//

import Foundation
class CurrencyRate {
    
    var dollarPerBTC = 0.0
    var poundPerBTC = 0.0
    var euroPerBTC = 0.0
    
    private struct USDStruct: Codable {
        var rate_float: Double
    }
    
    private struct GBPStruct: Codable {
        var rate_float: Double
    }
    
    private struct EURStruct: Codable {
        var rate_float: Double
    }
    
    private struct BPI: Codable {
        var USD: USDStruct
        var GBP: GBPStruct
        var EUR: EURStruct
    }
    
    private struct Result: Codable {
        var bpi: BPI
    }
    
    func getData(completed: @escaping() -> ()) {
        
        let urlStr = "http://api.coindesk.com/v1/bpi/currentprice.json"
        print("Accessing the URL Now😃")
        guard let url = URL(string: urlStr) else {
            print("🥵Error: Can't Create a URL from \(urlStr)")
            completed()
            return
        }
        // Session creation
        let session = URLSession.shared
        
        // Obtaining data from .dataTask Method
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let ER = error {
                print(ER.localizedDescription)
            }
            
            // Exception handler
            do {
                let R = try JSONDecoder().decode(Result.self, from: data!)
                print("** result is \(R.bpi.USD.rate_float), \(R.bpi.GBP.rate_float), \(R.bpi.EUR.rate_float)")
                self.dollarPerBTC = R.bpi.USD.rate_float
                self.poundPerBTC = R.bpi.GBP.rate_float
                self.euroPerBTC = R.bpi.EUR.rate_float
            }
            catch {
                print("Error: Failed to decode JSON \(error.localizedDescription)")
            }
            completed()
            
        }
        
        task.resume()
        
    }
    
}
