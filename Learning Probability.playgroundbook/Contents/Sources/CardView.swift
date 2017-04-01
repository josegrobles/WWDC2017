import UIKit
import SpriteKit
import PlaygroundSupport

public class CardView : SKView{
    var cardScene: CardScene!
    
    public init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame)
        self.cardScene = CardScene(size: CGSize(width: 1024, height: 768))
        self.presentScene(self.cardScene)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initializeCards(_ landscape: Bool){
        if landscape{
            let point = (self.frame.size.width - 310) / 2
            let position = CGPoint.init(x: point, y: 100)
            self.cardScene.initCards(position)
            self.cardScene.isLandscape = true
        }else{
            let position = CGPoint.init(x: 100, y: 590)
            self.cardScene.initCards(position)
            self.cardScene.isLandscape = false
        }
    }
    
}
