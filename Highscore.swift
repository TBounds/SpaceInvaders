//
//  Highscore.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/25/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import Foundation

class Highscore : NSObject {
    
    var name : String = ""
    var score : Int = 0
    
    init(name : String, score : Int){
        self.name = name
        self.score = score
    }

    
}
