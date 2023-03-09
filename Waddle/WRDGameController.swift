//
//  WRDGridViewController.swift
//  wordel
//
//  Created by David McCarthy on 21/02/2022.
//  Copyright © 2022 David McCarthy. All rights reserved.
//

import UIKit

class WRDGameController: UIViewController {
    
    private var conttraints:[NSLayoutConstraint] = []

    let heading = WRDHeadingView()
    let grid = WRDGridView()
    var keyboard = WRDKeyboardView()
    var dictionary = WRDDictionary()
    var messenger = WRDMessengerButton()
    
    var cursorX:Int=0
    var cursorY:Int=0
    
    var answer:String = ""
    var gameover:Bool = false
    
    var streak:Int = 0
    var record:Int = 0
    
    //  Start up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        
        heading.addSubviews(parentView: self.view)
        grid.addSubviews(parentView: self.view)
        keyboard.addSubViews(grid: self)
        messenger.addSubViews(grid: self, keyboard: keyboard)
        
        let defaults = UserDefaults.standard
        
        //  Load history
        if let streakStr = defaults.object(forKey:"Streak") {
            
            streak = streakStr as! Int
        }
        
        if let recordStr = defaults.object(forKey:"Record") {
            
            record = recordStr as! Int
        }
        
        resetGame()
        
        //  Load exisiting game
        if let answerStr = defaults.string(forKey: "Answer") {
         
            answer = answerStr
        }
        
        if let words = defaults.stringArray(forKey: "Words") {
        
            for (n,word) in words.enumerated() {
                
                grid.setWord(row: n, letters: word)
                analyseWord()
            }
        }
    }
    
    //  Reset game info
    func resetGame()
    {
        self.answer = dictionary.randomWord()
        self.gameover = false
        
        cursorY = 0
        cursorX = 0
        
        grid.reset()
        keyboard.reset()
        
        heading.streakValue.text = String(streak)
        heading.recordValue.text = String(record)
        
        print("the word is \(self.answer)")
    }
    
    //  Game terminated
    func gameTerminated()
    {
        let words = grid.getWords(rows:self.cursorY)
        let defaults = UserDefaults.standard
        
        if(self.gameover){
            
            UserDefaults.standard.removeObject(forKey: "Words")
            UserDefaults.standard.removeObject(forKey: "Answer")
        }
        else{
            
            defaults.set(words, forKey: "Words")
            defaults.set(self.answer, forKey: "Answer")
        }
    }
    
    //  Message button pressed
    @objc func messageAction(_ sender:UIButton!)
    {
        sender.isHidden = true
        
        if gameover == true {
         
            self.resetGame()
        }
    }
    
    //  Update grid and keyboard
    func updateLetter(row:Int, index:Int,character:String,status:LetterStatus = .STS_PENDING,animated:Bool = false)
    {
        grid.updateLetter(row: row, index: index, character: character,status: status,animated: animated)
        keyboard.updateLetter(character: character,status: status,animated: animated)
    }
    
    //  Analyse game
    func analyseWord()
    {
        //  Get next guess word
        let word:String = grid.getWord(row: cursorY)
        
        //  Check for valid 5 letter word
        if dictionary.isValidWord(word: word.lowercased()) == false {
            
            messenger.alert(title: ("NOT A WORD: \(word.uppercased()) 😔"))
            return
        }
        
        //  Iterate thru letters
        for n in 0...4 {
        
            let charIndex = word.index(word.startIndex, offsetBy: n)
            
            let ansChar:Character = answer[charIndex]
            let wordChar:Character = word[charIndex]
            
            //  Right letter right position
            if wordChar == ansChar {
                
                updateLetter(row: self.cursorY, index: n, character: String(wordChar),status: .STS_POSITIONED,animated: true)
                continue
            }
            
            //  Letter in wrong position
            if answer.contains(wordChar) {
                
                let wordOccurances = word.occurances(subject:wordChar,endIndex:n)
                let answerOccurances = answer.occurances(subject:wordChar,endIndex:4)
                let matches = answer.matches(compareTo: word, subject: wordChar, fromIndex: n)
                
                //  Hairy bit
                if(wordOccurances > answerOccurances || matches >= 1){
                    print("wordOccurances: \(wordOccurances) answerOccurances: \(answerOccurances) Matches: \(matches) \(wordChar)")
                }
                else{
                    updateLetter(row: self.cursorY, index: n, character: String(wordChar),status: .STS_ILLPOSITIONED,animated: true)
                    continue
                }
            }
            
            //  Default to outcast
            updateLetter(row: self.cursorY, index: n, character: String(wordChar),status: .STS_OUTCAST,animated: true)
        }
        
        cursorY = cursorY + 1
        cursorX = 0
        
        //  Correct word?
        if(word == answer){
            
            streak = streak + 1
            
            if streak > record {
                record = streak
            }
            
            let defaults = UserDefaults.standard
            
            defaults.set(streak, forKey: "Streak")
            defaults.set(record, forKey: "Record")
            
            messenger.alert(title: ("EXCELLENT: \(word.uppercased()) 😊"),delay: 0.9)
            
            gameover = true
            return
        }

        //  Incorrect word
        if cursorY == 6 {
        
            messenger.alert(title: ("THE WORD WAS \(answer) 😭"),delay: 0.9)
            gameover = true
            streak = 0
            
            let defaults = UserDefaults.standard
            
            defaults.set(streak, forKey: "Streak")
            defaults.set(record, forKey: "Record")
        }
    }
    
    //  Keyboard button pressed
    @objc func keyboardAction(_ sender:UIButton!)
    {
        guard let text = sender.titleLabel?.text else {
            return
        }
        
        //  Examine key press
        switch text {
            
        //  Backspace
        case "⌫":
            
            if cursorX > 0 {
                cursorX = cursorX - 1
            }
            
            if cursorX == 0 {
                keyboard.backButton?.isEnabled = false
            }
            
            keyboard.enterButton?.isEnabled = false
            
            grid.updateLetter(row: self.cursorY, index: cursorX, character: "")
            
        //  Enter
        case "ENTER":
            
            if cursorY < 6 && cursorX == 5 {
                
                analyseWord()
            }
            
            keyboard.enterButton?.isEnabled = false
        
        //  Append letter
        default:
        
            if cursorX < 5 {
                
                grid.updateLetter(row: self.cursorY, index: cursorX, character: text)
                cursorX = cursorX + 1
            }
            
            if cursorX == 5 {
                keyboard.enterButton?.isEnabled = true
            }
            else{
                keyboard.enterButton?.isEnabled = false
            }
            
            keyboard.backButton?.isEnabled = true
        }
    }
}
