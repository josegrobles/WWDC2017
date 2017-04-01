import Foundation
import UIKit
import SceneKit
import GLKit
import PlaygroundSupport
import CoreMotion
import GameplayKit

public class DiceViewControllerCustom : UIViewController{
    
    var ready = true
    
    var ownView : MyLiveView!
    var diceView : 🎲🎑!
    var texto: UILabel!
    var timing: Timer!
    var counter = 0
    var threw = [Int]()
    var totalThrows = 0
    
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
    }
    
    public func createTimer(){
        let d6 = GKRandomDistribution.d6()
        self.diceView.createTimer()
        for i in 1...self.totalThrows{
            let n = d6.nextInt()
            self.threw.append(n)
        }
    }
    
    public func updateTextTimer(){
        self.texto = UILabel.init(frame: CGRect.init(x: (self.view.frame.width/2)-70, y: self.view.frame.height-180, width: 200, height: 50))
        self.texto.text = ""
        self.texto.textColor = UIColor.init(red: 131/255, green: 193/255, blue: 255/255, alpha: 1.0)
        self.view.addSubview(texto)
        self.timing = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(updateText), userInfo: nil, repeats: true)
    }
    
    public func updateText(){
        self.texto.text = "Running \(self.counter) times"
        self.counter+=1
        if counter == Int(self.totalThrows/10){
            self.counter = self.totalThrows-60
        }else if counter == self.totalThrows+1{
            self.timing.invalidate()
            self.diceView.stopTimer()
            self.createWhiteView()
        }
    }
    
    func createWhiteView(){
        let white = WhiteBackground.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        self.view.addSubview(white)
        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseOut, animations: {
            white.backgroundColor = UIColor.init(red: 0.972, green: 0.976, blue: 0.984, alpha: 1.0)
        }, completion: { finished in
            for view in self.view.subviews {
                if !type(of:view).isEqual(WhiteBackground){
                    view.removeFromSuperview()
                }
            }
            
            let firstMessage = UILabel.init(frame: CGRect.init(x: 0, y: 40, width: self.view.frame.width, height: 50))
            firstMessage.textColor = UIColor.init(red: 131/255, green: 193/255, blue: 255/255, alpha: 1.0)
            firstMessage.textAlignment = .center
            firstMessage.numberOfLines = 2
            firstMessage.font = firstMessage.font.withSize(25.0)
            firstMessage.text = "After rolling the dice \(self.totalThrows) times..."
            firstMessage.alpha = 0
            self.view.addSubview(firstMessage)
            
            
            let explanation = UILabel.init()
            explanation.text = "We can see that while rolling a dice each face has the same probability of appearing"
            explanation.textColor = UIColor.white
            explanation.font = explanation.font.withSize(22.0)
            explanation.numberOfLines = 2
            explanation.textAlignment = .center
            explanation.textColor = UIColor.init(red: 131/255, green: 193/255, blue: 255/255, alpha: 1.0)
            let initialPoint = (self.view.frame.width - 500 )/2
            explanation.frame = CGRect.init(x: 0, y: 350, width: 500, height: 300)
            explanation.alpha = 0
            self.view.addSubview(explanation)

            
            let x = self.threw.freq()
            let barChart = BarChart.init(frame: CGRect.init(x: (self.view.frame.width/2)-200, y: 200, width: 400, height: 200), numbers:x, numberOfThrows: self.totalThrows)
            barChart.backgroundColor = UIColor.init(red: 0.972, green: 0.976, blue: 0.984, alpha: 1.0)
            barChart.alpha = 0
            explanation.alpha = 1
            self.view.addSubview(barChart)

            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                firstMessage.alpha = 1.0
                barChart.alpha = 1.0
            },completion: { finished in
                

            })
            
        })

    }
    
    public func allowMovement(){
        self.diceView.allowMovement()
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.diceView.changeZoomLevel(2)
        }
        else if UIDevice.current.orientation.isPortrait{
            self.diceView.changeZoomLevel(1)
        }
        self.view.sizeToFit()
    }
    
}

extension DiceViewControllerCustom: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case .integer(let number):
            if ready == true{
                if number < 1000 { self.totalThrows = 1000}
                else {self.totalThrows = number }
                self.createDice()
                self.createTimer()
                self.updateTextTimer()
                ready = false
            }
            break
        default:
            return
        }
    }
}
