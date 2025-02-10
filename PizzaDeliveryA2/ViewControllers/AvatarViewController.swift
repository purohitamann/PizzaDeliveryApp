//
//  AvatarViewController.swift
//  PizzaDeliveryA1
//
//  Created by Aman Purohit on 2025-03-16.
//

import UIKit

class AvatarViewController: UIViewController {

    var selectedAvatarName: String?

    @IBAction func avatar1Tapped(_ sender: UIButton) {
        selectedAvatarName = "avatar-1.jpg"

    }

    @IBAction func avatar2Tapped(_ sender: UIButton) {
        selectedAvatarName = "avatar-2.jpg"

    }

    @IBAction func avatar3Tapped(_ sender: UIButton) {
        selectedAvatarName = "avatar-3.jpg"
        
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


