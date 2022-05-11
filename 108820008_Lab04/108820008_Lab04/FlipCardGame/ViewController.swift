//
//  ViewController.swift
//  FlipCardGame
//
//  Created by Ricky Hu on 2022/3/9.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var flipLabel: UILabel!
    @IBOutlet var flipAllButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    private lazy var _game: MatchingGame = MatchingGame(numberOfPairs: cardButtons.count / 2)
    private var _iconDict: Dictionary<Int, String> = [:]
    private var _icons = ["🍎", "🥝", "🍍", "🍊", "🍌", "🍉", "🍓", "🍑"]
    private var _flipCount: Int = 0 {
        didSet {
            flipLabel.text = "Flips: \(_flipCount)"
        }
    }
    private var _isRevealAllCards: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for cardButton in cardButtons {
            cardButton.setTitle("", for: UIControl.State.normal)
        }
    }
    
    @IBAction func onFlipAllClick(_ sender: Any) {
        if _isRevealAllCards {
            _updateViewFromModel()
        } else {
            for index in _game.cards.indices {
                cardButtons[index].setTitle("\(_getIcon(for: _game.cards[index]))", for: UIControl.State.normal)
                cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
        _isRevealAllCards = !_isRevealAllCards
    }
    
    @IBAction func onResetClick(_ sender: Any) {
        _game.resetGame()
        _updateViewFromModel()
        _flipCount = 0
    }
    
    
    @IBAction func onCardFlip(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            print("cardIndex = \(cardIndex)")
            
            _game.chooseCard(at: cardIndex)
            _updateViewFromModel()
            if !_game.cards[cardIndex].isMatched {
                _flipCount += 1
            }
            
        } else {
            print("card not in collection")
        }
    }
    
    private func _updateViewFromModel() {
        for index in cardButtons.indices {
            let cardButton = cardButtons[index]
            let card = _game.cards[index]
            
            if card.isFaceUp {
                cardButton.setTitle("\(_getIcon(for: card))", for: UIControl.State.normal)
                cardButton.backgroundColor = card.isMatched ? #colorLiteral(red: 0.8980392157, green: 0.8901960784, blue: 0.8, alpha: 0) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                cardButton.setTitle("", for: UIControl.State.normal)
                cardButton.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.4823529412, blue: 0.2705882353, alpha: 1)
            }
        }
    }
    
    private func _getIcon(for card: Card) -> String {
        if _iconDict[card.iconIndex] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(_icons.count)))
            _iconDict[card.iconIndex] = _icons.remove(at: randomIndex)
        }
        return _iconDict[card.iconIndex] ?? "?"
    }
}
