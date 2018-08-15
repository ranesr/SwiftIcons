//  The MIT License (MIT)
//
//  Copyright © 2017 Saurabh Rane
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import SwiftIcons

public extension UIColor {
    
    convenience init(hex: String) {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = String(cString[cString.index(cString.startIndex, offsetBy: 1)...])
        }
        if ((cString.count) != 6) {
            cString = "808080"
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
}

public extension UITextField {
    
    public func bottomBorder(_ color: UIColor) {
        
        self.borderStyle = .none
        self.backgroundColor = .clear
        let width: CGFloat = 1.0
        
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width))
        borderLine.backgroundColor = color
        self.addSubview(borderLine)
    }
}

public extension UILabel {
    
    public func setIcons(icon1: FontType?, icon1Color: UIColor = .black, icon1BackgroundColor: UIColor = .clear, icon2: FontType?, icon2Color: UIColor = .black, icon2BackgroundColor: UIColor = .clear, iconSize: CGFloat? = nil) {
        
        let label1 = UILabel()
        label1.frame = CGRect(x: self.frame.width/2-40, y: self.frame.height/2-20, width: 40, height: 40)
        label1.textAlignment = .center
        label1.setIcon(icon: icon1!, iconSize: iconSize ?? 20, color: icon1Color, bgColor: icon1BackgroundColor)
        label1.roundCorners(corners: [.topLeft, .bottomLeft], radius: 5)
        
        let label2 = UILabel()
        label2.frame = CGRect(x: self.frame.width/2, y: self.frame.height/2-20, width: 40, height: 40)
        label2.textAlignment = .center
        label2.setIcon(icon: icon2!, iconSize: iconSize ?? 20, color: icon2Color, bgColor: icon2BackgroundColor)
        label2.layer.borderColor = icon2Color.cgColor
        label2.layer.borderWidth = 2
        label2.layer.masksToBounds = true
        label2.roundCorners(corners: [.topRight, .bottomRight], radius: 5)
        
        self.addSubview(label1)
        self.addSubview(label2)
    }
    
    public func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = maskLayer
    }
}
