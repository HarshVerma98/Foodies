//
//  ViewController.swift
//  FoodChain
//
//  Created by Harsh Verma on 10/07/20.
//  Copyright © 2020 Harsh Verma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BiscuitsLbl: UILabel!
    @IBOutlet weak var ChickenLbl: UILabel!
    @IBOutlet weak var ChipsLbl: UILabel!
    @IBOutlet weak var BiscuitStepper: UIStepper!
    @IBOutlet weak var ChickenStepper: UIStepper!
    @IBOutlet weak var ChipsStepper: UIStepper!
    @IBOutlet weak var dollarTotalLbl: UILabel!
    @IBOutlet weak var bitcoinTotalLbl: UILabel!
    @IBOutlet weak var currencySegment: UISegmentedControl!
    
    var currencyRate = CurrencyRate()
    
    let biscuitPrice = 5.0
    let chickenPrice = 3.0
    let chipsPrice = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyRate.getData {
            print("Success in calling")
        }
    }
    
    func calcTotal() {
        
        let bQty = Double(BiscuitsLbl.text!)
        let ChikQty = Double(ChickenLbl.text!)
        let ChipQty = Double(ChipsLbl.text!)
        
        let dolTotal = (bQty! * biscuitPrice) + (ChikQty! * chickenPrice) + (ChipQty! * chipsPrice)
        var currencyStr = ""
        
        
        let btxTotal = dolTotal / currencyRate.dollarPerBTC
        bitcoinTotalLbl.text = "฿ \(btxTotal)"
        
        switch currencySegment.selectedSegmentIndex {
        case 0:
            currencyStr = String(format: "$%.02f", dolTotal)
        case 1:
            let poundTotal = dolTotal * (currencyRate.poundPerBTC / currencyRate.dollarPerBTC)
            currencyStr = String(format: "£%.02f", poundTotal)
        case 2:
            let euroTotal = dolTotal * (currencyRate.euroPerBTC / currencyRate.dollarPerBTC)
            currencyStr = String(format: "̐EURO%.02f", euroTotal)
        default:
            print("ERROR:")
        }
        dollarTotalLbl.text = currencyStr
        
        
    }
    
    
    @IBAction func biscuitPressed(_ sender: UIStepper) {
        
        BiscuitsLbl.text = "\(Int(sender.value))"
        calcTotal()
    }
    
    @IBAction func chickenPressed(_ sender: UIStepper) {
        
        ChickenLbl.text = "\(Int(sender.value))"
        calcTotal()
        
    }
    @IBAction func chipsPressed(_ sender: UIStepper) {
        
        ChipsLbl.text = "\(Int(sender.value))"
        calcTotal()
        
    }
    @IBAction func currSegPressed(_ sender: UISegmentedControl) {
        calcTotal()
    }
}

