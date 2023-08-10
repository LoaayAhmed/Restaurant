//
//  CategoryTableViewController.swift
//  Loaays Restaurant
//
//  Created by user203868 on 8/5/23.
//


import UIKit

class CategoryTableViewController: UITableViewController {
    
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuController.shared.fetchCategories { (categories) in
            
            
            if let categories = categories  {
                self.updateUI(with: categories)
            }
            
            
            
        }
   }
    
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            
            self.categories = categories
            self.tableView.reloadData()
        }
    }

    		override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSeque" {
            let menuTableViewController = segue.destination as! MenuTableViewController
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let index = selectedIndexPath.row
                menuTableViewController.category = categories[index]
            }
        }
    }
}
