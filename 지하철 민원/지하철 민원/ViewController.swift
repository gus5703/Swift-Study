//
//  ViewController.swift
//  지하철 민원
//
//  Created by 왕승현 on 2016. 3. 2..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit
import MessageUI


class ViewController: UIViewController{
    
    @IBOutlet weak var nextStationTextField: UITextField!
    @IBOutlet weak var currentStationTextField: UITextField!
    @IBOutlet weak var lineNumberField: UITextField!
    @IBOutlet weak var inquriyTextField: UITextField!
    
    let lineNumberPicker: UIPickerView = UIPickerView()
    let currentStationPicker: UIPickerView = UIPickerView()
    let nextStationPicker: UIPickerView = UIPickerView()
    let inquriyPicker: UIPickerView = UIPickerView()
    let inquriyData: [String] = ["너무 추워요!", "너무 더워요!", "상인이 있어요", "누가 토했어요"]
    
    var xmlParser: NSXMLParser!
    var currentElement: String = ""
    var lineNumberPickerData: [String] = [String]()
    var nextStationText: [String] = []
    var stationByLineNumber: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...8 { lineNumberPickerData.append("\(i) 호선") }
        getStationBySubwayLine(1)
        setUpPicker()
        
    }
    
    func setUpPicker() {
        let window = UIScreen.mainScreen().bounds
        let windowWidth = window.width
        let windowHeight = window.height
        let pickerSize = CGSize(width: windowWidth, height: windowHeight - 500.0)
        
        self.lineNumberPicker.delegate = self
        self.lineNumberPicker.dataSource = self
        self.lineNumberPicker.frame.size = pickerSize
        self.lineNumberPicker.frame.origin.y = window.height - 450.0
        self.lineNumberPicker.tag = 1
        
        self.lineNumberField.inputView = lineNumberPicker
        self.lineNumberField.text = lineNumberPickerData[0]
        
        self.currentStationPicker.delegate = self
        self.currentStationPicker.dataSource = self
        self.currentStationPicker.frame.size = pickerSize
        self.currentStationPicker.frame.origin.y = window.height - 450.0
        self.currentStationPicker.tag = 2
        
        self.currentStationTextField.inputView = currentStationPicker
        self.currentStationTextField.text = " "
        
        self.nextStationPicker.delegate = self
        self.nextStationPicker.dataSource = self
        self.nextStationPicker.frame.size = pickerSize
        self.nextStationPicker.frame.origin.y = window.height - 450.0
        self.nextStationPicker.tag = 3
        
        self.nextStationTextField.inputView = nextStationPicker
        self.nextStationTextField.text = " "
        
        self.inquriyPicker.delegate = self
        self.inquriyPicker.dataSource = self
        self.inquriyPicker.frame.size = pickerSize
        self.inquriyPicker.frame.origin.y = window.height - 450.0
        self.inquriyPicker.tag = 4
        
        self.inquriyTextField.inputView = inquriyPicker
        self.inquriyTextField.text = " "
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func sendSMS(message: String, recepients: [String]){
        var controller = MFMessageComposeViewController()
        if MFMessageComposeViewController.canSendText() {
            controller.body = message
            controller.recipients = recepients
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
    }
    
    
    func getStationBySubwayLine(line: Int) -> [String]{
        let apiCertification: String = "624b54454f67757337334957516f79"
        let url: NSURL =
        NSURL(string: "http://openapi.seoul.go.kr:8088/\(apiCertification)/xml/SearchSTNBySubwayLineService/1/999/\(line)/")!
        
        stationByLineNumber = []
        
        xmlParser = NSXMLParser(contentsOfURL: url)
        xmlParser.delegate = self
        xmlParser.parse()
        return stationByLineNumber
    }
    @IBAction func sendButtonAction(sender: AnyObject) {
        let lineNumber = lineNumberField.text!
        let currentStation = currentStationTextField.text!
        let nextStation = nextStationTextField.text!
        let inquriy = inquriyTextField.text!
        
        var message = ""
        message += "\(lineNumber)을 타고 "
        message += "\(currentStation)역에서 "
        message += "\(nextStation)역으로 운행중인 열차에 타고있습니다."
        message += "\(inquriy)"
        print(message)
        if lineNumber != " " && currentStation != " " &&
            nextStation != " " && inquriy != " " {
                switch(lineNumber) {
                case "1 호선", "2 호선", "3 호선", "4 호선":
                    sendSMS(message, recepients: ["1577-1234"])
                case "5 호선", "6 호선", "7 호선", "8 호선":
                    sendSMS(message, recepients: ["1577-5678"])
                default:
                    break
                }
        } else {
            let warningAlert = UIAlertView(title: "error", message: "빈칸을 채워넣으세요", delegate: nil, cancelButtonTitle: "ok")
            warningAlert.show()
        }
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ViewController: MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch(result) {
        case MessageComposeResultCancelled:
            break
        case MessageComposeResultFailed:
            
            let warningAlert = UIAlertView(title: "error", message: "Fail to send SMS", delegate: nil, cancelButtonTitle: "ok")
        case MessageComposeResultSent:
            break
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(pickerView.tag) {
        case 1:
            return lineNumberPickerData.count
        case 2:
            return stationByLineNumber.count
        case 3:
            return nextStationText.count
        case 4:
            return inquriyData.count
        default:
            return 0
            
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(pickerView.tag) {
        case 1:
            return lineNumberPickerData[row]
        case 2:
            return stationByLineNumber[row]
        case 3:
            return nextStationText[row]
        case 4:
            return inquriyData[row]
        default:
            return nil
            
        }
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(pickerView.tag) {
            
        case 1 :
            lineNumberField.text = lineNumberPickerData[row]
            currentStationTextField.text = " "
            nextStationTextField.text = " "
            nextStationText = []
            
            self.view.endEditing(true)
            getStationBySubwayLine(row + 1)
        case 2 :
            currentStationTextField.text = stationByLineNumber[row]
            nextStationTextField.text = " "
            nextStationText = []
            
            if row == 0 {
                nextStationText.append(stationByLineNumber[row+1])
                nextStationTextField.text = nextStationText[0]
            } else if row == stationByLineNumber.count - 1 {
                nextStationText.append(stationByLineNumber[row-1])
                nextStationTextField.text = nextStationText[0]
            } else {
                nextStationText.appendContentsOf([stationByLineNumber[row-1], stationByLineNumber[row+1]])
            }
            
            self.view.endEditing(true)
        case 3 :
            nextStationTextField.text = nextStationText[row]
            
            self.view.endEditing(true)
        case 4:
            inquriyTextField.text = inquriyData[row]
            
            self.view.endEditing(true)
        default:
            break
        }
    }
    
}

extension ViewController: NSXMLParserDelegate {
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.currentElement = elementName
        if elementName == "STATION_NM"{
            //print(attributeDict)
        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        //print(currentElement)
        if currentElement == "STATION_NM" && string != "\n"
        {
            stationByLineNumber.append(string)
        }
    }
    
}