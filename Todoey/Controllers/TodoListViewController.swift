//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Gina Sprint on 6/13/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import UIKit
import CoreData // to get Item which is core data managed

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // this is an array so grab first item
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        // since we inherit from UITableViewController, we don't need to set the data source or delegate
        // don't need to set up an IBOutlets
        
        // load up Items.plist
        loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // there is a local and global tableView variable, refer to the same tableView can use either one
        print("In tableView cellForAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        // where do we specify the class of ToDoItemCell
        cell.textLabel?.text = item.title
        
        // ternary in swift
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK - TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row], "clicked!")
        
        //let cell : UITableViewCell? = tableView.cellForRow(at: indexPath)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // remove instead of set check box
//        let removed = itemArray.remove(at: indexPath.row)
//        context.delete(removed)
        self.saveData()
        
        // forces tableView to call its datasource method again to reload data that is inside
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // MARK - add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        // show UIAlert with text field so user can add new item to list
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        // add text field to the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            // store reference to textfield in local var of addButtonPressed() so we can get the text from it
            // later in the action handler
            textField = alertTextField
        }
        
        //button to press
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success")
            print (textField.text!)
            // an alternative way to do without the textField var
            //print(alert.textFields![0].text!)
            let text = textField.text!
            // should add checking code so that the text
            
            // need to get AppDelegate object
            // UIApplication.shared is a singleton, which is current app object
            // cast UIApplicationDelegate? into AppDelegate
            let newItem = Item(context: self.context)
            newItem.title = text
            newItem.done = false
            self.itemArray.append(newItem)
            // force update of table view
            self.tableView.reloadData()
            
            // add to persistent data storage
            // UserDefaults
            // trying to save array of custom Item objects
            // UserDefaults is rejecting because of custom Item objects
//            [User Defaults] Attempt to set a non-property-list object (
//                "Todoey.Item",
//                "Todoey.Item",
//                "Todoey.Item",
//                "Todoey.Item"
//                ) as an NSUserDefaults/CFPreferences value for key TodoListArray
            // need an alternative to store items
            self.saveData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    func saveData() {
        // commit context to permanent storage
        do {
           try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadData() {
        // few cases in swift when you need to specify a data type
        // specify entity you are trying to request
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
    }
}

