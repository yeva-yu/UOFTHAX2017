////
////  InformationViewController.swift
////  Akcess
////
////  Created by Yeva Yu on 2017-05-27.
////  Copyright © 2017 Francois Gouelo. All rights reserved.
////
//
//import UIKit
//import SwiftyJSON
//
//class InformationViewController: UIViewController {
//
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var contentTextView: UITextView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func inject(title: String, content: [JSON]) {
//        titleLabel.text = title
//        var contentString = ""
//        for article in content {
//            contentString.append(article["offense"].string!)
//            contentString.append("\n")
//            contentString.append(article["penalty"].string!)
//            contentString.append("\n\n")
//        }
//        contentTextView.text = contentString
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
