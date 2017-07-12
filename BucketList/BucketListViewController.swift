//
//  BucketListViewController.swift
//  BucketList
//
//  Created by Robert on 7/10/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, BucketListDelegate {
    
    var bucketList = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Set Segue Destination
        let navController = segue.destination as! UINavigationController
        let addItemController = navController.topViewController as! addItemTableTableViewController
        addItemController.Delegate = self
        
        //
        if sender is UIBarButtonItem {
            
        } else if sender is NSIndexPath {
            let indexPath = sender as! NSIndexPath
            let item = bucketList[indexPath.row]
            addItemController.item = item.text
            addItemController.indexPath = indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketList.count
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //        let data = ["editButton", indexPath] as [Any]
        performSegue(withIdentifier: "BucketTaskSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = bucketList[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
        bucketList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath)
        cell.textLabel?.text = bucketList[indexPath.row].text!
        return cell
    }
    
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            bucketList = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
        
        
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
                let item = bucketList[ip.row]
                item.text = text
            }
            else {
                let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
                item.text = text
                bucketList.append(item)
            }
            do {
                try managedObjectContext.save()
            } catch {
                print("\(error)")
            }
            
            dismiss(animated: true, completion: nil)
            tableView.reloadData()
        }
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
//        let data = ["addButton"]
        performSegue(withIdentifier: "BucketTaskSegue", sender: self)
    }
    
    
}

