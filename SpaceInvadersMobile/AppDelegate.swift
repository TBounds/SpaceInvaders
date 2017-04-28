//
//  AppDelegate.swift
//  SpaceInvadersMobile
//
//  Created by Tyler James Bounds on 4/11/17.
//  Copyright © 2017 Tyler James Bounds. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var level : Int = 1
    var score : Int = 100
    var won : Bool = false
    
    var highscore : Int = 0
    var highscores : [Highscore] = []
    
    

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch. 
        
//        var a1 = Array(1...10)
//        NSLog("\(a1)")
//        a1.insert(7, at: 4)
//        NSLog("\(a1)")
        
        for i in 0 ..< 10 {
            
            let name = "Player " + "\(i)"
            let score = 50
            saveHighscore(name: name, score: score)
            
            
        }
        
        
        return true
    }
    
    func isHighScore() -> Bool {
        
        if highscores.count < 10  && score > 0 {
            return true
        }
        
        for i in 0 ..< highscores.count {
            if score >= highscores[i].score {
                return true
            }
        }
        
        return false
    }
    
    func saveHighscore(name: String, score: Int) {
        
        let newScore = Highscore(name: name, score: score)
        
        // Add the new score and sort the highscore list.
        if highscores.count < 10 {
            
            highscores.append(newScore)
            
            highscores = highscores.sorted(by: {$0.score > $1.score})
        }
        else {
            // Insert new score in the correct spot and remove the last score.
            for i in 0 ..< 10 {
                if score >= highscores[i].score {
                    highscores.insert(newScore, at: i)
                    highscores.remove(at: 9)
                    break
                }
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

