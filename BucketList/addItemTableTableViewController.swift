//
//  addItemTableTableViewController.swift
//  BucketList
//
//  Created by Robert on 7/10/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import UIKit

class addItemTableTableViewController: UITableViewController {
    
    var Delegate: BucketListDelegate?
    
    var item: String?
    var indexPath: NSIndexPath?

    @IBOutlet weak var inputTextField: UITextField!

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        Delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if let text = inputTextField.text {
            Delegate?.saveButtonPressed(by: self, with: text, at: indexPath)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
