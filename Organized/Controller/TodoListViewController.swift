//
//  ViewController.swift
//  Organized
//
//  Created by Christopher Rusli  on 9/27/19.
//  Copyright © 2019 Christopher Rusli . All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Task1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Task2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Task3"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    //MARK - TableView DataSource Methods
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    } // Number of Rows function found in a section
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none // Similar to if else statement for accesory type
        
       
        
        return cell
    } // To display the tasks found in the itemArray.
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //Similar to If else statement
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()

        
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen when user click add button
            
        let newItem = Item()
        newItem.title = textField.text!
            
        self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
        self.itemArray.append(newItem)
            
        self.tableView.reloadData()
           

        }
        
            alert.addTextField { (alertTextField) in
                
            alertTextField.placeholder = "Create New Item"
                
            textField = alertTextField
                
        }
       
            alert.addAction(action)
        
            present(alert, animated: true, completion: nil)
            
        
        
    }
    
}

