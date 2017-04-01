import UIKit
import GameKit
import SpriteKit
import PlaygroundSupport

public class CardsViewController: UIViewController {
    
    var cardView : CardView!
    let successRandom = GKShuffledDistribution.init(lowestValue: 0, highestValue: 4)
    let infoRandom = GKRandomDistribution.init(lowestValue: 0, highestValue: 1)
    let answers = [[10,0,0,0,100],[0,33,33,33,0],[7,7,7,7,77]]
    var posibleAnswers = [0,7,10,33,77,100]
    var available = true
    var question : UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.cardView = CardView.init(frame: CGRect(x: 0, y: 0, width: 900, height: 700))
        self.view.addSubview(cardView)
        
        let info = UILabel.init(frame: CGRect.init(x: 0, y: 7, width: self.view.frame.width/2, height: 50))
        info.textAlignment = .center
        info.textColor = UIColor.white
        info.text = "You can drag and drop the cards placed in here"
        self.view.addSubview(info)
        
        
        self.cardView.initializeCards(isLandscape())
        self.view.backgroundColor = UIColor.init(red: 191/255, green: 221/255, blue: 252/255, alpha: 1.0)

    }
    
    func isLandscape() -> Bool{
        return self.view.frame.size.width > self.view.frame.size.height
    }
    
    func pressed(){
        if !available { return }
        self.cardView.cardScene.getCard()
        let success = Success.init(rawValue: successRandom.nextInt())
        let actual = getActual()
        
        question = UILabel.init()
        question.text = "What is the possibility of getting a \((success?.simpleDescription())!) if we have a \(actual.simpleDescription())?"
        question.textColor = UIColor.white
        question.numberOfLines = 2
        question.textAlignment = .center
        question.alpha = 0
        let size = question.sizeThatFits(CGSize(width: 300, height: 5000))
        let initialPoint = (self.view.frame.width - 300 )/2
        question.frame = CGRect.init(x: initialPoint, y: 240, width: 300, height: size.height)
        
        var localAnswers = [Int]()
        let answer = answers[actual.rawValue][(success?.rawValue)!]
        localAnswers.append(answer)
        let index = posibleAnswers.index(of: answer)
        posibleAnswers.remove(at: index!)
        posibleAnswers.shuffle()
        localAnswers.append(posibleAnswers[0])
        localAnswers.append(posibleAnswers[1])
        posibleAnswers = [0,7,10,33,77,100]
        localAnswers.shuffle()
        
        var buttons = [ButtonCustom]()
        
        for i in 0...2{
            let possibleSolution = localAnswers[i]
            let initialPoint =  (self.view.frame.size.width - 340) / 2
            let button = ButtonCustom.init(frame: CGRect.init(x: initialPoint+CGFloat(120*i), y: 290, width: 100, height: 50),value:possibleSolution,correct:answer)
            button.layer.borderWidth = 3.0
            button.alpha = 0
            button.layer.borderColor = UIColor.white.cgColor
            button.addTarget(self, action: #selector(pressedAnswer), for: .touchDown)
            button.setTitle("\(possibleSolution)%", for: .normal)
            buttons.append(button)
            self.view.addSubview(button)
        }
        
        
        self.view.addSubview(question)
        available = false
        
        UIView.animate(withDuration: 2.0, delay: 0.4, options: .curveEaseOut, animations: {
            self.question.alpha = 1
            for button in buttons {
                button.alpha = 1
            }
            
        }, completion: { finished in
            print("ok")
        })
    }
    
    
    func pressedAnswer(sender: UIButton, forEvent event: UIEvent){
        let info = sender as! ButtonCustom
        let response = UILabel.init(frame: CGRect.init(x: 125, y: 300, width: self.view.frame.width/2, height: 50))
        response.textColor = UIColor.white
        response.textAlignment = .center
        response.font = response.font.withSize(25.0)
        if info.answerValue! == info.correctValue!{
            response.text = "Correct!"
        }else{
            response.text = "Wrong!"
        }
        removeViews()
        self.view.addSubview(response)
        UIView.animate(withDuration: 1.0, delay: 4.0, options: .curveEaseOut, animations: {
            response.alpha = 0
        }, completion: { finished in
            print("ok")
        })
        self.cardView.cardScene.selectedCard.flip()
        available = true
    }
    
    
    func removeViews(){
        for view in self.view.subviews{
            if type(of: view).isEqual(ButtonCustom) || type(of: view).isEqual(UILabel){
                view.removeFromSuperview()
            }
        }
    }
    
    
    func getActual() -> Actual{
        let actual = self.cardView.cardScene.selectedCard
        let random = infoRandom.nextInt()
        if random == 1{ return .suit}
        else{
            if (actual?.cardStruct.rank.rawValue)! > 10{
                return .figure
            }else{
                return .number
            }
        }
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if self.isLandscape(){
            self.cardView.cardScene.isLandscape = true
            if self.question != nil{
                question.frame = CGRect.init(x: 0, y: 0, width: 300, height: size.height)
                question.updateConstraints()
            }
            for card in self.cardView.cardScene.stackCards{
                let action = SKAction.move(to: CGPoint.init(x: 270, y: 170), duration: 0.0)
                card.run(action)
            }
            for card in self.cardView.cardScene.usedCards{
                let action = SKAction.move(to: CGPoint.init(x: 250, y: 650), duration: 0.0)
                card.run(action)
            }
            if self.cardView.cardScene.selectedCard != nil {
                let action = SKAction.move(to: CGPoint.init(x: 250, y: 650), duration: 0.0)
                cardView.cardScene.selectedCard.run(action)
                
            }
        }else{
            if self.question != nil{
                question.frame =  CGRect.init(x: 175, y: 70, width: 300, height: 100)
                question.updateConstraints()
            }
            self.cardView.cardScene.isLandscape = false
            for card in self.cardView.cardScene.stackCards{
                let action = SKAction.move(to: CGPoint.init(x: 100, y: 590), duration: 0.0)
                card.run(action)
            }
            for card in self.cardView.cardScene.usedCards{
                let action = SKAction.move(to: CGPoint.init(x: 640, y: 590), duration: 0.0)
                card.run(action)
            }
            if self.cardView.cardScene.selectedCard != nil {
                let action = SKAction.move(to: CGPoint.init(x: 640, y: 590), duration: 0.0)
                cardView.cardScene.selectedCard.run(action)
                
            }
        }
    }
}



enum Success: Int{
    case ace = 0
    case jack,queen,king,number
    func simpleDescription() -> String{
        switch self{
        case .ace:
            return "Ace"
        case .jack:
            return "Jack"
        case .queen:
            return "Queen"
        case .king:
            return "King"
        default:
            return "Number"
        }
    }
}

enum Actual: Int{
    case number = 0
    case figure, suit
    func simpleDescription() -> String{
        switch self {
        case .number:
            return "Number"
        case .figure:
            return "Figure"
        case .suit:
            return "determined Suit"
        default:
            "number"
        }
    }
}

extension CardsViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case .integer(let number):
            self.pressed()
            break
        default:
            return
        }
    }
}

