import UIKit
import SpriteKit
import PlaygroundSupport
import GameKit

public class CardScene: SKScene {
    
    var isLandscape = true
    var stackCards = [Card]()
    var selectedCard : Card!
    let rankRandom = GKShuffledDistribution.init(lowestValue: 1, highestValue: 10)
    let suitRandom = GKShuffledDistribution.init(lowestValue: 0, highestValue: 3)
    var usedCards = [Card]()
    
    override public func didMove(to view: SKView) {
        let bg = SKSpriteNode(imageNamed: "bg")
        bg.anchorPoint = CGPoint.zero
        bg.position = CGPoint.zero
        addChild(bg)
    }
    
    public func initCards(_ position: CGPoint){
        for i in 0...2{
            let random = randomCard()
            random.position = position
            random.position.y = random.position.y + CGFloat(10*i)
            addChild(random)
            stackCards.append(random)
        }
    }
    
    public func getCard(){
        self.selectedCard = stackCards.removeFirst()
        let actionMove : SKAction
        if isLandscape{
            actionMove = SKAction.move(by: CGVector.init(dx: 0, dy: 550), duration: 0.9)
        }else{
            actionMove = SKAction.move(by: CGVector.init(dx: 600, dy: 10), duration: 0.9)
        }
        self.selectedCard.run(actionMove)
        
        self.selectedCard.dragable = true
        addCard()
    }
    
    
    func randomCard() -> Card{
        let rank = rankRandom.nextInt()
        let suit = suitRandom.nextInt()
        let cardStruct = CardStruct.init(rank: Rank(rawValue: rank)!, suit: Suit(rawValue: suit)!)
        return Card.init(cardStruct: cardStruct)
    }
    
    func addCard(){
        let card = randomCard()
        self.stackCards.append(card)
        let xPosition = ((self.view?.frame.size.width)! - 310) / 2
        card.position = CGPoint(x: xPosition,y: 100)
        self.addChild(card)
        self.moveCards()
    }
    
    func moveCards(){
        let move = SKAction.move(by: CGVector.init(dx: 0, dy: 10), duration: 0.4)
        for i in 0...1{
            stackCards[i].run(move)
        }
    }
    
    func answered(){
        self.usedCards.append(selectedCard)
        self.selectedCard = nil
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let card = atPoint(location) as? Card {
                if card.dragable {
                    card.zPosition = CardLevel.moving.rawValue
                   
                    card.removeAction(forKey: "drop")
                    card.run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
                    
                }
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let card = atPoint(location) as? Card {
                if !card.dragable{ return }
                card.position = location
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let card = atPoint(location) as? Card {
                if !card.dragable{ return }
                card.zPosition = CardLevel.board.rawValue
                
                card.run(SKAction.rotate(toAngle: 0, duration: 0.2), withKey:"rotate")
                
                card.removeAction(forKey: "pickup")
                card.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
                
                card.removeFromParent()
                addChild(card)
            }
        }
    }
    
}
