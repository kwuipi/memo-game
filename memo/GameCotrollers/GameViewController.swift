//
//  ViewController.swift
//  memo
//
//  Created by Artsiom Sadyryn on 12/27/17.
//  Copyright © 2017 Artsiom Sadyryn. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var cardViews = [UIView]()
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(cardPairs: 1)
        createGame(cardsNumber: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createGame(cardsNumber: Int) {
        for i in 0..<cardsNumber {
            let backView = UIImageView()
            let faceView = UIImageView()
            let cardView = UIView()
            add(subview: faceView, to: cardView)
            add(subview: backView, to: cardView)
            
            addTouch(view: backView)
            backView.contentMode = .scaleAspectFit
            faceView.contentMode = .scaleAspectFit
            backView.image = UIImage(named: "card_back")?.withRenderingMode(.alwaysTemplate)
            backView.backgroundColor = UIColor.white
            faceView.image = UIImage(named: "card1")
            cardView.layer.borderWidth = 1
            cardView.layer.borderColor = UIColor.lightGray.cgColor
            cardViews.append(cardView)
            view.addSubview(cardView)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            if i % 2 != 0 {
                cardView.leadingAnchor.constraint(equalTo: cardViews[i-1].trailingAnchor, constant: 16).isActive = true
            }
            else {
                cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            }
            cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
            cardView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            cardView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
    }
    
    private func add(subview: UIView, to cardView: UIView) {
        cardView.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        subview.leftAnchor.constraint(equalTo: cardView.leftAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: cardView.rightAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        
    }
    
    func addTouch(view: UIView) {
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(flipView(sender:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(touchRecognizer)
    }
    
    @objc func flipView(sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            if let tappedIndex = indexFor(card: imageView.superview!) {
                game.cardFlipped(at: tappedIndex)
            }
            let faceView = imageView.superview?.subviews.filter { $0 != imageView }.first
            if let face = faceView {
                UIView.transition(from: imageView, to: face, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            }
        }
    }
    
    private func indexFor(card: UIView) -> Int? {
        for i in 0..<cardViews.count {
            if card == cardViews[i] {
                return i
            }
        }
        return nil
        //return cardViews.index(of: card)
    }
}

