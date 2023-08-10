//
//  MenuItemDetailViewController.swift
//  Loaays Restaurant
//
//  Created by user203868 on 8/5/23.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    var menuItem = MenuItem.defaultItem
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var detailTextLabel: UILabel!
    @IBOutlet var addToOrderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        addToOrderButton.layer.cornerRadius = 5.0
    }

    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        detailTextLabel.text = menuItem.description
        
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }

    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }

        MenuController.shared.order.menuItems.append(menuItem)
        print(MenuController.shared.order.menuItems.count)
    }
}
