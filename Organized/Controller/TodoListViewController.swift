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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") //Create an internal plist database name Items.plist
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadItems()
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
        
        saveItems()
        
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
            
        self.saveItems()
            
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
    
    // MARK - Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder() // Encoder Initializer
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        } catch {
            print("Error encoding item array \(error)")
            
        }
    }
    
    func loadItems (){
       if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
        do {
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding \(error)")
            }
        }
    }
    
}

