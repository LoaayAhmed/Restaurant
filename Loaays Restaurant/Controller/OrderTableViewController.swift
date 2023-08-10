//
//  OrderTableViewController.swift
//  Loaays Restaurant
//
//  Created by user203868 on 8/5/23.
//


import UIKit

class OrderTableViewController: UITableViewController {
    
    
    var orderMinutes = 0
    
    override func viewDidAppear(_ _animated: Bool) {
        print(MenuController.shared.order.menuItems.count)
        tableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuController.shared.order.menuItems.count
        
    }

   
  func configure(_ cell: UITableViewCell, forItemAt indexPath:
     IndexPath) {
    
     let menuItem =
            MenuController.shared.order.menuItems [indexPath.row]
    
     cell.textLabel?.text = menuItem.name
    
     cell.detailTextLabel?.text = String(format: "$%.2f",
        menuItem.price)
    
    MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
        guard let image = image else { return }
        DispatchQueue.main.async {
            cell.imageView?.image =  image
        }
 
     }
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            MenuController.shared.order.menuItems.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
    }
    
    
    
    
    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal = MenuController.shared.order.menuItems.reduce(0.0) { (result, menuItem) -> Double in
            return result + menuItem.price
    }
    
        let formattedOrder = String(format: "$%.2f", orderTotal)
        
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in

            self.uploadOrder()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    func uploadOrder() {
        let menuIDs = MenuController.shared.order.menuItems.map
            { $0.id }
        MenuController.shared.submitOrder(forMenuIDs: menuIDs)
    { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier:
                    "ConfirmationSegue", sender: nil)
                }
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
        if segue.identifier == "ConfirmationSegue" {
            let orderConfirmationViewController = segue.destination
            as! OrderConfirmationViewController
            orderConfirmationViewController.minutes = orderMinutes
        }
    }

}
