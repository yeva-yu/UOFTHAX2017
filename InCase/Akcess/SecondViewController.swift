//
//  SecondViewController.swift
//  Akcess
//
//  Created by Salman Sharif on 2017-01-21.
//  Copyright © 2017 Francois Gouelo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Speech

@available(iOS 10.0, *)

class SecondViewController: UIViewController, SFSpeechRecognizerDelegate, UITextFieldDelegate {

    @IBOutlet weak var btnBG: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var DriveButton: UIButton!
    @IBOutlet weak var SubstanceButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var questionTextField: UITextField!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    private var queryUrl = ""
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CancelButton.isHidden = true
        DriveButton.isHidden = true
        SubstanceButton.isHidden = true 
        button.isEnabled = false
        
        speechRecognizer?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.button.isEnabled = isButtonEnabled
            }
        }
        questionTextField.delegate = self
        questionTextField.returnKeyType = .search
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func microphoneTapped(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            button.isEnabled = false
            
            button.isHidden = true
            btnBG.isHidden = true
            DriveButton.isHidden = false
            CancelButton.isHidden = false
            btnBG.image = UIImage(named: "circle.png")
        } else {
            if let inputNode = audioEngine.inputNode {
                inputNode.removeTap(onBus: 0)
            }
            startRecording()
            btnBG.image = UIImage(named: "greengo.png")
        }
        
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        button.isEnabled = true
        button.isHidden = false
        btnBG.isHidden = false
        DriveButton.isHidden = true
        CancelButton.isHidden = true
        audioEngine.stop()
        // do a segue/pass info here

        var url = ""
        if (textView.text != "Say something, I'm listening!" && textView.text != "Click the mic to tell us your problem - we will find a solution" && textView.text != "Sorry, we couldn't find anything. Try asking another question!") {
            url = createQueryUrl(text: textView.text)
        } else {
            url = createQueryUrl(text: questionTextField.text!)
        }
        questionTextField.text = ""
        questionTextField.placeholder = "or write text here"
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!).arrayObject
                if (swiftyJsonVar?.count)! > 0 {
                    if let vc = ( self.storyboard?.instantiateViewController(withIdentifier: "SideViewController"))! as? SideViewController {
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    self.textView.text = "Sorry, we couldn't find anything. Try asking another question!"
                }
//                if let resData = swiftyJsonVar["contacts"].arrayObject {
//                    self.arrRes = resData as! [[String:AnyObject]]
//                }
//                if self.arrRes.count > 0 {
//                    self.tblJSON.reloadData()
//                }
            }
        }

    }

    
    @IBAction func cancelTapped(_ sender: Any) {
        button.isHidden = false
        btnBG.isHidden = false
        button.isEnabled = true
        DriveButton.isHidden = true
        CancelButton.isHidden = true
        if let inputNode = audioEngine.inputNode {
            inputNode.removeTap(onBus: 0)
        }
        audioEngine.stop()
        textView.text = "Click the mic to tell us your problem - we will find a solution"

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            button.isEnabled = false

            button.isHidden = true
            btnBG.isHidden = true
            DriveButton.isHidden = false
            CancelButton.isHidden = false
            btnBG.image = UIImage(named: "circle.png")
        }

        textView.text = "Click the mic to tell us your problem - we will find a solution"
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
            confirmTapped(self)
        }
        
        return true
    }

    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            var query = ""
            if result != nil {
                query = (result?.bestTranscription.formattedString)!
                self.textView.text = query
                isFinal = (result?.isFinal)!
                if (query.contains("driv") || query.contains("car") || query.contains("speed") ||
                    query.contains("pulled over") || query.contains("traffic") || query.contains("auto") || query.contains("jam") || query.contains("motor") || query.contains("vehicle") || query.contains("engine") || query.contains("race") || query.contains("motor")) {
                   self.DriveButton.isHidden = false
                } else if (query.contains("drug") || query.contains("weed")||query.contains("substance") || query.contains("coke") || query.contains("cocaine") || query.contains("marijuana") || query.contains("herb") || query.contains("amine") || query.contains("opiates") || query.contains("dope") || query.contains("pharma") || query.contains("halluci") || query.contains("narco")) {
                    self.SubstanceButton.isHidden = false
                }
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.button.isEnabled = true
                

            }
            
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textView.text = "Say something, I'm listening!"
    }
    
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            button.isEnabled = true
        } else {
            button.isEnabled = false
        }
    }

    //
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  if (segue?.identifier == "SecondToAdvice") {
       // segue.destinationViewController
       //  Get the new view controller using segue.destinationViewController.
       //  Pass the selected object to the new view controller.
    //}
    
    func createQueryUrl(text: String) -> String {
        // get a list of words from the text
        let urlbase = "https://immense-journey-79536.herokuapp.com/data?"
        let lowerText = text.lowercased()
        // get a list of key words
        let keyArray = ["failure", "driving", "careless","g licence","g1","g2","almost hurt", "harm", "hurt", "killed", "red light", "school bus", "report", "stay", "remain", "too close", "insurance", "suspended", "disqualified", "text", "read", "eating", "gps", "calling", "alchohol", "driving under the influence", "bac", "breath", "breathalizer", "police", "officer", "line", "check", "charge", "disqualify", "license", "speed", "demerit", "street",  "race"]
        var matchedArray = [String]()
        
        // loop over each item in key words and check if all of them appear in
        
        for key in keyArray {
            if lowerText.contains(key){
                matchedArray.append(key)
            }
        }
        var completeurl = ""
        // create the url
        if !matchedArray.isEmpty {
            completeurl = urlbase + "keywords=" + matchedArray[0]
            for i in 1..<matchedArray.capacity {
                let appendUrl = "&keywords=" + matchedArray[i]
                completeurl += appendUrl
            }
        } else {
            completeurl = urlbase + "keywords=nonexistentfam"
        }
        
        return completeurl
    }

}

