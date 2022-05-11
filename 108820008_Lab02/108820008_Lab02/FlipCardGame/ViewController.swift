//
//  ViewController.swift
//  FlipCardGame
//
//  Created by Ricky Hu on 2022/3/9.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cards: [UIButton]!
    @IBOutlet var flipLabel: UILabel!
    private var _iconList: [String] = ["🍎", "🥝", "🍍", "🍊", "🍎", "🥝", "🍍", "🍊"]
    private var _flipCount: Int = 0 {
        didSet {
            flipLabel.text = "Flips: \(_flipCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _iconList.shuffle()
        for i in 0...(cards.count - 1) {
            _closeCard(card: cards[i], index: i)
        }
    }
    
    @IBAction func onCardFlip(_ sender: UIButton) {
        let flipIndex = cards.firstIndex(of: sender)!
        
        if sender.currentTitle == "" || sender.currentTitle == nil {
            _openCard(card: sender, index: flipIndex)
        } else {
            _closeCard(card: sender, index: flipIndex)
        }
        
        _flipCount += 1
    }
    
    private func _openCard(card: UIButton, index: Int) {
        card.setTitle("\(_iconList[index])", for: UIControl.State.normal)
        card.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8901960784, blue: 0.8, alpha: 1)
    }
    
    private func _closeCard(card: UIButton, index: Int) {
        card.setTitle("", for: UIControl.State.normal)
        card.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.4823529412, blue: 0.2705882353, alpha: 1)
    }
}
