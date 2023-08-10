//
//  MenuTableViewController.swift
//  Loaays Restaurant
//
//  Created by user203868 on 8/5/23.
//


import UIKit


class MenuTableViewController: UITableViewController {
    
    
    let menuCtrl = MenuController()
    var menuItems = [MenuItem]()
    var category =  String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.capitalized
        menuCtrl.fetchMenuItems(forCategory:category)
        { (menuItems) in
            if let menuItems = menuItems {
                self.updateUI(with: menuItems)
            }
        }
    }

    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }




    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
        
    }

    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format:  "$%.2f", menuItem.price)
        
    
          MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            
              guard let image = image else { return }
            
              DispatchQueue.main.async {
                     if let currentIndexPath =  self.tableView.indexPath(for: cell),
                        currentIndexPath != indexPath {
                    
                     return
                }
                 cell.imageView?.image = image
                 cell.setNeedsLayout()
             }
          }
        
     }

    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue" {
            let menuItemDetailViewController = segue.destination as! MenuItemDetailViewController
            if  let index = tableView.indexPathForSelectedRow?.row {
                menuItemDetailViewController.menuItem = menuItems[index]
        }
    }
      }
}
