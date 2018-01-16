//
//  ViewController.swift
//  memo
//
//  Created by Artsiom Sadyryn on 12/27/17.
//  Copyright © 2017 Artsiom Sadyryn. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, CardViewDelegate {
    
    private var cardsContainer: CardsContainer!
    var cardViews = [UIView]()
    var game: Game!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cardPairs = 8
        game = Game(cardPairs: cardPairs)
        createGame(cardsNumber: cardPairs * 2 )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGame(cardsNumber: Int) {
        
        createContainer()
        
        for i in 0..<cardsNumber {
            let cardView = CardView(faceName: game.cards[i].imageName)
            cardView.delegate = self
            self.cardsContainer.addSubview(cardView)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            
            cardViews.append(cardView)
        }
        
        cardsContainer.layout()
    }
    
    private func createContainer() {
        cardsContainer = CardsContainer()
        view.addSubViews(cardsContainer)
    }
    
    func cardFlipped(_ card: CardView) {
        if let tappedIndex = indexFor(card: card) {
            game.cardFlipped(at: tappedIndex)
        }

    }
    
    private func indexFor(card: UIView?) -> Int? {
        guard let card = card else {
            return nil
        }
        return cardViews.index(of: card)
    }
    
}
