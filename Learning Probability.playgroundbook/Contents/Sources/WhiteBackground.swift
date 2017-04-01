import Foundation
import UIKit

public class WhiteBackground: UIView{
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  UIColor.init(red: 0.972, green: 0.976, blue: 0.984, alpha: 0)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
