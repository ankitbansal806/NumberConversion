//
//  ViewController.swift
//  decimal
//  Created by Ritesh on 12/09/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var decimalTF: UITextField!
    @IBOutlet weak var BinaryTF: UITextField!
    @IBOutlet weak var HexaDecimalTF: UITextField!
    @IBOutlet weak var octalTF: UITextField!
    @IBOutlet weak var floatingValue: UITextField!
    @IBOutlet weak var fromBase: UITextField!
    @IBOutlet weak var toBase: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var resultTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decimalTF.delegate=self
        HexaDecimalTF.delegate=self
        BinaryTF.delegate=self
        octalTF.delegate=self
        floatingValue.delegate=self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func clearMethod(_ sender: Any) {
        decimalTF.text=""
        BinaryTF.text=""
        HexaDecimalTF.text=""
        octalTF.text=""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text!.components(separatedBy:".").count > 1 && string == "."){
            return false
        }
        if textField == decimalTF {
            let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
            print("newString\(newString)")
            
            if newString != "" {
                
                if newString.range(of: ".") != nil{
                    print("Double Value")
                    BinaryTF.text = Double(newString)?.toBase(b: 2)
                    HexaDecimalTF.text = Double(newString)?.toBase(b: 16)
                    octalTF.text = Double(newString)?.toBase(b: 8)
                }else{
                    print("Int Value")
                    BinaryTF.text = Int(newString)?.toBase(b: 2)
                    HexaDecimalTF.text = Int(newString)?.toBase(b: 16)
                    octalTF.text = Int(newString)?.toBase(b: 8)
                }
            }else {
                BinaryTF.text=""
                HexaDecimalTF.text=""
                octalTF.text=""
            }
        }
        return true
        
    }
    @IBAction func convertAction(_ sender: Any) {
        if floatingValue.text == "" {
            AlertShow().alertView("Floating point value need to fill first!!!")
        }else if floatingValue.text?.range(of: ".") == nil{
            AlertShow().alertView("Given vlaue is not an floating point value!!!!")
        }else if fromBase.text == "" {
            AlertShow().alertView("From base value need to fill first!!!")
        }else if toBase.text == "" {
            AlertShow().alertView("To base value need to fill first!!!")
        }else {
            let floatingVal = floatingValue.text!
            let fromBaseVal = Int(fromBase.text!)
            let toBAseVal = Int(toBase.text!)
            resultTF.text = String(floatingVal.fromBase(b: fromBaseVal!).toBase(b: toBAseVal!))
        }
    }
}


