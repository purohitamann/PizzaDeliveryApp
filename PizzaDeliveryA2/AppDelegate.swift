//
//  AppDelegate.swift
//  PizzaDeliveryA2
//
//  Created by Aman Purohit on 2025-02-10.
//

//import UIKit
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//
//}
//
import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var databaseName: String? = "PizzaOrderDB.db"
    var databasePath: String?
    var orders: [PizzaOrderData] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]
        databasePath = documentsDir.appending("/" + databaseName!)

        createPizzaOrderTable()
        return true
    }

    func createPizzaOrderTable() {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: databasePath!) {
            let dbPathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
            try? fileManager.copyItem(atPath: dbPathFromApp!, toPath: databasePath!)
        }

        var db: OpaquePointer? = nil
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            let createTableQuery = """
            CREATE TABLE IF NOT EXISTS PizzaOrder (
                ID INTEGER PRIMARY KEY AUTOINCREMENT,
                DeliveryDate TEXT,
                Address TEXT,
                Size INTEGER,
                MeatToppings TEXT,
                VegToppings TEXT,
                Avatar TEXT
            );
            """

            if sqlite3_exec(db, createTableQuery, nil, nil, nil) == SQLITE_OK {
                print("PizzaOrder table created")
            } else {
                print("Error creating PizzaOrder table")
            }

            sqlite3_close(db)
        }
    }

    func insertPizzaOrder(order: PizzaOrderData) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode = true

        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            let insertQuery = "INSERT INTO PizzaOrder VALUES (NULL, ?, ?, ?, ?, ?, ?);"
            var insertStmt: OpaquePointer?

            if sqlite3_prepare_v2(db, insertQuery, -1, &insertStmt, nil) == SQLITE_OK {
                let dateStr = order.date! as NSString
                let addrStr = order.address! as NSString
                let meatStr = order.meatToppings! as NSString
                let vegStr = order.vegToppings! as NSString
                let avatarStr = order.avatar! as NSString

                sqlite3_bind_text(insertStmt, 1, dateStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStmt, 2, addrStr.utf8String, -1, nil)
                sqlite3_bind_int(insertStmt, 3, Int32(order.size))
                sqlite3_bind_text(insertStmt, 4, meatStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStmt, 5, vegStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStmt, 6, avatarStr.utf8String, -1, nil)

                if sqlite3_step(insertStmt) == SQLITE_DONE {
                    print(" Pizza order inserted")
                } else {
                    print(" Failed to insert pizza order")
                    returnCode = false
                }
                sqlite3_finalize(insertStmt)
            } else {
                print(" Prepare INSERT failed")
                returnCode = false
            }
            sqlite3_close(db)
        } else {
            print(" Unable to open database")
            returnCode = false
        }

        return returnCode
    }
}
