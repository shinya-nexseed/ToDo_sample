//
//  DetailViewController.swift
//  CoreDataSample3
//
//  Created by Shinya Hirai on 2015/10/29.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        textField.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapReturnKey(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let managedObjectContext = appDelegate.managedObjectContext {
            let managedObject: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Todo", inManagedObjectContext: managedObjectContext)
            
            let todo = managedObject as! Todo
            todo.title = textField.text!
            todo.saveDate = NSDate()
            
            appDelegate.saveContext()
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
