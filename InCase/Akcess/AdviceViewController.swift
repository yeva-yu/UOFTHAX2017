//
//  AdviceViewController.swift
//  Akcess
//
//  Created by Francois Gouelo on 2017-01-22.
//  Copyright © 2017 Francois Gouelo. All rights reserved.
//

import UIKit
import SwiftyJSON

class AdviceViewController: UIViewController {
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var goBack: UIButton!
    //@IBOutlet weak var BodyLabel: UILabel!
    @IBOutlet weak var bodyLabel: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.bodyLabel.text = "Good luck."
        var request = URLRequest(url: URL(string: "https://desolate-wave-64068.herokuapp.com/data?keyword=careless&keyword=killed")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        var val = "loading..."
        session.dataTask(with: request) {(data, response, err) -> Void in
            if (err != nil) { return }
            let info = String(data: data!, encoding: .utf8)
            if let dataFromString = info?.data(using: .utf8, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                if (json.array?.isEmpty)! {
                    self.bodyLabel.text = "Good luck."
                    self.TitleLabel.text = "No Results Found"
                } else {
                    let fresh = json.array?[0]
                
                    //self.bodyLabel.text = "i like pie\n heeee\
                    val = (fresh?["penalty"].string)!
                    //print(val)
                    //self.BodyLabel.text = val
                    let title = fresh?["offense"].string
                    self.TitleLabel.text = title
                                   }
            }
        }.resume()
        self.bodyLabel.text = val
 
        // Do any additional setup after loading the view.
    }
    
    func updatelable(text:String) {
        //self.bodyLabel.text = text
    }
    
    @IBAction func returnToPrev(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
