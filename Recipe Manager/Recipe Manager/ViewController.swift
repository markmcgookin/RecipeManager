//
//  ViewController.swift
//  Recipe Manager
//
//  Created by Mark McGookin on 24/05/2015.
//  Copyright (c) 2015 Mark McGookin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.rowHeight = 70;
        
        NSUserDefaultsManager.initializeDefaults()
        initializeiCloud()
        
}
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        tableView.reloadData()
        navigationController?.navigationBar.alpha = 0.5;
    }
    
    func initializeiCloud() {
        let fileManager = NSFileManager.defaultManager()
        let iCloudUrl = fileManager.ubiquityIdentityToken
        
        if(iCloudUrl != nil && Reachability.isConnectedToNetwork()) {
            let store = NSUbiquitousKeyValueStore.defaultStore()
            let notification = NSNotificationCenter.defaultCenter()
            
            notification.addObserver(self, selector: "updateFromiCloud:", name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: store)
            
            store.synchronize()
        }
    }
    
    func updateFromiCloud(notification: NSNotification) {
        iCloudManager.getFromCloud()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeManager.Recipes.count;
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete) {
            RecipeManager.DeleteRecipe(indexPath.item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            NSUserDefaultsManager.Synchronise()
            iCloudManager.sendToCloud() 
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell") as! UITableViewCell as! CustomTableViewCell
        var rec = RecipeManager.Recipes[indexPath.item]
        cell.textLabel?.text = rec.Title
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.CellRecipe = rec
        
        //Set the cell background alternatly
        if(indexPath.item % 2 == 0)
        {
            cell.backgroundColor = UIColor.clearColor();
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0);
        }
        else
        {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2);
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0);
        }
        
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "detailView")
        {
            let cell = sender as! CustomTableViewCell;
            let detailView = segue.destinationViewController as! DetailViewController
            detailView.PreRecipe = cell.CellRecipe
        }
    }
}

