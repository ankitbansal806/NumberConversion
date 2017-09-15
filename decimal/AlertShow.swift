//
//  AlertShow.swift
//  HeyCare
//
//  Created by Deepak Tomar on 08/04/16.
//  Copyright © 2016 Deepak Tomar. All rights reserved.
//

import Foundation
import UIKit
class AlertShow: NSObject {
    
    func alertView(_ msg :String)  {
        
        let alert = UIAlertController(title: "Conversion Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        let activeVc = UIApplication.shared.keyWindow?.rootViewController
        activeVc?.present(alert, animated: true, completion: nil)
        
    }
}

extension Int {
    func toBase(b:Int) -> String {
        guard b > 1 && b < 37 else {
            fatalError("base out of range")
        }
        let dict = [10:"A", 11:"B", 12:"C", 13:"D",14:"E",15:"F", 16:"G", 17:"H", 18:"I", 19:"J", 20:"K", 21:"L",22:"M", 23:"N", 24:"O", 25:"P", 26:"Q",27:"R", 28:"S", 29:"T", 30:"U", 31:"V", 32:"W", 33:"X", 34:"Y", 35:"Z"]
        var num = abs(self)
        var str = ""
        repeat {
            if let l = dict[num%b] {
                str = l + str
            }
            else {
                str = String(num%b) + str
            }
            
            num = num/b
        }
            while num > 0
        return self < 0 ? "-\(str)" : str
        
    }
}

extension Double {
    
    // check results against http://baseconvert.com
    func toBase(b:Int, maxPrecision:Int = 100) -> String {
        func afterDecimal(d:Double) -> String {
            var str = ""
            var num = d
            
            let dict = [10:"A", 11:"B", 12:"C", 13:"D",14:"E",15:"F", 16:"G", 17:"H", 18:"I", 19:"J", 20:"K", 21:"L",22:"M", 23:"N", 24:"O", 25:"P", 26:"Q",27:"R", 28:"S", 29:"T", 30:"U", 31:"V", 32:"W", 33:"X", 34:"Y", 35:"Z"]
            for _ in 0..<100 {
                num *= Double(b)
                // if finished before maxPrecision return early
                if num.truncatingRemainder(dividingBy: Double(b)) == 0 {
                    return str
                }
                if let l = dict[Int(num)] {
                    str = str + l
                }
                else {
                    str = str + String(Int(num))
                }
                
                if num > 1 {
                    num = num - Double(Int(num))
                }
                
            }
            // FIXME: trim zeroes
            return str
            
        }
        // divide into before and after decimal point
        let split = String(self).split(separator: ".")
        let result = Int(split[0])!.toBase(b:b) + "." + afterDecimal(d: Double("0." + split[1])!)
        return result
    }
}

extension String {
    func split(separator:String) -> [String] {
        return self.characters.split(separator: Character(separator)).map{String($0)}
    }
}



extension String {
    func fromBase(b:Int, maxPrecision:Int = 100) -> Double {
        let dict:[Int:Character] = [10:"A", 11:"B", 12:"C", 13:"D",14:"E",15:"F", 16:"G", 17:"H", 18:"I", 19:"J", 20:"K", 21:"L",22:"M", 23:"N", 24:"O", 25:"P", 26:"Q",27:"R", 28:"S", 29:"T", 30:"U", 31:"V", 32:"W", 33:"X", 34:"Y", 35:"Z"]
        
        func beforeDecimal(str:String) -> Double {
            var num = 0.0
            for c in str.characters.reversed().enumerated() {
                let multi = pow(base: Double(b), power: c.offset)
                
                
                if let v = Int(String(c.element)) {
                    num += Double(multi) * Double(v)
                }
                else {
                    for (i, s) in dict where s == c.element {
                        num += Double(multi) * Double(i)
                    }
                }
                
            }
            return num
        }
        func afterDecimal(str:String) -> Double {
            var num = 0.0
            
            for c in str.characters.enumerated() {
                let multi = pow(base: 1/Double(b), power: c.offset + 1)
                if let v = Int(String(c.element)) {
                    num += Double(multi) * Double(v)
                }
                else {
                    for (i, s) in dict where s == c.element {
                        num += Double(multi) * Double(i)
                    }
                }
                
            }
            
            return num
        }
        
        var split = self.split(separator:  ".")
        let isNegative = split[0].hasPrefix("-")
        if isNegative {
            split[0].remove(at: split[0].startIndex)
        }
        let result = beforeDecimal(str: split[0]) + afterDecimal(str: split[1])
        return isNegative ? -result : result
    }
}
func pow(base:Double, power:Int) -> Double {
    precondition(power >= 0)
    var answer : Double = 1
    for _ in 0..<power { answer *= base }
    return answer
}
