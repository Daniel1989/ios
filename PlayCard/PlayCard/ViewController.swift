//
//  ViewController.swift
//  PlayCard
//
//  Created by 曹肖鹏 on 2024/11/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var deck = PlayingCardDeck()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }


}

