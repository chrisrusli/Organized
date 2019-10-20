//
//  ViewController.swift
//  Organized
//
//  Created by Christopher Rusli  on 9/27/19.
//  Copyright © 2019 Christopher Rusli . All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask), //Database can be found at Library/Application Support instead of going to documents.
        

        
       
        
    }
    
    //MARK: - TableView DataSource Methods
  
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
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
        // To Delete data in the itemArray
        
        context.delete(itemArray[indexPath.row])
        
        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //Similar to If else statement
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()

        
        
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen when user click add button
         
       
            
        let newItem = Item(context: self.context)
        newItem.title = textField.text!
        newItem.parentCategory = self.selectedCategory
        newItem.done = false
            
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
    
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        do{
            try context.save()
        } catch {
           print("Error Saving Context \(error)")
            
        }
    }
    
    
    
    func loadItems (with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }
        
        else {
            request.predicate = categoryPredicate
        }
        
        //let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        //request.predicate = compoundPredicate
        
        do {
          itemArray = try context.fetch(request)
        } catch {
            print("Error Loading Context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    
}

//MARK: - Search Bar Method
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

