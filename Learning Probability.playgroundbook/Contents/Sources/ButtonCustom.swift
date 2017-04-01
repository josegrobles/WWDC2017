import UIKit

public class ButtonCustom: UIButton{
    
    var answerValue: Int!
    var correctValue: Int!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience public init(frame: CGRect, value: Int,correct: Int) {
        self.init(frame:frame)
        self.answerValue = value
        self.correctValue = correct
    }
}
