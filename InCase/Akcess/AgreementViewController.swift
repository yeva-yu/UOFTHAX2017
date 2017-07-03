//
//  AgreementViewController.swift
//  Akcess
//
//  Created by Yeva Yu on 2017-05-26.
//  Copyright © 2017 Francois Gouelo. All rights reserved.
//

import UIKit

protocol AgreementViewDelegate {
    func didAcceptAgreement()
}

class AgreementViewController: UIViewController {
    var delegate: AgreementViewDelegate?

    @IBAction func AcceptButton(_ sender: UIButton) {


        dismiss(animated: true, completion: nil)
        delegate?.didAcceptAgreement()
//        let vc = (
//            storyboard?.instantiateViewController(
//                withIdentifier: "SecondViewController")
//            )!
//        present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
