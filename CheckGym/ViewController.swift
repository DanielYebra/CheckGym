//
//  ViewController.swift
//  CheckGym
//
//  Created by Daniel Yebra on 12/8/17.
//  Copyright © 2017 RoninRise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var pickerKind: UIPickerView!
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var labelPrueba: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerDate.backgroundColor = UIColor.init(red: 0.388, green: 0.835, blue:0.866, alpha: 0.85)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

