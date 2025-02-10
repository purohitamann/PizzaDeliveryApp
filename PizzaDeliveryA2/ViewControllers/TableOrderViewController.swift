//
//  TableOrderViewController.swift
//  PizzaDeliveryA1
//
//  Created by Aman Purohit on 2025-03-22.
//


// TableOrderViewController.swift
// Shows all previous orders in a table with avatars

//import UIKit
//import SQLite3
//class TableOrderViewController: UITableViewController {
//
//    var orders: [PizzaOrderData] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadOrdersFromDatabase()
//        tableView.rowHeight = 100
//        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
//        tableView.backgroundView?.contentMode = .scaleAspectFill
//    }
//
//    func loadOrdersFromDatabase() {
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            orders = []
//
//            var db: OpaquePointer? = nil
//            if sqlite3_open(appDelegate.databasePath, &db) == SQLITE_OK {
//                let query = "SELECT * FROM PizzaOrder"
//                var stmt: OpaquePointer?
//
//                if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
//                    while sqlite3_step(stmt) == SQLITE_ROW {
//                        let id = Int(sqlite3_column_int(stmt, 0))
//                        let date = String(cString: sqlite3_column_text(stmt, 1))
//                        let address = String(cString: sqlite3_column_text(stmt, 2))
//                        let size = Int(sqlite3_column_int(stmt, 3))
//                        let meat = String(cString: sqlite3_column_text(stmt, 4))
//                        let veg = String(cString: sqlite3_column_text(stmt, 5))
//                        let avatar = String(cString: sqlite3_column_text(stmt, 6))
//
//                        let order = PizzaOrderData()
//                        order.initWithData(theRow: id, theDate: date, theAddress: address, theSize: size, theMeats: meat, theVeggies: veg, theAvatar: avatar)
//                        orders.append(order)
//                    }
//                    sqlite3_finalize(stmt)
//                }
//                sqlite3_close(db)
//            }
//        }
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return orders.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
//        let order = orders[indexPath.row]
//
//        cell.textLabel?.text = "\(order.address ?? "") | Size: \(order.size)"
//        cell.detailTextLabel?.text = "Meats: \(order.meatToppings ?? "")\nVeggies: \(order.vegToppings ?? "")\nDate: \(order.date ?? "")"
//        cell.imageView?.image = UIImage(named: order.avatar ?? "avatar-1.jpg")
//        cell.imageView?.layer.cornerRadius = 8
//        cell.imageView?.clipsToBounds = true
//
//        return cell
//    }
//}
// TableOrderViewController.swift
// Shows all previous orders in a table with avatars and full details

import UIKit
import SQLite3
class TableOrderViewController: UITableViewController {

    var orders: [PizzaOrderData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadOrdersFromDatabase()

        tableView.rowHeight = 100

        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        backgroundImage.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImage
    }

    func loadOrdersFromDatabase() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            orders = []

            var db: OpaquePointer? = nil
            if sqlite3_open(appDelegate.databasePath, &db) == SQLITE_OK {
                let query = "SELECT * FROM PizzaOrder"
                var stmt: OpaquePointer?

                if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
                    while sqlite3_step(stmt) == SQLITE_ROW {
                        let id = Int(sqlite3_column_int(stmt, 0))
                        let date = String(cString: sqlite3_column_text(stmt, 1))
                        let address = String(cString: sqlite3_column_text(stmt, 2))
                        let size = Int(sqlite3_column_int(stmt, 3))
                        let meat = String(cString: sqlite3_column_text(stmt, 4))
                        let veg = String(cString: sqlite3_column_text(stmt, 5))
                        let avatar = String(cString: sqlite3_column_text(stmt, 6))

                        let order = PizzaOrderData()
                        order.initWithData(theRow: id, theDate: date, theAddress: address, theSize: size, theMeats: meat, theVeggies: veg, theAvatar: avatar)
                        orders.append(order)
                    }
                    sqlite3_finalize(stmt)
                }
                sqlite3_close(db)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        let order = orders[indexPath.row]

        cell.textLabel?.text = "\(order.address ?? "") | Size: \(order.size)"
        cell.detailTextLabel?.text = "Date: \(order.date ?? "")"
        cell.imageView?.image = UIImage(named: order.avatar ?? "avatar-1.jpg")
        cell.imageView?.layer.cornerRadius = 8
        cell.imageView?.clipsToBounds = true
        cell.backgroundColor = .clear

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orders[indexPath.row]

        let message = "Size: \(order.size)\n\nMeats: \(order.meatToppings ?? "")\nVeggies: \(order.vegToppings ?? "")\n\nAddress: \(order.address ?? "")\nDate: \(order.date ?? "")"

        let alert = UIAlertController(title: "Order Details", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
