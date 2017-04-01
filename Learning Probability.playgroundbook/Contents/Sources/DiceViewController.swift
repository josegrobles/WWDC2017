import Foundation
import UIKit
import SceneKit
import GLKit
import PlaygroundSupport
import CoreMotion

public class MyLiveView : UIView, PlaygroundLiveViewSafeAreaContainer {}


public class DiceViewController : UIViewController{
    
    var ownView : MyLiveView!
    var diceView : 🎲🎑!
    
    override public func viewDidLoad() {
        self.ownView = MyLiveView()
        self.view = self.ownView
        self.view.backgroundColor = #colorLiteral(red: 0.9683932662, green: 0.9724789262, blue: 0.9806421399, alpha: 1)
        self.diceView = 🎲🎑.init(frame: CGRect(x: 0, y: 0, width: 900, height: 700))
        self.diceView.clipsToBounds = true
        self.diceView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(diceView)
        NSLayoutConstraint.activate([
            self.diceView.leadingAnchor.constraint(equalTo: self.ownView.liveViewSafeAreaGuide.leadingAnchor),
            self.diceView.trailingAnchor.constraint(equalTo: self.ownView.liveViewSafeAreaGuide.trailingAnchor),
            self.diceView.topAnchor.constraint(equalTo: self.ownView.liveViewSafeAreaGuide.topAnchor),
            self.diceView.bottomAnchor.constraint(equalTo: self.ownView.liveViewSafeAreaGuide.bottomAnchor)
            ])
    }
    
    public func createDice(_ number: Int = 1){
        var numberCopy = number
        if number > 6{
            numberCopy = 6
        }
        else if number < 1{
            numberCopy = 1
        }
        self.diceView.createDice(numberCopy)
        let texto = UILabel.init(frame: CGRect.init(x: (self.view.frame.width/2)-70, y: self.view.frame.height-180, width: 200, height: 50))
        texto.text = "Move your iPad!"
        texto.textColor = UIColor.init(red: 131/255, green: 193/255, blue: 255/255, alpha: 1.0)
        self.view.addSubview(texto)
        UIView.animate(withDuration: 2.0, delay: 8.0, options: .curveEaseOut, animations: {
            texto.alpha = 0.0
        },completion: { finished in
            
            
        })

    }
    
    public func createTimer(){
        self.diceView.createTimer()
    }
    
    public func allowMovement(){
        self.diceView.allowMovement()
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.diceView.changeZoomLevel(2)
            self.view.sizeToFit()
        }
        else if UIDevice.current.orientation.isPortrait{
            self.diceView.changeZoomLevel(1)
            self.view.sizeToFit()
        }
    }
    
}

extension DiceViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
            case .integer(let number):
                self.createDice(number)
                break
            case .boolean(let value):
                self.allowMovement()
                break
            case .dictionary(let dictionary):
                self.createDice()
                self.createTimer()
                break
        default:
            return
        }
    }
}
