//
//  ViewController.swift
//  SlackUI
//
//  Created by Adan on 01/10/2019.
//  Copyright © 2019 Kimdoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let charSet: CharacterSet = {
        var cs = CharacterSet.lowercaseLetters
        cs.insert(charactersIn: "0123456789")
        cs.insert(charactersIn: "-")
        cs.insert(charactersIn: ".")
        return cs.inverted
    }()
    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var placehoderLabel: UILabel!
    @IBOutlet weak var placehoderLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //입력모드
        if string.count > 0 {
            guard string.rangeOfCharacter(from: charSet) == nil else{
                return false
            }
        }
        
        let finalText = NSMutableString(string: textField.text ?? "")
        finalText.replaceCharacters(in: range, with: string)

        let font = textField.font ?? UIFont.systemFont(ofSize: 16)
        let dict = [NSAttributedString.Key.font: font]
        let width = finalText.size(withAttributes: dict).width
        placehoderLeadingConstraint.constant = width
        
        
        var countDot : Int = 0
        
        if finalText.length == 0 {
            showStatus = .showFullName
        }else{
            if let firstString : String = textField.text {
                
                let realString  = firstString.appendingFormat("%@", string)
                let textArray = realString.split(separator: ".")
                
                print(textArray)
                print(textArray.count)

                for character in realString {
                    
                    if character == "." {
                        countDot = countDot + 1
                    }
                }
            }
        }

        if countDot == 0 {
            placehoderLabel.text = ".slack.com"
        }else if countDot == 1{
            placehoderLabel.text = ".com"
        }else{
            placehoderLabel.text = ""
        }

        return true
    }
}
