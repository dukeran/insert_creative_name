//
//  SettingsViewController.swift
//  tips
//
//  Created by Quottly on 12/12/15.
//  Copyright © 2015 dukeran. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setInteger(1, forKey: "default_tip_amount")
    defaults.synchronize()

    let intValue = defaults.integerForKey("default_tip_amount")

    
    }
}
