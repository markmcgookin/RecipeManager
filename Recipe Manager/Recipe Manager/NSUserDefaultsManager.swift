//
//  NSUserDefaultsManager.swift
//  Recipe Manager
//
//  Created by Mark McGookin on 25/05/2015.
//  Copyright (c) 2015 Mark McGookin. All rights reserved.
//

import UIKit

class NSUserDefaultsManager: NSObject {
   
    static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    class func Synchronise()
    {
        let myData = NSKeyedArchiver.archivedDataWithRootObject(RecipeManager.Recipes)
        
        userDefaults.setObject(myData, forKey: "recipeArray")
        userDefaults.synchronize()
    }
    
    class func initializeDefaults(){
        if let recipesRaw = userDefaults.dataForKey("recipeArray") {
            if let recipes = NSKeyedUnarchiver.unarchiveObjectWithData(recipesRaw) as? [Recipe] {
                RecipeManager.Recipes = recipes
            }
        }
    }
    
}
