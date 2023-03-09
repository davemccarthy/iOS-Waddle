//
//  WRDString.swift
//  Waddle
//
//  Created by David McCarthy on 11/03/2022.
//

import Foundation

extension String {

    func occurances(subject:Character,endIndex:Int) -> Int{
        
        let chars = Array(self)
        var count = 0
        
        for n in 0...endIndex {
            
            if chars[n] == subject {
                count = count + 1
            }
        }
        
        return count
    }
    
    func matches(compareTo:String,subject:Character,fromIndex:Int) -> Int {
        
        var count = 0
        
        for n in fromIndex...4 {
            
            let inChars = Array(self)
            let exChars = Array(compareTo)
            
            if subject == inChars[n] && subject == exChars[n] {
                count = count + 1
            }
        }
        
        return count
    }
}
