//
//  ViewController.swift
//  Organized
//
//  Created by Christopher Rusli  on 9/27/19.
//  Copyright © 2019 Christopher Rusli . All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    let itemArray = ["Task1", "Task2", "Task3"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK - TableView DataSource Methods
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    } // Number of Rows function found in a section
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    } // To display the tasks found in the itemArray.
    
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
                
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        }
        else  {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

        
        
    }

}

