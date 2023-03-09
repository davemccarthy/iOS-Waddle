//
//  WRDKeyboard.swift
//  wordel
//
//  Created by David McCarthy on 24/02/2022.
//  Copyright © 2022 David McCarthy. All rights reserved.
//

import UIKit

class WRDKeyboardView: UIView {

    let keys:[[String]] = [
        ["Q","W","E","R","T","Y","U","I","O","P"],
        ["A","S","D","F","G","H","J","K","L"],
        ["ENTER","Z","X","C","V","B","N","M","⌫"]
    ]
    
    var enterButton: UIButton?
    var backButton: UIButton?
    
    //  Build keyboard layout
    func addSubViews(grid: WRDGameController) {
        
        let frame:CGRect = grid.view.frame
        let height:CGFloat = frame.height * 0.22
        var width:CGFloat = frame.width * 0.95
        
        let x:CGFloat = (grid.view.frame.width - width) / 2
        let y:CGFloat = frame.height * 0.75
        
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        
        for (row,keyRow) in keys.enumerated() {
            
            let container:UIView = UIView()
            var totalWidth:CGFloat = 0.0
            
            for key in keyRow {
                
                let button = WRDKeyboardButton() as UIButton
                width = self.frame.width * 0.1
                
                if key == "ENTER"{
                    width = self.frame.width * 0.2
                    enterButton = button
                    enterButton!.isEnabled = false
                }
                
                if key == "⌫" {
                    width = self.frame.width * 0.11
                    backButton = button
                    backButton!.isEnabled = false
                }
                
                button.setTitle(key, for: UIControl.State.normal)
                button.addTarget(grid, action: #selector(grid.keyboardAction), for: .touchUpInside)
                button.frame = CGRect(x: totalWidth, y: 0, width: width, height: self.frame.height / 3).insetBy(dx: self.frame.width * 0.005, dy: self.frame.width * 0.005)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: self.frame.width * 0.05)
                
                container.addSubview(button)
                
                totalWidth = totalWidth + width
            }
            
            container.frame = CGRect(x: (self.frame.width - totalWidth)/2, y: (CGFloat(row) * self.frame.height / 3), width: totalWidth, height: self.frame.height / 3)
            container.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
            
            self.addSubview(container)
        }
        
        grid.view.addSubview(self)
    }
    
    //  Decorate letter
    func updateLetter(character:String,status:LetterStatus,animated:Bool = false){
        
        var backgroundColor:UIColor = UIColor.white
        var textColor:UIColor = UIColor.white
        
        for (row,keyRow) in keys.enumerated() {
            
            for (col,key) in keyRow.enumerated() {
                
                if(key == character){
                    
                    let container = self.subviews[row]
                    let button = container.subviews[col] as! WRDKeyboardButton
                    
                    //  Ignore if current status is higher
                    if(button.status > status /*&& status < .STS_ILLPOSITIONED*/){
                        continue
                    }
                    
                    button.setTitleColor(UIColor.gray, for: .highlighted)
                    button.status = status
                    
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
                    UIView.transition(with: button, duration: duration, options: .transitionCrossDissolve) {
                        
                        button.backgroundColor = backgroundColor
                        button.setTitleColor(textColor, for: .normal)
                    }
                }
            }
        }
    }
    
    //  Reset keys to normal
    func reset() {
        
        for (row,keyRow) in keys.enumerated() {
        
            for (col,_) in keyRow.enumerated() {
            
                let container = self.subviews[row]
                let button = container.subviews[col] as! WRDKeyboardButton
                
                button.backgroundColor = UIColor.white
                button.setTitleColor(UIColor.black, for: .normal)
                button.setTitleColor(UIColor.gray, for: .highlighted)
                button.status = .STS_PENDING
            }
        }
    }
}
