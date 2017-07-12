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
            tableView.reloadData()
        }
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let data = ["addButton"]
        performSegue(withIdentifier: "BucketTaskSegue", sender: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let addItemController = navController.topViewController as! addItemTableTableViewController
        addItemController.Delegate = self
        if let data: Array<Any> = sender as? Array<Any>{
            if String(describing: data[0]) == "addButton" {
                
            }
            if String(describing: data[0]) == "editButton" {
                let indexPath = data[1] as! NSIndexPath
                let item = bucketList[indexPath.row]
                addItemController.item = item
                addItemController.indexPath = indexPath
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketList.count
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let data = ["editButton", indexPath] as [Any]
        performSegue(withIdentifier: "BucketTaskSegue", sender: data)
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

