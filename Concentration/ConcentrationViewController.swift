//
//  ViewController.swift
//  Concentration
//
//  Created by Daniel on 2024/9/12.
//

import UIKit

class CustomTapGesture: UITapGestureRecognizer {
    var customParameter: Int?
}

class ConcentrationViewController: UIViewController {
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    var flipCount = 0 {
        didSet {
            updateFilpCountLabel()
        }
    }
    
    private func updateFilpCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.black
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes )
        flipCountLabel.attributedText = attributedString
    }
    
    var theme: String? {
        didSet {
            print(theme)
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    //    var emojiChoices = ["👻","🎃", "😶‍🌫️", "🤬", "🫥", "🫶"]
    private var emojiChoices = "👻🎃😶‍🌫️🤬🫥🫶"
    
    
    private var emoji =  [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return  emoji[card] ?? "?"
    }
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            updateFilpCountLabel()
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = UIColor.gray
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.blue
                }
                // 第一个点击走的是touch事件
                // 在这里由于重新覆盖之前的touch，所以不走tap，走了这里
                // 使用CustomTap来传递额外参数
                let tapGesture = CustomTapGesture(target: self, action: #selector(filpCardWithTap(_:)))
                
                button.addGestureRecognizer(tapGesture)
                tapGesture.customParameter = index
                
            }
        }
        
    }
    
    private var faceUpCardView: [UIButton] {
        return cardButtons.filter {
            !$0.isHidden && $0.backgroundColor != UIColor.blue
        }
    }
    
    private var faceUPCardViewMatch: Bool {
        return faceUpCardView.count == 2 && faceUpCardView[0].currentTitle == faceUpCardView[1].currentTitle
    }
    
    @objc func filpCardWithTap(_ recognizer: CustomTapGesture) {
        print("hahah")
        let index = recognizer.customParameter!
        
        switch recognizer.state {
        case .ended:
            game.chooseCard(at: index)
            let card = game.cards[index]
            if card.isFaceUp {
                
                if let chosenCardView = recognizer.view as? UIButton {
                    chosenCardView.setTitle(emoji(for: card), for: UIControl.State.normal)
                    chosenCardView.backgroundColor = UIColor.gray
                    chosenCardView.titleLabel?.font = UIFont.systemFont(ofSize: 40)
                    cardBehavir.removeItem(chosenCardView);                    UIView.transition(with: chosenCardView,
                                      duration: 0.6,
                                      options: [.transitionFlipFromLeft],
                                      animations: {
                        
                    },
                                      completion: {
                        finished in
                        if self.faceUPCardViewMatch {
                            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6, delay: 0, animations: {
                                self.faceUpCardView.forEach {
                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                }
                            },
                                                                           completion: { position in
                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.75, delay: 0, animations: {
                                    self.faceUpCardView.forEach {
                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                        $0.alpha = 0
                                    }
                                },
                                                                               completion: {
                                    position in
                                    self.faceUpCardView.forEach {
                                        $0.isHidden = true
                                        $0.alpha = 1
                                        $0.transform = .identity
                                    }
                                }
                                )
                                
                                
                            }
                            )
                        }
                        else if self.faceUpCardView.count == 2 {
                            self.faceUpCardView.forEach { tempView in
                                UIView.transition(with: tempView, duration: 0.6,
                                                  options: [.transitionFlipFromLeft],
                                                  animations: {
                                    tempView.backgroundColor = UIColor.blue
                                    tempView.setTitle("", for: UIControl.State.normal)
                                    
                                },
                                                  completion:  {
                                    finished in
                                    self.cardBehavir.addItem(tempView)
                                }
                                )
                            }
                        } else {
                            if !chosenCardView.isHidden {
                                self.cardBehavir.addItem(chosenCardView)
                            }
                        }
                    }
                    )
                    
                }
                
            } else {
                if let chosenCardView = recognizer.view as? UIButton {
                    chosenCardView.setTitle("", for: UIControl.State.normal)
                    chosenCardView.backgroundColor = card.isMatched ? UIColor.clear : UIColor.blue
                }
            }
        default:
            break
            
        }
    }
    
    lazy var cardBehavir = CardBehavior(in: animator)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in cardButtons.indices {
            let tapGesture = CustomTapGesture(target: self, action: #selector(filpCardWithTap(_:)))
            tapGesture.customParameter = index
            let button = cardButtons[index]
            button.addGestureRecognizer(tapGesture)
            cardBehavir.addItem(button)
//            let push = UIPushBehavior(items: [button], mode: .instantaneous)
//            push.angle = CGFloat((Int(2*CGFloat.pi)).arc4random)
//            push.magnitude = CGFloat(1.0) + CGFloat((Int(2)).arc4random)
//            push.action = { [unowned push] in
//                push.dynamicAnimator?.removeBehavior(push)
//            }
//            animator.addBehavior(push)
        }
        // Do any additional setup after loading the view.
    }
    
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return -1
        }
    }
}
