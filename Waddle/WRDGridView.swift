//
//  WRDGridView.swift
//  wordel
//
//  Created by David McCarthy on 04/03/2022.
//  Copyright © 2022 David McCarthy. All rights reserved.
//

import UIKit

class WRDGridView: UIView {

    //  Build word matrix
    func addSubviews(parentView: UIView) {
        
        let frame:CGRect = parentView.frame
        
        //  Caclulate dimentions
        let height = frame.height / 2
        let width = height / 6.0 * 5.0
        
        let y = frame.height / 2 - height / 1.7
        let x = frame.width / 2 - width / 2
        
        self.frame = CGRect(x: x,y: y, width: width,height: height)
        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        for n in 0..<6 {
            
            let word:WRDWordView = WRDWordView()
            
            word.addSubViews(parentView: self, offset: CGFloat(n))
        }
        
        parentView.addSubview(self)
    }
    
    //  Reset all words
    func reset(){
        
        for view in subviews {
            
            let word:WRDWordView = view as! WRDWordView
            
            word.reset()
        }
    }
    
    //  Update letter in matrix
    func updateLetter(row:Int, index:Int,character:String,status:LetterStatus = .STS_PENDING,animated:Bool = false){
        
        let word:WRDWordView = self.subviews[row] as! WRDWordView
        
        word.updateLetter(index:index,character: character,status: status,animated: animated)
    }
    
    //  Retrive word
    func getWord(row:Int) -> String {
        
        let word:WRDWordView = self.subviews[row] as! WRDWordView
        
        return word.getWord()
    }
    
    //  Retrive words
    func getWords(rows:Int) -> [String] {
    
        var result:[String] = []
        
        for row in 0..<rows {
        
            let word:WRDWordView = subviews[row] as! WRDWordView
            let letters = word.getWord()
            
            result.append(letters)
        }
    
        return result
    }
    
    //  Set word
    func setWord(row:Int,letters:String){
        
        let word:WRDWordView = subviews[row] as! WRDWordView
        
        word.setWord(word: letters)
    }
}
