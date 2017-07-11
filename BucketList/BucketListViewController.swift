//
//  BucketListViewController.swift
//  BucketList
//
//  Created by Robert on 7/10/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, BucketListDelegate {
    
    var bucketList = ["Spain", "Italy"]

    @IBOutlet var bucketTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    func cancelButtonPressed(by: UITableViewController) {
        print("Cancel by Bucket List View Controler")
        dismiss(animated: true, completion: nil)
    }
    
    func saveButtonPressed(by controller: UITableViewController, with text: String, at indexPath: NSIndexPath?){
        
        if text == "" {
            print("Text Empty")
        }
        else {
            if let ip = indexPath {
                bucketList[ip.row] = text
            }
            else {
                bucketList.append(text)
            }
            dismiss(animated: true, completion: nil)
            bucketTableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addSegue" {
            let navController = segue.destination as! UINavigationController
            let addItemController = navController.topViewController as! addItemTableTableViewController
            addItemController.Delegate = self
        } else {
            let navController = segue.destination as! UINavigationController
            let addItemController = navController.topViewController as! addItemTableTableViewController
            addItemController.Delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = bucketList[indexPath.row]
            addItemController.item = item
            addItemController.indexPath = indexPath
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketList.count
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        bucketList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath)
        cell.textLabel?.text = bucketList[indexPath.row]
        return cell
    }
}

