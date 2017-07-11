//
//  BucketListDelegate.swift
//  BucketList
//
//  Created by Robert on 7/10/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import UIKit

protocol BucketListDelegate {
    func cancelButtonPressed(by controller: UITableViewController)
    func saveButtonPressed(by controller: UITableViewController, with text: String, at indexPath: NSIndexPath?)
}

