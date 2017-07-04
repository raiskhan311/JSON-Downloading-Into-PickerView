//
//  ViewController.swift
//  JSON Downloading Into PickerView
//
//  Created by APPLE on 04/07/17.
//  Copyright © 2017 rsku. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var selectionArray = [String]()
    
    @IBOutlet weak var view_ContainerView: UIView!
    
    @IBOutlet weak var view_PickerView: UIPickerView!
    
    @IBOutlet weak var activity1: UIActivityIndicatorView!
    
    @IBOutlet weak var activity2: UIActivityIndicatorView!

    @IBOutlet weak var lbl_ShowSelectItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        activity1.isHidden = true  // to hide Activity idicator
        activity2.isHidden = true  // to hide Activity idicator
        
        activity1.startAnimating()
        activity2.startAnimating()
        
        self.view_ContainerView.alpha = 0
    }
    
    
    //Mark: - Actions of buttons
    
    @IBAction func btn_ChooseDays(_ sender: Any) {
        let urlString = "http://localhost:3000/DayofWeek"
        let url = URL(string: urlString)
        guard let validUrl = url else {return}
        activity1.isHidden = false  // to show Activity idicator
        WebManager.downloadJson(from: validUrl) { (resArray) in
            self.activity1.isHidden = true // to hide Activity idicator
            print(resArray)  // print DayofWeek
            self.selectionArray = resArray // assign resArray into selectionArray
            
            self.view_PickerView.delegate = self
            self.view_PickerView.dataSource = self
            
            self.animateShowingPickerView()
        }
    }

    @IBAction func btn_ChooseLocation(_ sender: Any) {
        let urlString = "http://localhost:3000/Location"
        let url = URL(string: urlString)
        guard let validUrl = url else {return}
        activity2.isHidden = false
        WebManager.downloadJson(from: validUrl) { (resArray) in
            self.activity2.isHidden = true
            print(resArray)  // print DayofWeek
            self.selectionArray = resArray // assign resArray into selectionArray
            
            self.view_PickerView.dataSource = self
            self.view_PickerView.delegate = self
            
            self.animateShowingPickerView()
        }
    }

    @IBAction func btn_SelectItems(_ sender: Any) {
        lbl_ShowSelectItem.text = selectionArray[view_PickerView.selectedRow(inComponent: 0)]
        self.animateHidingPickerView()  
    }
    
    //Mark :- UIPickerview DATASource
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return selectionArray.count
    }
    
    //Mark:- UIPickerView Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return selectionArray[row]
    }
    
    //Mark: - animations
    
    func animateHidingPickerView(){
        UIView.animate(withDuration: 1) {
            self.view_ContainerView.alpha = 0
        }
    }
    
    func animateShowingPickerView(){
        UIView.animate(withDuration: 1) {
            self.view_ContainerView.alpha = 1
        }
    }

}

// WebServices class

class WebManager{
    
    class func downloadJson(from url: URL, completion:@escaping ([String])-> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    completion([])
                }else{
                    guard let data = data else{
                        completion([])
                        return
                    }
                    let obj = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                    guard let resArray = obj as? [String] else{
                        completion([])
                        return
                    }
                    completion(resArray)
                }
            }
        }.resume()
    }
}

