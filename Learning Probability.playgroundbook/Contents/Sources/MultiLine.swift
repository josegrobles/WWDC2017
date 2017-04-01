import PlaygroundSupport
import Foundation
import UIKit
import QuartzCore


public class MultiLine : UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  UIColor.init(red: 0.972, green: 0.976, blue: 0.984, alpha: 1.0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let numberOfLines : Int = Int(round(rect.width / 30))
        context.beginPath()
        for i in 0...numberOfLines{
            context.addRect(CGRect.init(x: 0+(i*30), y: 0, width: 20, height: 1))
        }
        context.closePath()
        
        context.setFillColor(red: 0.862, green: 0.898, blue: 0.937, alpha: 1.0)
        context.fillPath()
    }
}
