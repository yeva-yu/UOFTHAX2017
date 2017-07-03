//
//  ViewController.swift
//  Akcess
//
//  Created by Francois Gouelo on 2017-01-21.
//  Copyright © 2017 Francois Gouelo. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, AgreementViewDelegate, UIPopoverControllerDelegate {
    @IBOutlet weak var Location: UIPickerView!
    

    @IBAction func EnterButton(_ sender: UIButton) {


        let vc = (
            storyboard?.instantiateViewController(
                withIdentifier: "AgreementViewController")
            )! as! AgreementViewController
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return false
    }


    func didAcceptAgreement() {
        if let vc = ( storyboard?.instantiateViewController(withIdentifier: "SecondViewController"))! as? SecondViewController {
            present(vc, animated: true, completion: nil)
        }
    }
    
    var Array = ["Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador", "Nothwest Territories", "Nova Scotia", "Nunavut", "Ontario", "Prince Edward Island", "Quebec", "Saskatchewan", "Yukon"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        Location.delegate = self
        Location.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }

}

