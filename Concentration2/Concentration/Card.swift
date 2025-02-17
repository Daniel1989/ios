//
//  Card.swift
//  Concentration
//
//  Created by Daniel on 2024/9/14.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
//    var  hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
