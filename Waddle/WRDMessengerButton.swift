//
//  WRDMessenger.swift
//  wordel
//
//  Created by David McCarthy on 26/02/2022.
//  Copyright © 2022 David McCarthy. All rights reserved.
//

import UIKit

class WRDMessengerButton: UIButton {

    //  Initialize
    init() {
        
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.darkGray
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.setTitle("CONGRATES: WORLD", for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.gray, for: .highlighted)
        self.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    //  Dorment message box
    func addSubViews(grid: WRDGameController,keyboard: WRDKeyboardView) {
        
        self.addTarget(grid, action: #selector(grid.messageAction(_:)), for: .touchUpInside)
        self.frame = keyboard.frame
        self.isHidden = true
        
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: keyboard.frame.height * 0.15)
        
        grid.view.addSubview(self)
    }
    
    //  Display message
    func alert(title :String,delay: CGFloat = 0.1) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            
            self.setTitle(title, for: .normal)
            self.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
