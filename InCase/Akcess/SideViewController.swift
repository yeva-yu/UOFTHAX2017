//
//  SideViewController.swift
//  Akcess
//
//  Created by Salman Sharif on 2017-01-22.
//  Copyright © 2017 Francois Gouelo. All rights reserved.
//

import UIKit
import SwiftyJSON

class SideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

//    @IBAction func showImportantInfractions(_sender: Any) {
//        let dataUrl = "https://immense-journey-79536.herokuapp.com/data?keywords="
//
//        if let informationViewController = UIStoryboard(name: "InformationViewController", bundle: nil) as? InformationViewController {
//            informationViewController.inject(title: <#T##String#>, content: <#T##[JSON]#>)
//        }
//    }
//
//    @IBAction func showCarelessInfractions(_sender: Any) {
//        if let informationViewController = UIStoryboard(name: "InformationViewController", bundle: nil) as? InformationViewController {
//            informationViewController.inject(title: <#T##String#>, content: <#T##[JSON]#>)
//        }
//    }

//    @IBAction func showFailureInfractions(_sender: Any) {
//        let dataUrl = "https://immense-journey-79536.herokuapp.com/data?keywords=failure&keywords=driving"
//        let url = URL(string: dataUrl)
//        URLSession.shared.dataTask(with:url!) { (data, response, error) in
//            if error != nil {
//                print(error ?? "")
//            } else {
//                do {
////                    let response = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
//let json = JSON(data: response)
//
//                    if let informationViewController = (self.storyboard?.instantiateViewController(withIdentifier: "InformationViewController"))! as? InformationViewController {
//                        informationViewController.inject(title: "Failure to Stop / Remain Infractions", content: response as! [JSON])
//                        self.present(informationViewController, animated: true, completion: nil)
//                    }
//                } catch let error as NSError {
//                    print(error)
//                }
//            }
//
//            }.resume()
//
//           }
//
//    @IBAction func showDocumentationfractions(_sender: Any) {
//        if let informationViewController = UIStoryboard(name: "InformationViewController", bundle: nil) as? InformationViewController {
//            informationViewController.inject(title: <#T##String#>, content: <#T##[JSON]#>)
//        }
//    }

    @IBAction func afdadfwaed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func afdfaaewf(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func dfafwqeafd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func dfadfd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func adfaera(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func fafd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func afdsd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
