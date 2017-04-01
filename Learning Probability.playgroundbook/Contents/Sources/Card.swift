import UIKit
import SpriteKit
import PlaygroundSupport

public class Card : SKSpriteNode {
    let cardStruct : CardStruct
    let frontTexture :SKTexture
    var backTexture :SKTexture
    var dragable = false
    var faceUp = true
    let rank :SKLabelNode
    let largeTextureFilename :String
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    public init(cardStruct: CardStruct) {
        self.cardStruct = cardStruct
        frontTexture = SKTexture(imageNamed: "card_back")
        backTexture = SKTexture(imageNamed: "card_back")
        
        switch cardStruct.suit {
            case .clubs:
                backTexture = SKTexture(imageNamed: "clubs")
                largeTextureFilename = "clubs"
                break
            case .hearts:
                backTexture = SKTexture(imageNamed: "hearts")
                largeTextureFilename = "hearts"
                break
            case .spades:
                backTexture = SKTexture(imageNamed: "spades")
                largeTextureFilename = "spades"
                break
            case .diamonds:
                backTexture = SKTexture(imageNamed: "diamonds")
                largeTextureFilename = "diamonds"
                break
            default:
                backTexture = SKTexture(imageNamed: "card_back")
        }
        
        rank = SKLabelNode(fontNamed: "OpenSans-Bold")
        rank.name = "Rank"
        rank.fontSize = 20
        rank.fontColor = SKColor(red: 0.494, green: 0.521, blue: 0.564, alpha: 1.0)
        rank.text = cardStruct.rank.simpleDescription()
        rank.position = CGPoint(x: 0, y: 40)
        
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
    }
    
    
    public func flip() {
        let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.4)
        let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.4)
        
        setScale(1.0)
        
        if faceUp {
            run(firstHalfFlip, completion: {
                self.texture = self.backTexture
                
                self.run(secondHalfFlip)
            })
        } else {
            run(firstHalfFlip, completion: {
                self.texture = self.frontTexture
                self.run(secondHalfFlip)
            })
        }
        addChild(rank)
        faceUp = !faceUp
    }
    
}


enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "Ace"
        case .jack:
            return "Jack"
        case .queen:
            return "Queen"
        case .king:
            return "King"
        default:
            return String(self.rawValue)
        }
    }
}

enum Suit: Int {
    case spades = 0
    case hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "Spades"
        case .hearts:
            return "Hearts"
        case .diamonds:
            return "Diamonds"
        case .clubs:
            return "Clubs"
        }
    }
}


public struct CardStruct {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

enum CardLevel :CGFloat {
    case board = 10
    case moving = 100
    case enlarged = 200
}

