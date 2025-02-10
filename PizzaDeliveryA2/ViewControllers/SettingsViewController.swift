////
////  SettingsViewController.swift
////  PizzaDeliveryA1
////
////  Created by Navya Vohra on 2025-02-10.
////
//
//
//
//import UIKit
//
//class SettingsViewController: UIViewController {
//    
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var phoneNumberTextField: UITextField!
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var confirmationLabel: UILabel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//                confirmationLabel.text = ""
//    }
//    
//    @IBAction func updateButtonTapped(_ sender: UIButton) {
//       
//        let email = emailTextField.text ?? "No email entered"
//        let phone = phoneNumberTextField.text ?? "No phone number entered"
//        let name = nameTextField.text ?? "No name entered"
//        
//       
//        confirmationLabel.text = "Details Updated:\nEmail: \(email)\nPhone: \(phone)\nName: \(name)"
//    }
//    
//    @IBAction func goOnlineButtonTapped(_ sender: UIButton) {
//      
//        print("Go online action triggered")
//    }
//}
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//
//
//  SettingsViewController.swift
//  PizzaDeliveryA1
//
//  Created by Navya Vohra on 2025-02-10.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var confirmationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load saved data from UserDefaults
        let defaults = UserDefaults.standard
        nameTextField.text = defaults.string(forKey: "lastName")
        phoneNumberTextField.text = defaults.string(forKey: "lastPhone")
        emailTextField.text = defaults.string(forKey: "lastEmail")

        confirmationLabel.text = ""
    }

    @IBAction func updateButtonTapped(_ sender: UIButton) {
        let email = emailTextField.text ?? "No email entered"
        let phone = phoneNumberTextField.text ?? "No phone number entered"
        let name = nameTextField.text ?? "No name entered"

        // Save data to UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "lastName")
        defaults.set(phone, forKey: "lastPhone")
        defaults.set(email, forKey: "lastEmail")

        confirmationLabel.text = "Details Updated:\nEmail: \(email)\nPhone: \(phone)\nName: \(name)"
    }

    @IBAction func goOnlineButtonTapped(_ sender: UIButton) {
        print("Go online action triggered")
    }

    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
