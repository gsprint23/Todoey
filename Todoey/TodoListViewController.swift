//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Gina Sprint on 6/13/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // since we inherit from UITableViewController, we don't need to set the data source or delegate
        // don't need to set up an IBOutlets
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // there is a local and global tableView variable, refer to the same tableView can use either one
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        // where do we specify the class of ToDoItemCell
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK - TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row], "clicked!")
        
        let cell : UITableViewCell? = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        }
        else {
            cell?.accessoryType = .checkmark
        }
        
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
            self.itemArray.append(text)
            // force update of table view
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

