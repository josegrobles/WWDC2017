import SceneKit

public struct 🎲🏗{
    
    var dice : SCNNode
    
    init(_ vector: SCNVector3, url : URL?){
        self.dice = SCNNode()
        do{
            let diceScene = try SCNScene.init(url: url!, options: nil)
            self.dice = diceScene.rootNode.childNode(withName: "Dice_1", recursively: true)!
            self.dice.physicsBody = SCNPhysicsBody.dynamic()
            self.dice.eulerAngles = vector
        }
        catch is NSError{
            print("Error")
        }
    }
    
    init(_ number: Int, url: URL?){
        self.dice = SCNNode()
        let vector = getVector(number)
        do{
            let diceScene = try SCNScene.init(url: url!, options: nil)
            self.dice = diceScene.rootNode.childNode(withName: "Dice_1", recursively: true)!
            self.dice.physicsBody = SCNPhysicsBody.dynamic()
            self.dice.eulerAngles = vector
        }
        catch is NSError{
            print("Error")
        }
    }
    
    func getVector(_ number: Int) -> SCNVector3 {
        var vector : SCNVector3
        switch number {
            case 1:
                vector = DiceVector.One
                break
            case 2:
                vector = DiceVector.Two
                break
            case 3:
                vector = DiceVector.Three
                break
            case 4:
                vector = DiceVector.Four
                break
            case 5:
                vector = DiceVector.Five
                break
            case 6:
                vector = DiceVector.Six
                break
            default:
            vector = DiceVector.One
        }
        return vector
    }
}


public struct DiceVector {
    static let One = SCNVector3(-104,0,0)
    static let Two = SCNVector3(-58,0,0)
    static let Three = SCNVector3(0,0,250)
    static let Four = SCNVector3(0,0,-250)
    static let Five = SCNVector3(-168,0,0)
    static let Six = SCNVector3(0,0,0)
}

