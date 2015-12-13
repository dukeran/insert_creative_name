//
//  SettingsViewController.swift
//  tips
//
//  Created by Quottly on 12/12/15.
//  Copyright © 2015 dukeran. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var tip_control: UISegmentedControl!
    
        var tip_percentage_index:Int!
        let defaults = NSUserDefaults.standardUserDefaults()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tip_control.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
        }
        
        @IBAction func onEditing(sender: AnyObject) {
            tip_percentage_index = tip_control.selectedSegmentIndex
        }
        
        @IBAction func save_tip_percentage(sender: AnyObject) {
            tip_percentage_index = tip_control.selectedSegmentIndex
            defaults.setInteger(tip_percentage_index, forKey: "default_tip_index")
            defaults.synchronize()
            if let navigationController = self.navigationController
            {
                navigationController.popViewControllerAnimated(true)
            }
   
        
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
}