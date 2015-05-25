//
//  iCloudManager.swift
//  Recipe Manager
//
//  Created by Mark McGookin on 25/05/2015.
//  Copyright (c) 2015 Mark McGookin. All rights reserved.
//

import UIKit

class iCloudManager: NSObject {
    
    class func getFromCloud() {
        let iCloudStore = NSUbiquitousKeyValueStore.defaultStore()
        let fromiCloud = iCloudStore.objectForKey("recipeArray") as! NSData
        RecipeManager.Recipes = NSKeyedUnarchiver.unarchiveObjectWithData(fromiCloud) as! [Recipe]!
    }
    
    class func sendToCloud() {
        let myData = NSKeyedArchiver.archivedDataWithRootObject(RecipeManager.Recipes)
        let iCloudStore = NSUbiquitousKeyValueStore.defaultStore()
        iCloudStore.setObject(myData, forKey: "recipeArray")
        
        iCloudStore.synchronize()   
    }
   
}
