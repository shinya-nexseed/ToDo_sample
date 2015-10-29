//
//  ViewController.swift
//  CoreDataSample3
//
//  Created by Shinya Hirai on 2015/10/29.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var todoList:NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        readData()
        
        tableView.reloadData()
    }

    func readData() {
        
        todoList = []
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let managedObjectContext = appDelegate.managedObjectContext {
            let entityDiscription = NSEntityDescription.entityForName("Todo", inManagedObjectContext: managedObjectContext);
            
            let fetchRequest = NSFetchRequest(entityName: "Todo")
            fetchRequest.entity = entityDiscription;
            
            var error: NSError? = nil;
            
            // フェッチリクエストの実行
            if var results = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) {
                println(results.count)
                for managedObject in results {
                    let todo = managedObject as! Todo
                    println("title: \(todo.title), saveDate: \(todo.saveDate)")
                    todoList.addObject(todo.title)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return todoList.count
        return todoList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "\(todoList[indexPath.row])"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("削除するTodo : \(todoList[indexPath.row])")
        
        var deleteTodo = todoList[indexPath.row] as! String
        println(deleteTodo)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let managedObjectContext = appDelegate.managedObjectContext {
            let entityDiscription = NSEntityDescription.entityForName("Todo", inManagedObjectContext: managedObjectContext);
            
            let fetchRequest = NSFetchRequest(entityName: "Todo")
            fetchRequest.entity = entityDiscription
            
            let predicate = NSPredicate(format: "%K = %@", "title", deleteTodo)
            fetchRequest.predicate = predicate
            
            var error: NSError? = nil;
            
            // フェッチリクエストの実行
            if var results = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) {
                println(results.count)
                for managedObject in results {
                    let todo = managedObject as! Todo
                    println("title: \(todo.title), saveDate: \(todo.saveDate)")
                    todoList.addObject(todo.title)
                    
                    managedObjectContext.deleteObject(managedObject as! NSManagedObject)

                    appDelegate.saveContext()
                }
            }
        }
        
        readData()
        
        tableView.reloadData()
    }


}

