//
//  RecipeManager.swift
//  Recipe Manager
//
//  Created by Mark McGookin on 24/05/2015.
//  Copyright (c) 2015 Mark McGookin. All rights reserved.
//

import UIKit

class RecipeManager: NSObject {
    
   static var Recipes = [Recipe]()
    
    class func AddRecipe(title: String, content: String)
    {
        var rec = Recipe(title: title, content: content)
        Recipes.append(rec)
    }
    
    class func DeleteRecipe(id: Int)
    {
        Recipes.removeAtIndex(id)
    }
    
    class func GetRecipe(id: Int) -> Recipe
    {
        if(Recipes.count >= (id + 1))
        {
            return Recipes[id]
        }
        
        return Recipe()
    }
    
}
