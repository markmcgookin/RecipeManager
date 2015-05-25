//
//  Recipe.swift
//  Recipe Manager
//
//  Created by Mark McGookin on 24/05/2015.
//  Copyright (c) 2015 Mark McGookin. All rights reserved.
//

import UIKit

class Recipe: NSObject, NSCoding{
    var Title: String?
    var Content: String?
    
    //Blank overridden constructor
    override init() {
        super.init()
    }
    
    //Normal initialisation
    init(title: String, content: String) {
        self.Title = title
        self.Content = content
    }
    
    required init(coder aDecoder: NSCoder){
        if let titleDecoded: String = aDecoder.decodeObjectForKey("title") as? String {
            Title = titleDecoded
        }
        
        if let contentDecoded: String = aDecoder.decodeObjectForKey("content") as? String {
            Content = contentDecoded
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        if let titleEncoded = Title {
            aCoder.encodeObject(titleEncoded, forKey: "title")
        }
        
        if let contentEncoded = Content {
            aCoder.encodeObject(contentEncoded, forKey: "content")
        }
    }
}
