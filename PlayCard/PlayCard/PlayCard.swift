//
//  PlayCard.swift
//  PlayCard
//
//  Created by 曹肖鹏 on 2024/11/27.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    var suit: Suit
    var rank: Rank
    
    var description: String {
        return "\(rank)\(suit)"
    }
    
    enum Suit: String {
//        var description: String
        case spades = "♠️"
        case hearts = "❤️"
        case clubs = "♣️"
        case diamonds = "♦️"
        
        static var all = [Suit.spades, .hearts, .clubs, .diamonds]
    }
    
    enum Rank {
//        var description: String
        
        case ace
        case face(String)
        case numerice(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numerice(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default:
                return 0
                
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numerice(pips))
            }
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
        
    }
}
