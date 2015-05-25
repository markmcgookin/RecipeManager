//
//  DetailViewController.swift
//  Recipe Manager
//
//  Created by Mark McGookin on 24/05/2015.
//  Copyright (c) 2015 Mark McGookin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var recipeContentText: UITextView!
    var PreRecipe:Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeContentText.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2);
        self.title = PreRecipe?.Title
        self.recipeContentText.text = PreRecipe?.Content
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
