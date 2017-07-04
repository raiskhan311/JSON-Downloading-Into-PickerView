//
//  ViewController.swift
//  JSON Downloading Into PickerView
//
//  Created by APPLE on 04/07/17.
//  Copyright © 2017 rsku. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var view_ContainerView: UIView!
    
    @IBOutlet weak var view_PickerView: UIPickerView!
    
    @IBOutlet weak var activity1: UIActivityIndicatorView!
    
    @IBOutlet weak var activity2: UIActivityIndicatorView!

    @IBOutlet weak var lbl_ShowSelectItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func btn_ChooseDays(_ sender: Any) {
    }

    @IBAction func btn_ChooseLocation(_ sender: Any) {
    }

    @IBAction func btn_SelectItems(_ sender: Any) {
    }
}

