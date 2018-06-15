//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gina Sprint on 6/14/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
    }

    //MARK: TableView datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        
        return cell
    }
    
    //MARK: TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(categoryArray[indexPath.row])")
        
        // performSegue() passing in category to load up items from in TodoListViewController's UITableView
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //trigged just before we perform our segue
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! TodoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {// identifies current row that is selected
                // is an optional, could be nil, not likely though because only triggering segue when click on cell
                destinationVC.selectedCategory = categoryArray[indexPath.row]
            }
            
        }
    }

    
    //MARK: Data manipulation methods
    func saveCategory() {
        do {
            try context.save()
        }
        catch {
            print("Error saving categories to DB \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        }
        catch {
            print("Error loading categories from DB \(error)")
        }
        tableView.reloadData()
    }
   

    // MARK: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("addButtonPressed")
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Create New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name of Category"
            alertTextField = textField
        }
        
        let action = UIAlertAction(title: "Create", style: .default) { (alertAction) in
            let text = alertTextField.text!
            let newCategory = Category(context: self.context)
            // have to set name otherwise it is nil and since it is not optional for the entity attribute it will crash  if nil
            newCategory.name = text
            self.categoryArray.append(newCategory)
            // need to saveData to DB
            self.saveCategory()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
}
