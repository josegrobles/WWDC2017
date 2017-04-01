import Foundation
import UIKit
import SceneKit
import GLKit

public class DiceScene: SCNScene{
    
    var zommMultiplier : Int = 1

    
    var maximumJumpHeight : CGFloat = 0.0
    var squareSizeHeight : CGFloat = 0.0
    
    var floorImage : UIImage!
    var camera : SCNNode!
    
    
    public func changeZoomLevel(_ level: Int){
        self.zommMultiplier = level
    }
    
   
    
    override public init(){
        
        let bundleUrl = Bundle.main.url(forResource: "DiceView", withExtension: "bundle")
        let bundle : Bundle = Bundle.init(url: bundleUrl!)!
        
        self.maximumJumpHeight = 130
        self.squareSizeHeight = 65
        
        self.floorImage = UIImage.init(named: "floor", in: bundle, compatibleWith: nil)!
                
        let floorGeometry = SCNFloor.init()
        floorGeometry.firstMaterial?.diffuse.contents = self.floorImage
        floorGeometry.firstMaterial?.diffuse.mipFilter = SCNFilterMode.linear
        
        let floorNode = SCNNode.init()
        floorNode.geometry = floorGeometry
        floorNode.physicsBody = SCNPhysicsBody.static()
        
        self.camera = SCNNode.init()
        self.camera.camera = SCNCamera.init()
        self.camera.camera?.zFar = Double(self.maximumJumpHeight.multiplied(by: 2.0))
        self.camera.eulerAngles = SCNVector3(12,0,0)
        self.camera.position = SCNVector3(0,self.maximumJumpHeight.subtracting(CGFloat.init(20*zommMultiplier)),0)
        self.camera.rotation = SCNVector4(-7,0,0,Float.pi/2)
        self.camera.position = SCNVector3(0,self.maximumJumpHeight.subtracting(CGFloat.init(30*zommMultiplier)),0)
        
        
        
        let diffuseLightFromNode = SCNNode.init()
        diffuseLightFromNode.light = SCNLight.init()
        diffuseLightFromNode.light?.type = SCNLight.LightType.omni
        diffuseLightFromNode.position = SCNVector3(0,self.maximumJumpHeight,self.maximumJumpHeight/3)
        
        
        super.init()
        
        self.physicsWorld.gravity = SCNVector3(0, -900, 0)
        self.rootNode.addChildNode(diffuseLightFromNode)
        self.rootNode.addChildNode(self.camera)
        self.rootNode.addChildNode(floorNode)
        print(self.description)
    }
    required public init(coder: NSCoder) {
        fatalError("Not yet implemented")
    }
    
    public func addDice(_ node: SCNNode){
        self.rootNode.addChildNode(node)
    }
    
    public func addDices(_ nodes: [🎲🏗]){
        for node in nodes{
            self.rootNode.addChildNode(node.dice)
        }
    }
    
}
