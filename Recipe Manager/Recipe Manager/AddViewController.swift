//
//  AddViewController.swift
//  Recipe Manager
//
//  Created by Mark McGookin on 24/05/2015.
//  Copyright (c) 2015 Mark McGookin. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIDocumentPickerDelegate {

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
    
    
    @IBAction func iCloudDocsClick(sender: AnyObject) {
        var documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.text"], inMode: UIDocumentPickerMode.Import)
        
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        self.presentViewController(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        
        if(controller.documentPickerMode == UIDocumentPickerMode.Import)
        {
            var content = openFile(url.path!, utf8:NSUTF8StringEncoding)
            recipeContentText.text = content
        }
    }
    
    func openFile(path: String, utf8: NSStringEncoding = NSUTF8StringEncoding) -> String?
    {
        var error: NSError?
        return NSFileManager().fileExistsAtPath(path) ? String(contentsOfFile: path as String, encoding: utf8, error: &error)! : nil
    }
    
}
