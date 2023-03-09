//
//  WRDWordView.swift
//  wordel
//
//  Created by David McCarthy on 22/02/2022.
//  Copyright © 2022 David McCarthy. All rights reserved.
//

import UIKit

class WRDWordView: UIView {

    var letters = [WRDLetterView]()
    
    //  Build letters row
    func addSubViews(parentView: UIView, offset:CGFloat){
        
        let frame:CGRect = parentView.frame
        let height:CGFloat = frame.height / 6
        let width:CGFloat = frame.width
        let x:CGFloat = 0.0
        let y:CGFloat = height * offset
        
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        
        for n in 0..<5 {
            
            let letter:WRDLetterView = WRDLetterView()
            
            letter.addSubViews(parentView: self, offset: CGFloat(n))
            letters.append(letter)
        }
        
        parentView.addSubview(self)
    }
    
    //  Decorate letter
    func updateLetter(index:Int,character:String,status:LetterStatus = .STS_PENDING,animated:Bool = false){
        
        let letter = letters[index]
        
        var backgroundColor:UIColor = UIColor.white
        var textColor:UIColor = UIColor.white
        
        //  Check status and colorize
        switch status {
            
        case .STS_PENDING:
            backgroundColor = UIColor.white
            textColor = UIColor.black
            
        case .STS_POSITIONED:
            backgroundColor = UIColor.systemGreen
            textColor = UIColor.white
            
        case .STS_ILLPOSITIONED:
            backgroundColor = UIColor.orange
            textColor = UIColor.white
            
        case .STS_OUTCAST:
            backgroundColor = UIColor.gray
            textColor = UIColor.white
        }
        
        //  To animate or not
        var duration = 0.25
        
        if animated == true {
            duration = 1.0
        }
        
        //  To animate or not
        UIView.transition(with: letter, duration: duration, options: .transitionCrossDissolve) {
            
            letter.backgroundColor = backgroundColor
            letter.characterLabel.textColor = textColor
        }
        
        letter.characterLabel.text = character
    }
    
    //  Retrieve full word
    func getWord() -> String {
        
        var word:String = ""
        
        for letter in letters {
            word = word + letter.characterLabel.text!
        }
        
        return word
    }
    
    //  Update full word
    func setWord(word:String){
        
        for n in 0...4 {
        
            let index = word.index(word.startIndex, offsetBy: n)
            
            letters[n].characterLabel.text = String(word[index])
        }
    }
    
    //  Reset letters
    func reset() {
        
        for letter in letters {
            
            letter.backgroundColor = UIColor.white
            letter.characterLabel.textColor = UIColor.black
            letter.characterLabel.text! = ""
        }
    }
}
