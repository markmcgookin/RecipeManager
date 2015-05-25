//
//  AddViewController.swift
//  Recipe Manager
//
//  Created by Mark McGookin on 24/05/2015.
//  Copyright (c) 2015 Mark McGookin. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var recipeContentText: UITextView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2);
        recipeContentText.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2);
        addButton.enabled = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textTitleDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "recipeContentDidChange", name: UITextViewTextDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneButtonClick(sender: AnyObject) {
        recipeContentText.resignFirstResponder()
    }
    
    @IBAction func titleDoneButtonClick(sender: AnyObject) {
        titleText.resignFirstResponder()
    }
    
    func handleDoneButtonState()
    {
        if(titleText.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) != ""
            && recipeContentText.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) != "")
        {
            addButton.enabled = true
        }
        else
        {
            addButton.enabled = false
        }
    }
    
    func textTitleDidChange(){
        handleDoneButtonState()
    }
    
    func recipeContentDidChange()
    {
        handleDoneButtonState()
    }
    
    @IBAction func addButtonClick(sender: AnyObject) {
        
        activityIndicator.startAnimating()
        
        RecipeManager.AddRecipe(titleText.text, content: recipeContentText.text)
        
        NSUserDefaultsManager.Synchronise()
        iCloudManager.sendToCloud()
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.activityIndicator.stopAnimating()
        }
        
        titleText.text = "";
        recipeContentText.text = "";
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
