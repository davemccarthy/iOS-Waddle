//
//  WRDHeadingView.swift
//  wordel
//
//  Created by David McCarthy on 06/03/2022.
//  Copyright © 2022 David McCarthy. All rights reserved.
//

import UIKit

class WRDHeadingView: UIView {
    
    let streakLabel:UILabel = {
        
        let label = UILabel()
        
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.textAlignment = .center
        label.text = "STREAK"
        
        return label
    }()
    
    let streakValue:UILabel = {
        
        let label = UILabel()
        
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.textAlignment = .center
        
        return label
    }()
    
    let recordLabel:UILabel = {
        
        let label = UILabel()
        
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.textAlignment = .center
        label.text = "RECORD"
        
        return label
    }()
    
    let recordValue:UILabel = {
        
        let label = UILabel()
        
        label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.textAlignment = .center
        
        return label
    }()
    
    let titleLabel:UILabel = {
        
        let label = UILabel()
        
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = "Waddle"
        
        return label
    }()

    //  Build heading view
    func addSubviews(parentView: UIView) {
        
        var frame:CGRect = parentView.frame.insetBy(dx: 2, dy: 2)
        let y = parentView.frame.height / 2 - (parentView.frame.height / 2) / 1.7
        
        frame.size.height = parentView.frame.height * 0.1
        frame.origin.y = parentView.frame.width * 0.2
        
        self.frame = frame
        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        self.center = CGPoint(x: parentView.center.x,y: y / 5.0 * 3)
        
        frame.origin.x = 0
        frame.origin.y = 0
        
        titleLabel.frame = frame.insetBy(dx: parentView.frame.width * 0.01, dy: parentView.frame.width * 0.01)
        titleLabel.font = UIFont.boldSystemFont(ofSize: parentView.frame.height * 0.05)
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        frame.size.height = self.frame.height * 0.5
        frame.size.width = self.frame.width * 0.30
        
        streakLabel.frame = frame
        streakLabel.font = UIFont.boldSystemFont(ofSize: parentView.frame.height * 0.0175)
        streakLabel.center = CGPoint(x: self.frame.width / 6, y: self.frame.height / 3)
        
        streakValue.frame = frame
        streakValue.font = UIFont.boldSystemFont(ofSize: parentView.frame.height * 0.03)
        streakValue.center = CGPoint(x: self.frame.width / 6, y: self.frame.height / 5.0 * 3.0)
        
        recordLabel.frame = frame
        recordLabel.font = UIFont.boldSystemFont(ofSize: parentView.frame.height * 0.0175)
        recordLabel.center = CGPoint(x: self.frame.width / 6 * 5, y: self.frame.height / 3)
        
        recordValue.frame = frame
        recordValue.font = UIFont.boldSystemFont(ofSize: parentView.frame.height * 0.03)
        recordValue.center = CGPoint(x: self.frame.width / 6 * 5, y: self.frame.height / 5.0 * 3.0)
        
        self.addSubview(titleLabel)
        
        self.addSubview(streakLabel)
        self.addSubview(streakValue)
        
        self.addSubview(recordLabel)
        self.addSubview(recordValue)
        
        parentView.addSubview(self)
    }
}
