//
//  PizzaOrderData.swift
//  PizzaDeliveryA1
//
//  Created by Aman Purohit on 2025-03-22.
//


import Foundation

class PizzaOrderData {
    var id: Int = -1
    var date: String?
    var address: String?
    var size: Int = 0
    var meatToppings: String?
    var vegToppings: String?
    var avatar: String?

    func initWithData(theRow i: Int, theDate d: String, theAddress a: String, theSize s: Int, theMeats m: String, theVeggies v: String, theAvatar av: String) {
        id = i
        date = d
        address = a
        size = s
        meatToppings = m
        vegToppings = v
        avatar = av
    }
}
