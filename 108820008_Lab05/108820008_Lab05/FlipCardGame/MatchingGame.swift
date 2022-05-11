//
//  MatchingGame.swift
//  FlipCardGame
//
//  Created by Ricky Hu on 2022/3/16.
//

import Foundation
import UIKit

class MatchingGame {
    var cards: [Card] = []
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp && !cards[index].isMatched {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set (value) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == value)
                if cards[index].isMatched {
                    cards[index].isFaceUp = true
                }
            }
        }
    }
    
    init(numberOfPairs: Int) {
        for index in 1...numberOfPairs {
            let card = Card(iconIndex: index)
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].iconIndex == cards[index].iconIndex {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
            } else if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex == index {
                cards[index].isFaceUp = false
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func resetGame() {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        cards.shuffle()
    }
}
