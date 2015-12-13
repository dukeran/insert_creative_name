//
//  ViewController.swift
//  tips
//
//  Created by Quottly on 12/10/15.
//  Copyright © 2015 dukeran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  
    
    @IBOutlet weak var tip_control: UISegmentedControl!
    @IBOutlet weak var split_bill_control: UISegmentedControl!
    @IBOutlet weak var bill_field: UITextField!
    @IBOutlet weak var total_label: UILabel!
    @IBOutlet weak var tip_label: UILabel!
    @IBOutlet weak var per_person_label: UILabel!
    @IBOutlet weak var per_person_field: UILabel!
    let defaults = NSUserDefaults.standardUserDefaults()
    let formatter = NSNumberFormatter()
    
    func zeroOutFields(){
        formatter.numberStyle = .CurrencyStyle
        if tip_label != nil {
            tip_label.text = formatter.stringFromNumber(0)
        }
        if total_label != nil {
            total_label.text = formatter.stringFromNumber(0)
        }
        if bill_field != nil {
            bill_field.text = ""
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        UIView.animateWithDuration(1, animations: {
            self.tip_label.alpha = 1
            
        })
        
        UIView.animateWithDuration(1, animations: {
            self.total_label.alpha = 1
            
        })
        
    }

        override func viewDidLoad() {
        super.viewDidLoad()
            
        defaults.synchronize()
            per_person_field.hidden = true
            per_person_label.hidden = true
            
            tip_control.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
            if defaults.objectForKey("billTimestamp") != nil {
                var bill_amount = defaults.doubleForKey("billAmount")
                bill_field.text = NSString(format: "%.2f", bill_amount) as String
                tip_label.text = defaults.objectForKey("tipLabelText") as? String
                total_label.text = defaults.objectForKey("totalLabelText") as? String
            } else {
                zeroOutFields()
            }
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "willEnterForeground:", name: UIApplicationDidBecomeActiveNotification, object: nil)
    
            
            tip_label.text = "$0.00"
            total_label.text = "$0.00"
            per_person_field.text = "$0.00"
        
            self.tip_label.alpha = 0
    
            self.total_label.alpha = 0
   
        }
    
    func willEnterForeground(notification: NSNotification!){
        // check if billAmount was entered in last 20 seconds
        var currentTime = NSDate()
        var lastChanged: NSDate!
        if defaults.objectForKey("billTimestamp") != nil {
            lastChanged = defaults.objectForKey("billTimestamp") as! NSDate
            // time interval in seconds since bill Amount was entered
            let interval = currentTime.timeIntervalSinceDate(lastChanged)
            if interval > 20 {
                zeroOutFields()
            }
        }
        
    }
    
    deinit {
        // make sure to remove the observer when this view controller is dismissed/deallocated
        NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func on_editing_change(sender: AnyObject) {
        var tip_percentages = [0.18, 0.2, 0.22]
        let tip_percentage = tip_percentages[tip_control.selectedSegmentIndex]
            
        var split_bill_nums = [1, 2, 3, 4]
        var split_bill_num = split_bill_nums[split_bill_control.selectedSegmentIndex]
       
            
        var bill_amount = NSString(string: bill_field.text!).doubleValue
        var tip = bill_amount * tip_percentage
        var total = bill_amount + tip
        var per_person_amount = total / Double(split_bill_num)
        
        tip_label.text = "$\(tip)"
        total_label.text = "$\(total)"
        
        tip_label.text = String( format: "$%.2f", tip)
        
        total_label.text = String( format: "$%.2f", total)
        
        
        // save most recent time fields were edited, as well as values
        // this will be checked on viewDidLoad, and most recent values will be loaded if less
        // than a certain amount of time has elapsed.
        var timeChanged = NSDate()
        defaults.setObject(timeChanged, forKey: "billTimestamp")
        defaults.setDouble(bill_amount, forKey: "billAmount")
        defaults.setObject(tip_label.text, forKey: "tipLabelText")
        defaults.setObject(total_label.text, forKey: "totalLabelText")
        defaults.synchronize()
    
            if(split_bill_num > 1){
                per_person_field.hidden = false
                per_person_label.hidden = false
                per_person_field.text = formatter.stringFromNumber(per_person_amount)
            }else{
                per_person_field.hidden = true
                per_person_label.hidden = true
            }
            
            
    }
    
    @IBAction func on_tap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
}
