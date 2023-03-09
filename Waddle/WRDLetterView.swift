//
//  WRDLetterView.swift
//  wordel
//
//  Created by David McCarthy on 21/02/2022.
//  Copyright © 2022 David McCarthy. All rights reserved.
//

import UIKit

enum LetterStatus:Int, Comparable {
    
    case STS_PENDING, STS_OUTCAST, STS_ILLPOSITIONED, STS_POSITIONED
    
    // Implement Comparable
    public static func < (a: LetterStatus, b: LetterStatus) -> Bool {
        return a.rawValue < b.rawValue
    }
}

class WRDLetterView: UIView {

    let characterLabel:UILabel = {
        
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.text = ""
        
        return label
    }()
    
    //  Build letter
    func addSubViews(parentView: UIView, offset:CGFloat){
        
        let frame:CGRect = parentView.frame
        let height:CGFloat = frame.height
        let width:CGFloat = frame.width / 5
        let x:CGFloat = width * offset
        let y:CGFloat = 0
        
        self.frame = CGRect(x: x, y: y, width: width, height: height).insetBy(dx: width/20.0, dy: width/20.0)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor.white
        
        characterLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        characterLabel.font = UIFont.boldSystemFont(ofSize: width / 2.0)
        
        self.addSubview(characterLabel)
        
        parentView.addSubview(self)
    }
}
