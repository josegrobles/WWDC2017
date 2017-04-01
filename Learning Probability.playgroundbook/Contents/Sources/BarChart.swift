import PlaygroundSupport
import Foundation
import UIKit
import QuartzCore


class BarChart : UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    convenience init(frame: CGRect, numbers: [Int: Int],numberOfThrows: Int){
        self.init(frame: frame)
        self.backgroundColor = UIColor.white
        let horizontal = UIView.init(frame: CGRect.init(x: 20, y: self.frame.height - 20, width: self.frame.width.subtracting(CGFloat.init(40)), height: 2))
        horizontal.backgroundColor = UIColor.init(red: 0.235, green: 0.529, blue: 0.945, alpha: 1.0)
        let vertical = UIView.init(frame: CGRect.init(x: 30, y: 20, width: 2, height: self.frame.height.subtracting(CGFloat.init(40))))
        vertical.backgroundColor = UIColor.init(red: 0.235, green: 0.529, blue: 0.945, alpha: 1.0)
             
        
        for i in 1...6{
            let multiLine = MultiLine.init(frame: CGRect.init(x: 30, y: self.frame.height.subtracting(CGFloat.init(40+((i-1)*25))), width:self.frame.width.subtracting(CGFloat.init(40)), height: 2))
            let percentage = UILabel.init(frame: CGRect.init(x: 6, y: self.frame.height.subtracting(CGFloat.init(52+((i-1)*25))), width: 23, height: 23))
            percentage.adjustsFontSizeToFitWidth = true
            percentage.text = String(i*5) + "%"
            percentage.font.withSize(5.0)
            percentage.textColor = UIColor.init(red: 0.494, green: 0.521, blue: 0.564, alpha: 1.0)
            self.addSubview(percentage)
            self.addSubview(multiLine)
            let number: UILabel = UILabel.init(frame: CGRect.init(x: 65.advanced(by: (50*(i-1))), y: Int(self.frame.height-17), width: 15, height: 15))
            number.text = String(i)
            number.textColor = UIColor.init(red: 0.494, green: 0.521, blue: 0.564, alpha: 1.0)
            self.addSubview(number)
        }
        
        self.addSubview(horizontal)
        self.addSubview(vertical)
        
        var number_views = [UIView]()
        for i in 0...numbers.count-1{
            let bar = UIView.init(frame: CGRect.init(x: 50.advanced(by: (50*i)), y: Int(self.frame.height - 20), width: 40, height: 0))
            bar.backgroundColor = UIColor.init(red: 191/255, green: 221/255, blue: 252/255, alpha: 1.0)
            number_views.append(bar)
            self.addSubview(bar)
        }
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
            for i in 0...number_views.count-1{
                let size : CGFloat = CGFloat(numbers[i+1]!).divided(by: CGFloat(numberOfThrows)).multiplied(by: 482.85)
                number_views[i].frame.size.height = -size
            }
        }, completion: { finished in
            print("ok")
        })
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
