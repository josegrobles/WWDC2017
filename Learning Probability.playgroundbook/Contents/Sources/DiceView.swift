import Foundation
import UIKit
import SceneKit
import GLKit
import CoreMotion

public class 🎲🎑 : SCNView{
    
    var dices = [🎲🏗]()
    var manager : CMMotionManager = CMMotionManager.init()
    var diceScene: DiceScene!
    var movementEnabled = false
    
    var diceTimer : Timer!
    
    public func changeZoomLevel(_ level: Int){
        self.diceScene.changeZoomLevel(level)
    }
    
    public func createDice(_ number: Int = 1){
        let bundleUrl = Bundle.main.url(forResource: "DiceView", withExtension: "bundle")
        let bundle : Bundle = Bundle.init(url: bundleUrl!)!
        let url = bundle.url(forResource: "Dices", withExtension: "scn")

        let dice = 🎲🏗.init(number,url:url)
        self.diceScene.addDice(dice.dice)
        self.dices.append(dice)
    }
    
    public func allowMovement(){
        self.movementEnabled = true
    }
    
    override public init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        self.antialiasingMode = .multisampling2X
        self.diceScene = DiceScene.init()
        self.scene = self.diceScene
        let squareSizeHeight: CGFloat = 60
        self.placeWallsInScene(scene: self.scene!, sizeBox: squareSizeHeight)
        
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.02
            manager.startDeviceMotionUpdates(to: OperationQueue.main) {
                [weak self] (data: CMDeviceMotion?, error: Error?) in
                
                if let acceleration = data?.userAcceleration,
                    abs(acceleration.z) > 1.5 || abs(acceleration.y) > 1.5 || abs(acceleration.x) > 1.5{
                    self?.rollTheDice(acceleration)
                }
            }
        }


    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func placeWallsInScene(scene: SCNScene, sizeBox size: CGFloat){
        let left = SCNNode.init()
        left.position = SCNVector3(-size/2,size/2,0)
        left.geometry = SCNBox.init(width: 1, height: size, length: size, chamferRadius: 0)
        scene.rootNode.addChildNode(left)
        
        let front = SCNNode.init()
        front.position = SCNVector3(0,size/2,-size/2)
        front.geometry = SCNBox.init(width: size, height: size, length: 1, chamferRadius: 0)
        scene.rootNode.addChildNode(front)
        
        let right = SCNNode.init()
        right.position = SCNVector3(size/2,size/2,0)
        right.geometry = SCNBox.init(width: 1, height: size, length: size, chamferRadius: 0)
        scene.rootNode.addChildNode(right)
        
        let back = SCNNode.init()
        back.position = SCNVector3(0,size/2,size/2)
        back.geometry = SCNBox.init(width: size, height: size, length: 1, chamferRadius: 0)
        scene.rootNode.addChildNode(back)
        
        let top = SCNNode.init()
        top.position = SCNVector3(0,size,0)
        top.geometry = SCNBox.init(width: size, height: 1, length: size, chamferRadius: 0)
        scene.rootNode.addChildNode(top)
        
        self.applyRigidPhysics(node: left)
        self.applyRigidPhysics(node: front)
        self.applyRigidPhysics(node: right)
        self.applyRigidPhysics(node: back)
        self.applyRigidPhysics(node: top)
        
    }
    
    func randomJump() -> CGFloat {
        let lowerBound = 260
        let upperBound = 320
        let sum1 : UInt32 = arc4random().advanced(by: lowerBound)
        let sum2 : Int =  upperBound - lowerBound
        return CGFloat(Double(sum1).remainder(dividingBy: Double(sum2)))
    }
    
    func applyRigidPhysics(node: SCNNode){
        node.physicsBody = SCNPhysicsBody.init(type: SCNPhysicsBodyType.static, shape: SCNPhysicsShape.init(node: node, options: nil))
        node.opacity = 0.0
    }
    
    func rollTheDice(_ acceleration: CMAcceleration) {
        if movementEnabled{
            for element in self.dices{
                element.dice.physicsBody?.applyTorque(SCNVector4.init(acceleration.x*20, acceleration.y*20, acceleration.z*20, 10), asImpulse: true)
            }
        }
    }
    
    public func createTimer(){
        self.diceTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(rollTheDiceCustom), userInfo: nil, repeats: true)
    }
    
    public func stopTimer(){
        self.diceTimer.invalidate()
    }
    
    public func rollTheDiceCustom(){
            for element in self.dices{
                element.dice.physicsBody?.applyTorque(SCNVector4.init(Double(randomJump()*5), Double(randomJump()*5), Double(randomJump()*5), 10), asImpulse: true)
            }
    }
    
    

}

