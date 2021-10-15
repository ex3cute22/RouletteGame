//
//  Model.swift
//  RouletteGame
//
//  Created by Илья Викторов on 16.10.2021.
//

import Foundation

enum ColorItem: String {
    case red = "RED"
    case black = "BLACK"
    case green = "ZERO"
}

struct Sector: Equatable {
    let number: Int
    let color: ColorItem
}

struct Game{
    var sector : Sector
    var date : Date
    var profit : Float
    var win : Bool
}


        
var sectors: [Sector] = [Sector(number: 32, color: .red),
                         Sector(number: 15, color: .black),
                         Sector(number: 19, color: .red),
                         Sector(number: 4, color: .black),
                         Sector(number: 21, color: .red),
                         Sector(number: 2, color: .black),
                         Sector(number: 25, color: .red),
                         Sector(number: 17, color: .black),
                         Sector(number: 34, color: .red),
                         Sector(number: 6, color: .black),
                         Sector(number: 27, color: .red),
                         Sector(number: 13, color: .black),
                         Sector(number: 36, color: .red),
                         Sector(number: 11, color: .black),
                         Sector(number: 30, color: .red),
                         Sector(number: 8, color: .black),
                         Sector(number: 23, color: .red),
                         Sector(number: 10, color: .black),
                         Sector(number: 5, color: .red),
                         Sector(number: 24, color: .black),
                         Sector(number: 16, color: .red),
                         Sector(number: 33, color: .black),
                         Sector(number: 1, color: .red),
                         Sector(number: 20, color: .black),
                         Sector(number: 14, color: .red),
                         Sector(number: 31, color: .black),
                         Sector(number: 9, color: .red),
                         Sector(number: 22, color: .black),
                         Sector(number: 18, color: .red),
                         Sector(number: 29, color: .black),
                         Sector(number: 7, color: .red),
                         Sector(number: 28, color: .black),
                         Sector(number: 12, color: .red),
                         Sector(number: 35, color: .black),
                         Sector(number: 3, color: .red),
                         Sector(number: 26, color: .black),
                         Sector(number: 0, color: .green)].shuffled()
    

let player = "Ilya Viktorov"
//var balance : Float{
//    set{
//        UserDefaults.standard.set(newValue, forKey: "BalanceUser")
//    }
//    get{
//        UserDefaults.standard.object(forKey: "BalanceUser") as? Float ?? 5000.0
//    }
//}

enum Raise : Int {
    case redBlack = 1
    case green = 13
}

class UserSettings: ObservableObject {
    var balance: Float {
        didSet {
            UserDefaults.standard.set(balance, forKey: "BalanceUser")
        }
    }

    init() {
        self.balance = UserDefaults.standard.object(forKey: "BalanceUser") as? Float ?? 5000.0
    }
}

let lastGames = [
    Game(sector: Sector(number: 32, color: .red), date: Date(), profit: 1000.0, win: true),
    Game(sector: Sector(number: 20, color: .black), date: Date(), profit: 2000.0, win: false),
    Game(sector: Sector(number: 0, color: .green), date: Date(), profit: 14631.0, win: true),
    ]
