//
//  OrderViewController.swift
//  PizzaDeliveryA1
//
//  Created by Navya Vohra on 2025-02-10.
//

import UIKit


import UIKit

class OrderViewController: UIViewController {
    

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var sizeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var orderSummaryLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        if let avatar = selectedAvatarName {
            avatarImageView.image = UIImage(named: avatar)
        }
    }
    
//    @IBAction func placeOrderPressed(_ sender: UIButton) {
//        let address = addressTextField.text ?? "No address provided"
//        let size = sizeSegmentedControl.titleForSegment(at: sizeSegmentedControl.selectedSegmentIndex) ?? "No size selected"
//        orderSummaryLabel.text = "Address: \(address)\nSize: \(size)"
//    }
//
    @IBAction func placeOrderPressed(_ sender: UIButton) {
        let address = addressTextField.text ?? "No address"
        let sizeIndex = sizeSegmentedControl.selectedSegmentIndex
        let meatToppings = "Pepperoni,Bacon"
        let vegToppings = "Mushrooms,Peppers"
        let avatar = selectedAvatarName ?? "avatar-1.jpg"

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date())

        let order = PizzaOrderData()
        order.initWithData(theRow: 0, theDate: date, theAddress: address, theSize: sizeIndex, theMeats: meatToppings, theVeggies: vegToppings, theAvatar: avatar)

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            _ = appDelegate.insertPizzaOrder(order: order)
        }

        orderSummaryLabel.text = "Order placed!\n\(address)\nSize: \(sizeIndex)"
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    var selectedAvatarName: String?
    
    @IBAction func unwindToOrder(_ segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AvatarViewController {
            if let selectedAvatar = sourceVC.selectedAvatarName {
                avatarImageView.image = UIImage(named: selectedAvatar)
                self.selectedAvatarName = selectedAvatar
            }
        }
    }
   

   

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


