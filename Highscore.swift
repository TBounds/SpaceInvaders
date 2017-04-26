//
//  Highscore.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/25/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import Foundation

class Highscore : NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var objectId : String = ""
    var score : Int = 0
    
    // func save score
    func saveNewHighscore(name: String, score: Int) {
        
        let highscore = Highscore()
        highscore.objectId = "AAA"
        highscore.score = 120
        
        let dataStore = appDelegate.backendless?.data.of(Highscore.ofClass())
        
        dataStore.save (
            highscore,
            response: { (result: AnyObject!) -> Void in
                let obj = result as! Highscore
                NSLog("Highscore has been logged: \(result!.objectId)")
                
            },
            error: { (fault: Fault!) -> Void in
                NSLog("Server reported an error.")
        )
        
        
        
    }
    
    // func get score
    
}
