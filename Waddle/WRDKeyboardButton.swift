//
//  WRDKeyboardButton.swift
//  wordel
//
//  Created by David McCarthy on 23/02/2022.
//  Copyright © 2022 David McCarthy. All rights reserved.
//

import UIKit

class WRDKeyboardButton: UIButton {
    
    var status:LetterStatus = .STS_PENDING
    
    init() {
        
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        
        self.tintColor = UIColor.black
        //self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.setTitleColor(UIColor.black, for: .normal)
        self.setTitleColor(UIColor.gray, for: .highlighted)
        self.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
