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

import Foundation
import UIKit

public extension UIImage {
    
    /**
     This init function sets the icon to UIImage
     
     - Parameter icon: The icon for the UIImage
     - Parameter size: CGSize for the icon
     - Parameter textColor: Color for the icon
     - Parameter backgroundColor: Background color for the icon
     
     - Version: 1.0
    */
    public convenience init(icon: FontType, size: CGSize, textColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.clear) {
        FontLoader.loadFontIfNeeded(fontType: icon)
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let fontAspectRatio: CGFloat = 1.28571429
        let fontSize = min(size.width / fontAspectRatio, size.height)
        let font = UIFont(name: icon.fontName(), size: fontSize)
        assert(font != nil, icon.errorAnnounce())
        let attributes = [NSFontAttributeName: font!, NSForegroundColorAttributeName: textColor, NSBackgroundColorAttributeName: backgroundColor, NSParagraphStyleAttributeName: paragraph]
        
        let attributedString = NSAttributedString(string: icon.text!, attributes: attributes)
        UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
        attributedString.draw(in: CGRect(x: 0, y: (size.height - fontSize) * 0.5, width: size.width, height: fontSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = image {
            self.init(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
        } else {
            self.init()
        }
    }
    
    /**
     This init function adds support for stacked icons. For details check [Stacked Icons](http://fontawesome.io/examples/#stacked)
     
     - Parameter bgIcon: Background icon of the stacked icons
     - Parameter bgTextColor: Color for the background icon
     - Parameter bgBackgroundColor: Background color for the background icon
     - Parameter topIcon: Top icon of the stacked icons
     - Parameter topTextColor: Color for the top icon
     - Parameter bgLarge: Set if the background icon should be bigger
     - Parameter size: CGSize for the UIImage
     
     - Version: 1.0
     */
    public convenience init(bgIcon: FontType, bgTextColor: UIColor = .black, bgBackgroundColor: UIColor = .clear, topIcon: FontType, topTextColor: UIColor = .black, bgLarge: Bool? = true, size: CGSize? = nil) {
        
        FontLoader.loadFontIfNeeded(fontType: bgIcon)
        FontLoader.loadFontIfNeeded(fontType: topIcon)
        
        let bgSize: CGSize!
        let topSize: CGSize!
        let bgRect: CGRect!
        let topRect: CGRect!
        
        if bgLarge! {
            topSize = size ?? CGSize(width: 30, height: 30)
            bgSize = CGSize(width: 2 * topSize.width, height: 2 * topSize.height)
            
        } else {
            
            bgSize = size ?? CGSize(width: 30, height: 30)
            topSize = CGSize(width: 2 * bgSize.width, height: 2 * bgSize.height)
        }
        
        let bgImage = UIImage.init(icon: bgIcon, size: bgSize, textColor: bgTextColor)
        let topImage = UIImage.init(icon: topIcon, size: topSize, textColor: topTextColor)
        
        if bgLarge! {
            bgRect = CGRect(x: 0, y: 0, width: bgSize.width, height: bgSize.height)
            topRect = CGRect(x: topSize.width/2, y: topSize.height/2, width: topSize.width, height: topSize.height)
            UIGraphicsBeginImageContextWithOptions(bgImage.size, false, 0.0)
            
        } else {
            topRect = CGRect(x: 0, y: 0, width: topSize.width, height: topSize.height)
            bgRect = CGRect(x: bgSize.width/2, y: bgSize.height/2, width: bgSize.width, height: bgSize.height)
            UIGraphicsBeginImageContextWithOptions(topImage.size, false, 0.0)
            
        }
        
        bgImage.draw(in: bgRect)
        topImage.draw(in: topRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = image {
            self.init(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
        } else {
            self.init()
        }
    }
}

public extension UIImageView {
    
    /**
     This function sets the icon to UIImageView
     
     - Parameter icon: The icon for the UIImageView
     - Parameter textColor: Color for the icon
     - Parameter backgroundColor: Background color for the icon
     - Parameter size: CGSize for the UIImage
     
     - Version: 1.0
     */
    public func setIcon(icon: FontType, textColor: UIColor = .black, backgroundColor: UIColor = .clear, size: CGSize? = nil) {
        self.image = UIImage(icon: icon, size: size ?? frame.size, textColor: textColor, backgroundColor: backgroundColor)
    }
}

public extension UILabel {
    
    /**
     This function sets the icon to UILabel
     
     - Parameter icon: The icon for the UILabel
     - Parameter iconSize: Size of the icon
     - Parameter textColor: Color for the icon
     - Parameter backgroundColor: Background color for the icon
     
     - Version: 1.0
     */
    public func setIcon(icon: FontType, iconSize: CGFloat, color: UIColor = .black, bgColor: UIColor = .clear) {
        FontLoader.loadFontIfNeeded(fontType: icon)
        
        let iconFont = UIFont(name: icon.fontName(), size: iconSize)
        assert(iconFont != nil, icon.errorAnnounce())
        text = icon.text
        font = iconFont
        textColor = color
        backgroundColor = bgColor
        textAlignment = .center
    }
    
    /**
     This function sets the icon to UILabel with text around it with different colors
     
     - Parameter prefixText: The text before the icon
     - Parameter prefixTextColor: The color for the text before the icon
     - Parameter icon: The icon
     - Parameter iconColor: Color for the icon
     - Parameter postfixText: The text after the icon
     - Parameter postfixTextColor: The color for the text after the icon
     - Parameter size: Size of the text
     - Parameter iconSize: Size of the icon
     
     - Version: 1.0
     */
    public func setIcon(prefixText: String, prefixTextColor: UIColor = .black, icon: FontType?, iconColor: UIColor = .black, postfixText: String, postfixTextColor: UIColor = .black, size: CGFloat?, iconSize: CGFloat? = nil) {
        text = nil
        FontLoader.loadFontIfNeeded(fontType: icon!)
        
        let attrText = attributedText ?? NSAttributedString()
        let startFont = attrText.length == 0 ? nil : attrText.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont
        let endFont = attrText.length == 0 ? nil : attrText.attribute(NSFontAttributeName, at: attrText.length - 1, effectiveRange: nil) as? UIFont
        var textFont = font
        if let f = startFont , f.fontName != icon?.fontName()  {
            textFont = f
        } else if let f = endFont , f.fontName != icon?.fontName()  {
            textFont = f
        }
        let prefixTextAttributes = [NSFontAttributeName : textFont!, NSForegroundColorAttributeName: prefixTextColor] as [String : Any]
        let prefixTextAttribured = NSMutableAttributedString(string: prefixText, attributes: prefixTextAttributes)
        
        if let iconText = icon?.text {
            let iconFont = UIFont(name: (icon?.fontName())!, size: iconSize ?? size ?? font.pointSize)!
            let iconAttributes = [NSFontAttributeName : iconFont, NSForegroundColorAttributeName: iconColor]
            
            let iconString = NSAttributedString(string: iconText, attributes: iconAttributes)
            prefixTextAttribured.append(iconString)
        }
        let postfixTextAttributes = [NSFontAttributeName : textFont!, NSForegroundColorAttributeName: postfixTextColor] as [String : Any]
        let postfixTextAttributed = NSAttributedString(string: postfixText, attributes: postfixTextAttributes)
        prefixTextAttribured.append(postfixTextAttributed)
        
        attributedText = prefixTextAttribured
        textAlignment = .center

    }
    
    
    /**
     This function sets the icon to UILabel with text around it with different fonts & colors
     
     - Parameter prefixText: The text before the icon
     - Parameter prefixTextFont: The font for the text before the icon
     - Parameter prefixTextColor: The color for the text before the icon
     - Parameter icon: The icon
     - Parameter iconColor: Color for the icon
     - Parameter postfixText: The text after the icon
     - Parameter postfixTextFont: The font for the text after the icon
     - Parameter postfixTextColor: The color for the text after the icon
     - Parameter iconSize: Size of the icon
     
     - Version: 1.0
     */
    public func setIcon(prefixText: String, prefixTextFont: UIFont, prefixTextColor: UIColor = .black, icon: FontType?, iconColor: UIColor = .black, postfixText: String, postfixTextFont: UIFont, postfixTextColor: UIColor = .black, iconSize: CGFloat? = nil) {
        text = nil
        FontLoader.loadFontIfNeeded(fontType: icon!)
        
        let prefixTextAttributes = [NSFontAttributeName : prefixTextFont, NSForegroundColorAttributeName: prefixTextColor]
        let prefixTextAttribured = NSMutableAttributedString(string: prefixText, attributes: prefixTextAttributes)
        
        if let iconText = icon?.text {
            let iconFont = UIFont(name: (icon?.fontName())!, size: iconSize ?? font.pointSize)!
            let iconAttributes = [NSFontAttributeName : iconFont, NSForegroundColorAttributeName: iconColor]
            
            let iconString = NSAttributedString(string: iconText, attributes: iconAttributes)
            prefixTextAttribured.append(iconString)
        }
        
        let postfixTextAttributes = [NSFontAttributeName : postfixTextFont, NSForegroundColorAttributeName: postfixTextColor]
        let postfixTextAttributed = NSAttributedString(string: postfixText, attributes: postfixTextAttributes)
        prefixTextAttribured.append(postfixTextAttributed)
        
        attributedText = prefixTextAttribured
        textAlignment = .center
    }
}

public extension UIButton {
        
    /**
     This function sets the icon to UIButton
     
     - Parameter icon: The icon for the UIButton
     - Parameter iconSize: Size of the icon
     - Parameter color: Color for the icon
     - Parameter forState: Control state of the UIButton
     
     - Version: 1.0
     */
    public func setIcon(icon: FontType, iconSize: CGFloat? = nil, color: UIColor = .black, forState state: UIControlState) {
        let size = iconSize ?? titleLabel?.font.pointSize
        
        FontLoader.loadFontIfNeeded(fontType: icon)
        guard let titleLabel = titleLabel else { return }
        setAttributedTitle(nil, for: state)
        let font = UIFont(name: icon.fontName(), size: size!)
        assert(font != nil, icon.errorAnnounce())
        titleLabel.font = font!
        setTitleColor(color, for: state)
        setTitle(icon.text, for: state)
        titleLabel.textAlignment = .center
    }
    
    
    /**
     This function sets the icon to UIButton with text around it with different colors
     
     - Parameter prefixText: The text before the icon
     - Parameter prefixTextColor: The color for the text before the icon
     - Parameter icon: The icon
     - Parameter iconColor: Color for the icon
     - Parameter postfixText: The text after the icon
     - Parameter postfixTextColor: The color for the text after the icon
     - Parameter forState: Control state of the UIButton
     - Parameter textSize: Size of the text
     - Parameter iconSize: Size of the icon
     
     - Version: 1.0
     */
    public func setIcon(prefixText: String, prefixTextColor: UIColor = .black, icon: FontType, iconColor: UIColor = .black, postfixText: String, postfixTextColor: UIColor = .black, forState state: UIControlState, textSize: CGFloat? = nil, iconSize: CGFloat? = nil) {
        
        setTitle(nil, for: state)
        FontLoader.loadFontIfNeeded(fontType: icon)
        guard let titleLabel = titleLabel else { return }
        let attributedText = attributedTitle(for: .normal) ?? NSAttributedString()
        
        let  startFont =  attributedText.length == 0 ? nil : attributedText.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont
        let endFont = attributedText.length == 0 ? nil : attributedText.attribute(NSFontAttributeName, at: attributedText.length - 1, effectiveRange: nil) as? UIFont
        var textFont = titleLabel.font
        
        if let f = startFont , f.fontName != icon.fontName() {
            textFont = f
        } else if let f = endFont , f.fontName != icon.fontName()  {
            textFont = f
        }
        
        let prefixTextAttributes = [NSFontAttributeName:textFont!.withSize(textSize ?? titleLabel.font.pointSize), NSForegroundColorAttributeName: prefixTextColor] as [String : Any]
        let prefixTextAttribured = NSMutableAttributedString(string: prefixText, attributes: prefixTextAttributes)
        
        if let iconText = icon.text {
            let iconFont = UIFont(name: icon.fontName(), size: iconSize ?? textSize ?? titleLabel.font.pointSize)!
            let iconAttributes = [NSFontAttributeName: iconFont, NSForegroundColorAttributeName: iconColor]
            
            let iconString = NSAttributedString(string: iconText, attributes: iconAttributes)
            prefixTextAttribured.append(iconString)
        }
        
        let postfixTextAttributes = [NSFontAttributeName:textFont!.withSize(textSize ?? titleLabel.font.pointSize), NSForegroundColorAttributeName: postfixTextColor] as [String : Any]
        let postfixTextAttributed = NSAttributedString(string: postfixText, attributes: postfixTextAttributes)
        prefixTextAttribured.append(postfixTextAttributed)
        
        setAttributedTitle(prefixTextAttribured, for: state)
        titleLabel.textAlignment = .center
    }
    
    
    /**
     This function sets the icon to UIButton with text around it with different fonts & colors
     
     - Parameter prefixText: The text before the icon
     - Parameter prefixTextFont: The font for the text before the icon
     - Parameter prefixTextColor: The color for the text before the icon
     - Parameter icon: The icon
     - Parameter iconColor: Color for the icon
     - Parameter postfixText: The text after the icon
     - Parameter postfixTextFont: The font for the text after the icon
     - Parameter postfixTextColor: The color for the text after the icon
     - Parameter forState: Control state of the UIButton
     - Parameter iconSize: Size of the icon
     
     - Version: 1.0
     */
    public func setIcon(prefixText: String, prefixTextFont: UIFont, prefixTextColor: UIColor = .black, icon: FontType?, iconColor: UIColor = .black, postfixText: String, postfixTextFont: UIFont, postfixTextColor: UIColor = .black, forState state: UIControlState, iconSize: CGFloat? = nil) {
        
        setTitle(nil, for: state)
        FontLoader.loadFontIfNeeded(fontType: icon!)
        guard let titleLabel = titleLabel else { return }
        
        let prefixTextAttributes = [NSFontAttributeName : prefixTextFont, NSForegroundColorAttributeName: prefixTextColor]
        let prefixTextAttribured = NSMutableAttributedString(string: prefixText, attributes: prefixTextAttributes)
        
        if let iconText = icon?.text {
            let iconFont = UIFont(name: (icon?.fontName())!, size: iconSize ?? (titleLabel.font.pointSize))!
            let iconAttributes = [NSFontAttributeName: iconFont, NSForegroundColorAttributeName: iconColor]
            
            let iconString = NSAttributedString(string: iconText, attributes: iconAttributes)
            prefixTextAttribured.append(iconString)
        }
        
        let postfixTextAttributes = [NSFontAttributeName : postfixTextFont, NSForegroundColorAttributeName: postfixTextColor]
        let postfixTextAttributed = NSAttributedString(string: postfixText, attributes: postfixTextAttributes)
        prefixTextAttribured.append(postfixTextAttributed)
        
        setAttributedTitle(prefixTextAttribured, for: state)
        
    }
}

public extension UISegmentedControl {
    
    /**
     This function sets the icon to UISegmentedControl at particular segment index
     
     - Parameter icon: The icon
     - Parameter color: Color for the icon
     - Parameter iconSize: Size of the icon
     - Parameter forSegmentAtIndex: Segment index for the icon
     
     - Version: 1.0
     */
    public func setIcon(icon: FontType, color: UIColor = .black, iconSize: CGFloat? = nil, forSegmentAtIndex segment: Int) {
        FontLoader.loadFontIfNeeded(fontType: icon)
        let font = UIFont(name: icon.fontName(), size: iconSize ?? 23)
        assert(font != nil, icon.errorAnnounce())
        setTitleTextAttributes([NSFontAttributeName: font!], for: .normal)
        setTitle(icon.text, forSegmentAt: segment)
        tintColor = color
    }
}

public extension UITabBarItem {
    
    /**
     This function sets the icon to UITabBarItem
     
     - Parameter icon: The icon for the UITabBarItem
     - Parameter size: CGSize for the icon
     - Parameter textColor: Color for the icon when UITabBarItem is not selected
     - Parameter backgroundColor: Background color for the icon when UITabBarItem is not selected
     - Parameter selectedTextColor: Color for the icon when UITabBarItem is selected
     - Parameter selectedBackgroundColor: Background color for the icon when UITabBarItem is selected
     
     - Version: 1.0
     */
    public func setIcon(icon: FontType, size: CGSize? = nil, textColor: UIColor = .black, backgroundColor: UIColor = .clear, selectedTextColor: UIColor = .black, selectedBackgroundColor: UIColor = .clear) {
        
        let tabBarItemImageSize = size ?? CGSize(width: 30, height: 30)
        image = UIImage(icon: icon, size: tabBarItemImageSize, textColor: textColor, backgroundColor: backgroundColor).withRenderingMode(.alwaysOriginal)
        selectedImage = UIImage(icon: icon, size: tabBarItemImageSize, textColor: selectedTextColor, backgroundColor: selectedBackgroundColor).withRenderingMode(.alwaysOriginal)
    }
    
    /**
     This function supports stacked icons for UITabBarItem. For details check [Stacked Icons](http://fontawesome.io/examples/#stacked)
     
     - Parameter bgIcon: Background icon of the stacked icons
     - Parameter bgTextColor: Color for the background icon
     - Parameter selectedBgTextColor: Color for the background icon when UITabBarItem is selected
     - Parameter topIcon: Top icon of the stacked icons
     - Parameter topTextColor: Color for the top icon
     - Parameter selectedTopTextColor: Color for the top icon when UITabBarItem is selected
     - Parameter bgLarge: Set if the background icon should be bigger
     - Parameter size: CGSize for the icon
     
     - Version: 1.0
     */
    public func setIcon(bgIcon: FontType, bgTextColor: UIColor = .black, selectedBgTextColor: UIColor = .black, topIcon: FontType, topTextColor: UIColor = .black, selectedTopTextColor: UIColor = .black, bgLarge: Bool? = true, size: CGSize? = nil) {
        
        let tabBarItemImageSize = size ?? CGSize(width: 15, height: 15)
        image = UIImage(bgIcon: bgIcon, bgTextColor: bgTextColor, bgBackgroundColor: .clear, topIcon: topIcon, topTextColor: topTextColor, bgLarge: bgLarge, size: tabBarItemImageSize).withRenderingMode(.alwaysOriginal)
        selectedImage = UIImage(bgIcon: bgIcon, bgTextColor: selectedBgTextColor, bgBackgroundColor: .clear, topIcon: topIcon, topTextColor: selectedTopTextColor, bgLarge: bgLarge, size: tabBarItemImageSize).withRenderingMode(.alwaysOriginal)
        
    }
}

public extension UISlider {
    
    /**
     This function sets the icon to the maximum value of UISlider
     
     - Parameter icon: The icon for the maximum value of UISlider
     - Parameter size: CGSize for the icon
     - Parameter textColor: Color for the icon
     - Parameter backgroundColor: Background color for the icon
     
     - Version: 1.0
     */
    public func setMaximumValueIcon(icon: FontType, customSize: CGSize? = nil, textColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.clear) {
        maximumValueImage = UIImage(icon: icon, size: customSize ?? CGSize(width: 25,height: 25), textColor: textColor, backgroundColor: backgroundColor)
    }
    
    /**
     This function sets the icon to the minimum value of UISlider
     
     - Parameter icon: The icon for the minimum value of UISlider
     - Parameter size: CGSize for the icon
     - Parameter textColor: Color for the icon
     - Parameter backgroundColor: Background color for the icon
     
     - Version: 1.0
     */
    public func setMinimumValueIcon(icon: FontType, customSize: CGSize? = nil, textColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.clear) {
        minimumValueImage = UIImage(icon: icon, size: customSize ?? CGSize(width: 25,height: 25), textColor: textColor, backgroundColor: backgroundColor)
    }
}

public extension UIBarButtonItem {
    
    /**
     This function sets the icon for UIBarButtonItem
     
     - Parameter icon: The icon for the for UIBarButtonItem
     - Parameter iconSize: Size for the icon
     - Parameter color: Color for the icon
     
     - Version: 1.0
     */
    public func setIcon(icon: FontType, iconSize: CGFloat, color: UIColor = .black) {
        
        FontLoader.loadFontIfNeeded(fontType: icon)
        let font = UIFont(name: icon.fontName(), size: iconSize)
        assert(font != nil, icon.errorAnnounce())
        setTitleTextAttributes([NSFontAttributeName: font!], for: .normal)
        title = icon.text
        tintColor = color
    }
    
    /**
     This function sets the icon for UIBarButtonItem with text around it with different colors
    
     - Parameter prefixText: The text before the icon
     - Parameter prefixTextColor: The color for the text before the icon
     - Parameter icon: The icon
     - Parameter iconColor: Color for the icon
     - Parameter postfixText: The text after the icon
     - Parameter postfixTextColor: The color for the text after the icon
     - Parameter cgRect: CGRect for the whole icon & text
     - Parameter size: Size of the text
     - Parameter iconSize: Size of the icon
    
     - Version: 1.0
    */
    public func setIcon(prefixText: String, prefixTextColor: UIColor = .black, icon: FontType?, iconColor: UIColor = .black, postfixText: String, postfixTextColor: UIColor = .black, cgRect: CGRect, size: CGFloat?, iconSize: CGFloat? = nil) {
        
        title = nil
        let label = UILabel(frame: cgRect)
        label.setIcon(prefixText: prefixText, prefixTextColor: prefixTextColor, icon: icon, iconColor: iconColor, postfixText: postfixText, postfixTextColor: postfixTextColor, size: size, iconSize: iconSize)

        customView = label
    }
    
    /**
     This function sets the icon for UIBarButtonItem with text around it with different colors
     
     - Parameter prefixText: The text before the icon
     - Parameter prefixTextColor: The color for the text before the icon
     - Parameter prefixTextColor: The color for the text before the icon
     - Parameter icon: The icon
     - Parameter iconColor: Color for the icon
     - Parameter postfixText: The text after the icon
     - Parameter postfixTextColor: The color for the text after the icon
     - Parameter postfixTextColor: The color for the text after the icon
     - Parameter cgRect: CGRect for the whole icon & text
     - Parameter size: Size of the text
     - Parameter iconSize: Size of the icon
     
     - Version: 1.0
     */
    public func setIcon(prefixText: String, prefixTextFont: UIFont, prefixTextColor: UIColor = .black, icon: FontType?, iconColor: UIColor = .black, postfixText: String, postfixTextFont: UIFont, postfixTextColor: UIColor = .black, cgRect: CGRect, iconSize: CGFloat? = nil) {
        
        title = nil
        let label = UILabel(frame: cgRect)
        label.setIcon(prefixText: prefixText, prefixTextFont: prefixTextFont, prefixTextColor: prefixTextColor, icon: icon, iconColor: iconColor, postfixText: postfixText, postfixTextFont: postfixTextFont, postfixTextColor: postfixTextColor, iconSize: iconSize)
        
        customView = label
    }
}

public extension UIStepper {
    
    /**
     This function sets the increment icon for UIStepper
     
     - Parameter icon: The icon for the for UIStepper
     - Parameter forState: Control state of the increment icon of the UIStepper
     
     - Version: 1.0
     */
    public func setIncrementIcon(icon: FontType?, forState state: UIControlState) {

        let backgroundSize = CGSize(width: 20, height: 20)
        let image = UIImage(icon: icon!, size: backgroundSize)
        setIncrementImage(image, for: state)
    }
    
    /**
     This function sets the decrement icon for UIStepper
     
     - Parameter icon: The icon for the for UIStepper
     - Parameter forState: Control state of the decrement icon of the UIStepper
     
     - Version: 1.0
     */
    public func setDecrementIcon(icon: FontType?, forState state: UIControlState) {

        let backgroundSize = CGSize(width: 20, height: 20)
        let image = UIImage(icon: icon!, size: backgroundSize)
        setDecrementImage(image, for: state)
    }
    
}

public extension UITextField {
    
    /**
     This function sets the icon for the right view of the UITextField
     
     - Parameter icon: The icon for the right view of the UITextField
     - Parameter rightViewMode: UITextFieldViewMode for the right view of the UITextField
     - Parameter textColor: Color for the icon
     - Parameter backgroundColor: Background color for the icon
     - Parameter size: CGSize for the icon
     
     - Version: 1.0
     */
    public func setRightViewIcon(icon: FontType, rightViewMode: UITextFieldViewMode = .always, textColor: UIColor = .black, backgroundColor: UIColor = .clear, size: CGSize? = nil) {
        FontLoader.loadFontIfNeeded(fontType: icon)

        let image = UIImage(icon: icon, size: size ?? CGSize(width: 30, height: 30), textColor: textColor, backgroundColor: backgroundColor)
        let imageView = UIImageView.init(image: image)
        
        self.rightView = imageView
        self.rightViewMode = rightViewMode
    }


    /**
     This function sets the icon for the left view of the UITextField
     
     - Parameter icon: The icon for the left view of the UITextField
     - Parameter rightViewMode: UITextFieldViewMode for the left view of the UITextField
     - Parameter textColor: Color for the icon
     - Parameter backgroundColor: Background color for the icon
     - Parameter size: CGSize for the icon
     
     - Version: 1.0
     */
    public func setLeftViewIcon(icon: FontType, leftViewMode: UITextFieldViewMode = .always, textColor: UIColor = .black, backgroundColor: UIColor = .clear, size: CGSize? = nil) {
        FontLoader.loadFontIfNeeded(fontType: icon)

        let image = UIImage(icon: icon, size: size ?? CGSize(width: 30, height: 30), textColor: textColor, backgroundColor: backgroundColor)
        let imageView = UIImageView.init(image: image)
        
        self.leftView = imageView
        self.leftViewMode = leftViewMode
    }
    
}

public extension UIViewController {
    
    /**
     This function sets the icon for the title of navigation bar
     
     - Parameter icon: The icon for the title of navigation bar
     - Parameter iconSize: Size of the icon
     - Parameter textColor: Color for the icon
     
     - Version: 1.0
     */
    public func setTitleIcon(icon: FontType, iconSize: CGFloat? = nil, color: UIColor = .black) {
        let size = iconSize ?? 23
        FontLoader.loadFontIfNeeded(fontType: icon)
        let font = UIFont(name: icon.fontName(), size: size)
        assert(font != nil, icon.errorAnnounce())
        let titleAttributes = [NSFontAttributeName: font!, NSForegroundColorAttributeName: color]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = icon.text
    }
}

public extension UIColor {
    
    /**
     This utility init function for UIColor
     
     - Parameter hex: The hexadecimal representation of the color
     
     */
    convenience init(hex: String) {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }
        if ((cString.characters.count) != 6) {
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

private class FontLoader {
    
    /**
     This utility function helps loading the font if not loaded already
     
     - Parameter fontType: The type of the font
     
     */
    static func loadFontIfNeeded(fontType : FontType) {
        let familyName = fontType.familyName()
        let fileName = fontType.fileName()
        
        if UIFont.fontNames(forFamilyName: familyName).count == 0 {
            let bundle = Bundle(for: FontLoader.self)
            let fontURL = bundle.url(forResource: fileName, withExtension: "ttf")!
            
            let data = try! Data(contentsOf: fontURL)
            let provider = CGDataProvider(data: data as CFData)
            let font = CGFont(provider!)
            
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
                let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
                NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
            }
        }
    }
}

protocol FontProtocol {
    func errorAnnounce() -> String
    func familyName() -> String
    func fileName() -> String
    func fontName() -> String
}


/**
 FontType Enum

 ````
 case dripicon
 case emoji()
 case fontAwesome()
 case googleMaterialDesign()
 case ionicons()
 case linearIcons()
 case mapicons()
 case openIconic()
 case state()
 case weather()
 ````
*/
public enum FontType: FontProtocol {
    /// It selects dripicon icon for the particular object from the library
    case dripicon(DripiconType)

    /// It selects emoji icon for the particular object from the library
    case emoji(EmojiType)

    /// It selects fontawesome icon for the particular object from the library
    case fontAwesome(FAType)

    /// It selects material icon for the particular object from the library
    case googleMaterialDesign(GoogleMaterialDesignType)

    /// It selects ionicon for the particular object from the library
    case ionicons(IoniconsType)
    
    /// It selects linearicons for the particular object from the library
    case linearIcons(LinearIconType)
    
    /// It selects mapicon for the particular object from the library
    case mapicons(MapiconsType)
    
    /// It selects open-iconic icon for the particular object from the library
    case openIconic(OpenIconicType)

    /// It selects state face icon for the particular object from the library
    case state(StatefaceType)

    /// It selects weather icon for the particular object from the library
    case weather(WeatherType)
    
    /**
     This function returns the font name using font type
     */
    func fontName() -> String {
        var fontName: String
        switch self {
        case .dripicon(_):
            fontName = "dripicons-v2"
            break
        case .emoji(_):
            fontName = "emoji"
            break
        case .fontAwesome(_):
            fontName = "FontAwesome"
            break
        case .ionicons(_):
            fontName = "Ionicons"
            break
        case .linearIcons(_):
            fontName = "Linearicons-Free"
            break
        case .mapicons(_):
            fontName = "map-icons"
            break
        case .googleMaterialDesign(_):
            fontName = "MaterialIcons-Regular"
            break
        case .openIconic(_):
            fontName = "open-iconic"
            break
        case .state(_):
            fontName = "StateFace-Regular"
            break
        case .weather(_):
            fontName = "WeatherIcons-Regular"
            break
        }
        return fontName
    }
    
    /**
     This function returns the file name from Source folder using font type
     */
    func fileName() -> String {
        var fileName: String
        switch self {
        case .dripicon(_):
            fileName = "Dripicons"
            break
        case .emoji(_):
            fileName = "Emoji"
            break
        case .fontAwesome(_):
            fileName = "FontAwesome"
            break
        case .ionicons(_):
            fileName = "Ionicons"
            break
        case .linearIcons(_):
            fileName = "Linearicons"
            break
        case .mapicons(_):
            fileName = "MapIcons"
            break
        case .googleMaterialDesign(_):
            fileName = "MaterialIcons"
            break
        case .openIconic(_):
            fileName = "OpenIconic"
            break
        case .state(_):
            fileName = "Stateface"
            break
        case .weather(_):
            fileName = "WeatherIcons"
            break
        }
        return fileName
    }
    
    /**
     This function returns the font family name using font type
     */
    func familyName() -> String {
        var familyName: String
        switch self {
        case .dripicon(_):
            familyName = "dripicons-v2"
            break
        case .emoji(_):
            familyName = "emoji"
            break
        case .fontAwesome(_):
            familyName = "FontAwesome"
            break
        case .ionicons(_):
            familyName = "Ionicons"
            break
        case .openIconic(_):
            familyName = "Icons"
            break
        case .linearIcons(_):
            familyName = "Linearicons-Free"
            break
        case .mapicons(_):
            familyName = "map-icons"
            break
        case .googleMaterialDesign(_):
            familyName = "Material Icons"
            break
        case .state(_):
            familyName = "StateFace"
            break
        case .weather(_):
            familyName = "Weather Icons"
            break
        }
        return familyName
    }
    
    /**
     This function returns the error for a font type
     */
    func errorAnnounce() -> String {
        let message = " FONT - not associated with Info.plist when manual installation was performed";
        let fontName = self.fontName().uppercased()
        let errorAnnounce = fontName.appending(message)
        return errorAnnounce
    }
    
    /**
     This function returns the text for the icon
     */
    public var text: String? {
        var text: String
        
        switch self {
        case let .dripicon(icon):
            text = icon.text!
            break
        case let .emoji(icon):
            text = icon.text!
            break
        case let .fontAwesome(icon):
            text = icon.text!
            break
        case let .ionicons(icon):
            text = icon.text!
            break
        case let .linearIcons(icon):
            text = icon.text!
            break
        case let .mapicons(icon):
            text = icon.text!
            break
        case let .googleMaterialDesign(icon):
            text = icon.text!
            break
        case let .openIconic(icon):
            text = icon.text!
            break
        case let .state(icon):
            text = icon.text!
            break
        case let .weather(icon):
            text = icon.text!
            break
        }
        
        return text
    }
}

/**
 List of all icons in dripicons
 
 - Author - [Amit Jakhu](http://www.amitjakhu.com/)
 - Version: 2.0
 
 ## Important Notes ##
 For icons, please visit [dripicons](https://github.com/amitjakhu/dripicons)
 Please check this [license](https://github.com/amitjakhu/dripicons/blob/master/LICENSE)
*/
public enum DripiconType: Int {
    
    static var count: Int {
        return dripIcons.count
    }
    
    public var text: String? {
        return dripIcons[rawValue]
    }
    
    case alarm, alignCenter, alignJustify, alignLeft, alignRight, anchor, archieve, arrowDown, arrowLeft, arrowRight, arrowThinDown, arrowThinLeft, arrowThinRight, arrowThinUp, arrowUp, article, backspace, basket, basketball, batteryEmpty, batteryFull, batteryLow, batteryMedium, bell, blog, bluetooth, bold, bookmark, bookmarks, box, briefcase, brightnessLow, brightnessMax, brightnessMedium, broadcast, browser, browserUpload, brush, calendar, camcorder, camera, card, cart, checklist, checkmark, chevronDown, chevronLeft, chevronRight, chevronUp, clipboard, clock, clockwise, cloud, cloudDownload, cloudUpload, code, contract, contract2, conversation, copy, crop , cross, crosshair, cutlery, deviceDesktop, deviceMobile, deviceTablet, direction, disc, document, documentDelete, documentEdit, documentNew, documentRemove, dot, dots2, dots3, download, duplicate, enter, exit, expand, expand2, experiment, export, feed, flag, flashlight, folder, folderOpen, forward, gaming, gear, graduation, graphBar, graphLine, graphPie, headset, heart, help, home, hourglass, inbox, information, italic, jewel, lifting, lightbulb, link, linkBroken, list, loading, location, lock, lockOpen, mail, map, mediaLoop, mediaNext, mediaPause, mediaPlay, mediaPrevious, mediaRecord, mediaShuffle, mediaStop, medical, menu, message, meter, microphone, minus, monitor, move, music, network1, network2, network3, network4, network5, pamphlet, paperclip, pencil, phone, photo, photoGroup, pill, pin, plus, power, preview, print, pulse, question, reply, replyAll, returnIcon, retweet, rocket, scale, search, shoppingBag, skip, stack, star, stopwatch, store, suitcase, swap, tag, tagDelete, tags, thumbsDown, thumbsUp, ticket, timeReverse, toDo, toggles, trash, trophy, upload, user, userGroup, userId, vibrate, viewApps, viewList, viewListLarge, viewThumb, volumeFull, volumeLow, volumeMedium, volumeOff, wallet, warning, web, weight, wifi, wrong, zoomIn, zoomOut
}

private let dripIcons = ["\u{61}", "\u{62}", "\u{63}", "\u{64}", "\u{65}", "\u{66}", "\u{67}", "\u{68}", "\u{69}", "\u{6a}", "\u{6b}", "\u{6c}", "\u{6d}", "\u{6e}", "\u{6f}", "\u{70}", "\u{71}", "\u{72}", "\u{73}", "\u{74}", "\u{75}", "\u{76}", "\u{77}", "\u{78}", "\u{79}", "\u{7a}", "\u{41}", "\u{42}", "\u{43}", "\u{44}", "\u{45}", "\u{46}", "\u{47}", "\u{48}", "\u{49}", "\u{4a}", "\u{4b}", "\u{4c}", "\u{4d}", "\u{4e}", "\u{4f}", "\u{50}", "\u{51}", "\u{52}", "\u{53}", "\u{54}", "\u{55}", "\u{56}", "\u{57}", "\u{58}", "\u{59}", "\u{5a}", "\u{30}", "\u{31}", "\u{32}", "\u{33}", "\u{34}", "\u{35}", "\u{36}", "\u{37}", "\u{38}", "\u{39}", "\u{21}", "\u{22}", "\u{23}", "\u{24}", "\u{25}", "\u{26}", "\u{27}", "\u{28}", "\u{29}", "\u{2a}", "\u{2b}", "\u{2c}", "\u{2d}", "\u{2e}", "\u{2f}", "\u{3a}", "\u{3b}", "\u{3c}", "\u{3d}", "\u{3e}", "\u{3f}", "\u{40}", "\u{5b}", "\u{5d}", "\u{5e}", "\u{5f}", "\u{60}", "\u{7b}", "\u{7c}", "\u{7d}", "\u{7e}", "\u{5c}", "\u{e000}", "\u{e001}", "\u{e002}", "\u{e003}", "\u{e004}", "\u{e005}", "\u{e006}", "\u{e007}", "\u{e008}", "\u{e009}", "\u{e00a}", "\u{e00b}", "\u{e00c}", "\u{e00d}", "\u{e00e}", "\u{e00f}", "\u{e010}", "\u{e011}", "\u{e012}", "\u{e013}", "\u{e014}", "\u{e015}", "\u{e016}", "\u{e017}", "\u{e018}", "\u{e019}", "\u{e01a}", "\u{e01b}", "\u{e01c}", "\u{e01d}", "\u{e01e}", "\u{e01f}", "\u{e020}", "\u{e021}", "\u{e022}", "\u{e023}", "\u{e024}", "\u{e025}", "\u{e026}", "\u{e027}", "\u{e028}", "\u{e029}", "\u{e02a}", "\u{e02b}", "\u{e02c}", "\u{e02d}", "\u{e02e}", "\u{e02f}", "\u{e030}", "\u{e031}", "\u{e032}", "\u{e033}", "\u{e034}", "\u{e035}", "\u{e036}", "\u{e037}", "\u{e038}", "\u{e039}", "\u{e03a}", "\u{e03b}", "\u{e03c}", "\u{e03d}", "\u{e03e}", "\u{e03f}", "\u{e040}", "\u{e041}", "\u{e042}", "\u{e043}", "\u{e044}", "\u{e045}", "\u{e046}", "\u{e047}", "\u{e048}", "\u{e049}", "\u{e04a}", "\u{e04b}", "\u{e04c}", "\u{e04d}", "\u{e04e}", "\u{e04f}", "\u{e050}", "\u{e051}", "\u{e052}", "\u{e053}", "\u{e054}", "\u{e055}", "\u{e056}", "\u{e057}", "\u{e058}", "\u{e059}", "\u{e05a}", "\u{e05b}", "\u{e05c}", "\u{e05d}", "\u{e05e}", "\u{e05f}", "\u{e060}", "\u{e061}", "\u{e062}", "\u{e063}", "\u{e064}", "\u{e065}", "\u{e066}", "\u{e067}", "\u{e068}", "\u{e069}"]


/**
 List of all icons in emoji
 
 - Author - [John Slegers](http://www.johnslegers.com/)
 
 ## Important Notes ##
 For icons, please visit [emoji](http://jslegers.github.io/emoji-icon-font/)
 */
public enum EmojiType: Int {
    static var count: Int {
        return emojiIcons.count
    }
    
    public var text: String? {
        return emojiIcons[rawValue]
    }
    
    case aceOfClubs, aceOfDiamonds, aceOfHearts, aceOfSpades, addressbook, airplane, alarm, aleph, alien, ampersand, anchor, animalAnt, animalBactrianCamel, animalBug, animalCat, animalCow, animalDolphin, animalDromedaryCamel, animalGoat, animalHorse, animalPig, animalRabbit, animalRooster, animalSnail, ankh, apple, arrowDown, arrowDownLeft, arrowDownRight, arrowForward, arrowLeft, arrowLeftRight, arrowRedo, arrowReply, arrowRight, arrowUndo, arrowUp, arrowUpDown, arrowUpLeft, arrowUpRight, asclepius, asteriskFive, asteriskSix, at, atSymbol, atom, baby, babyBottle, backward, balloon, bank, banknote, baseball, battery, beach, bell, bicycle, bicyclist, billiards, biohazard, blackFlorette, bolt, bomb, book, bookOpen, bookmark, books, bouquet, bowling, braceLeft, braceRight, bread, brightness, browserChrome, browserFirefox, browserIe, browserOpera, browserSafari, building, bullhorn, bullseye, bus, busFront, cabinet, cactus, caduceus, cake, calculator, calendarDay, calendarMonth, cameraMovie, cancel, candle, candy, car, carFront, caretDown, caretLeft, caretRight, caretUp, castle, celticCross, chair, chart, chartDown, chartLine, chartUp, check, checkboxChecked, checkboxPartial, checkboxUnchecked, chessBlackBishop, chessBlackKing, chessBlackKnight, chessBlackPawn, chessBlackQueen, chessBlackRook, chessWhiteBishop, chessWhiteKing, chessWhiteKnight, chessWhitePawn, chessWhiteQueen, chessWhiteRook, chessboard, chiRho, chickenLeg, christmasTree, church, cinema, circle, circleArrowDown, circleArrowLeft, circleArrowRight, circleArrowUp, circleOpen, circus, clipboard, clock, close, cloud, clubs, coffin, comet, command, computerNetwork, constructionWorker, contrast, convenienceStore, cooking, copy, copyright, creditcard, crossOfJerusalem, crossOfLorraine, crossOrthodox, crossPommee, crossedSwords, crosshairs, crown, currencyDollar, currencyEuro, currencyExchange, currencyPound, dagger, dancing, database, death, diamond, diamonds, die, digg, digitEight, digitFive, digitFour, digitNine, digitOne, digitSeven, digitSix, digitThree, digitTwo, digitZero, disk, divide, dna, donut, drinkBeer, drinkCocktail, drinkCoffee, drinkTropical, drinkWine, droplet, ear, eject, electricCord, enter, envelope, envelopeStamped, exclamationMark, explosion, eye, eyeglasses, faceBaby, faceBear, faceBoy, faceCallcenter, faceChihuahua, faceGirl, faceHamster, faceKitty, faceMan, faceManWithTurban, faceMonkey, faceOldChineseMan, facePrincess, faceSantaClaus, faceWoman, factory, family, farsi, ferrisWheel, file, fileImage, fileText, film, filmReel, fire, fireworks, first, flag, flagCheckered, flagOpen, flashlight, fleurDeLis, floppy, florette, flower, folder, folderOpen, fontSize, foodChicken, foodHamburger, foodIceCream, foodPizza, foodRice, foodSpaghetti, footballAmerican, footballSoccer, footprints, forbidden, forkKnife, forkKnifePlate, forward, fountain, fourCorners, fourLeafClover, fries, fuelPump, gClef, garbageCan, gear, gearNoHub, genderFemale, genderFemaleFemale, genderMale, genderMaleFemale, genderMaleMale, genderNonBinary, genderTransgender, ghost, gift, gingerbread, globe2, globeMeridians, graduation, grapes, guardIcon, guitar, hammer, hammerAndPick, hammerSickle, hammerWrench, hand, handFist, handbag, hardDisk, headphone, headstone, heart, heartBeating, heartBroken, heartOpen, heartRibbon, heartTilted, heartWithArrow, hearts, helm, herb, hexagon, highHeeledShoes, home, hotel, hourglass, iceSkater, imp, inbox, infinity, jackOLantern, joystick, key, keyAlt, keyboard, keyboardWireless, khanda, kiss, knife, label, laptop, last, lastfm, latinCross, latinCrossOutline, leaf, leftLuggage, lemon, letterA, letterB, letterC, letterD, letterE, letterF, letterG, letterH, letterI, letterJ, letterK, letterL, letterM, letterN, letterO, letterP, letterQ, letterR, letterS, letterT, letterU, letterV, letterW, letterX, letterY, letterZ, lightbulb, link, linux, lipstick, lock, lockOpen, lollipop, loop, loopAlt, malteseCross, manAndMan, manAndWoman, mapleLeaf, maximizeWindow, medalMilitary, medalSports, menu, microphone, microscope, minimize, minus, moneyBag, monitor, moonFirstQuarter, moonFull, moonLastQuarter, moonNew, moonWaningCrescent, moonWaningGibbous, moonWaxingCrescent, moonWaxingGibbous, motorbike, mouse, movie, multiply, mushroom, musicEighthNote, musicEigthNotes, musicPlayer, musicQuarterNote, musicSixteenthNotes, musicTrumpet, musicViolin, newspaper, nextPage, noEntry, notebook, notepad, number, nutAndBolt, om, omega, osAndroid, osApple, osWindows, outbox, outfitBikini, outfitDress, outfitNecktie, outfitShirt, pager, palette, panda, paperclip, parenthesisLeft, parenthesisRight, passportControl, pause, pawPrints, pcDesktop, pcOld, peace, peaceDove, pear, pedestrian, pen, pencil, pentagon, pentagram, pentagramInverted, percent, performingArts, permanentPaper, perthousand, phone, phoneLocation, phoneMobile, phoneReceiver, photoCamera, photoCameraFlash, piano, pick, picture, pieChart, pieChartReverse, pill, pistol, play, plus, pointDown, pointLeft, pointRight, pointUp, potFood, previousPage, printScreen, printer, projector, purse, pushpin, questionMark, radiation, radio, radioChecked, rainbow, record, recycle, registered, restroom, retrograde, riceBall, ring, rocket, rollercoaster, rotateCcw, rotateCcwSide, rotateCw, rotateCwSide, ruler, ruler2, running, sandals, satelliteDisk, saxophone, scales, school, scissors, searchLeft, searchRight, shamrock, shield, shieldWithCross, shuffle, skier, skull, skullAndBones, slotMachine, smiley, smileyCool, smileyEvil, smileyGrin, smileyHappy, smileySad, smoking, smokingForbidden, snake, snowboarding, snowflake, snowman, spades, speechBubble, spider, spider7Web, spy, square, squareBracketLeft, squareBracketRight, squareMinus, squarePlus, stackWindow, star, starAndCrescent, starCircled, starEightPoints, starOfDavid, starOpen, starShooting, steamingBowl, stop, stopwatch, suitcase, sun, sunglasses, sushi, swastikaLeft, swastikaRight, swimming, syringe, tao, tape, target, telescope, television, temple, tennis, tent, thumbsDown, thumbsUp, ticket, tomato3, tophat, trafficLight, tree, treePalm, treePine, trophy, truck, umbrella, user, users, videoCamera, videogame, vk, volume, volumeHigh, volumeLow, volumeMute, warning, watch, waterWave, webBehance, webBlogger, webCircles, webDelicious, webDeviantart, webDribbble, webDropbox, webDrupal, webEvernote, webFacebook, webFlattr, webFlickr, webForrst, webFoursquare, webGit, webGithub, webGoogleDrive, webGoogleplus, webInstagram, webJoomla, webLastfm, webLinkedin, webMixi, webPaypal, webPicasa, webPicassa, webPinterest, webQq, webRdio, webReddit, webRenren, webSinaWeibo, webSkype, webSmashing, webSoundcloud, webSpotify, webStackoverflow, webSteam, webStumbleupon, webTumblr, webTwitter, webVimeo, webVine, webVk, webWordpress, webYelp, weighlifting, wheelOfDharma, wheelchair, womanAndWoman, worldMap, wrench, yen, youtube
}

private let emojiIcons = ["\u{1f0d1}", "\u{1f0c1}", "\u{1f0b1}", "\u{1f0a1}", "\u{1f4d2}", "\u{2708}", "\u{23f0}", "\u{2135}", "\u{1f47d}", "\u{ff06}", "\u{2693}", "\u{1f41c}", "\u{1f42b}", "\u{1f41b}", "\u{1f408}", "\u{1f404}", "\u{1f42c}", "\u{1f42a}", "\u{1f410}", "\u{1f40e}", "\u{1f416}", "\u{1f407}", "\u{1f413}", "\u{1f40c}", "\u{2625}", "\u{1f34e}", "\u{2b07}", "\u{2b0b}", "\u{2b0a}", "\u{2ba9}", "\u{2b05}", "\u{2b0c}", "\u{2bab}", "\u{2ba8}", "\u{27a1}", "\u{2baa}", "\u{2b06}", "\u{2b0d}", "\u{2b09}", "\u{2b08}", "\u{2695}", "\u{ff0a}", "\u{2731}", "\u{ff3c}", "\u{ff20}", "\u{269b}", "\u{1f6bc}", "\u{1f37c}", "\u{23ea}", "\u{1f388}", "\u{1f3e6}", "\u{1f4b5}", "\u{26be}", "\u{1f50b}", "\u{26f1}", "\u{1f514}", "\u{1f6b2}", "\u{1f6b4}", "\u{1f3b1}", "\u{2623}", "\u{273f}", "\u{26a1}", "\u{1f4a3}", "\u{1f4d5}", "\u{1f4d6}", "\u{1f516}", "\u{1f4da}", "\u{1f490}", "\u{1f3b3}", "\u{ff5b}", "\u{fe5c}", "\u{1f35e}", "\u{1f506}", "\u{e62a}", "\u{e62b}", "\u{e62c}", "\u{e62d}", "\u{e62e}", "\u{1f3e2}", "\u{1f56b}", "\u{25ce}", "\u{1f68c}", "\u{1f68d}", "\u{1f5c4}", "\u{1f335}", "\u{2624}", "\u{1f382}", "\u{1f5a9}", "\u{1f4c6}", "\u{1f4c5}", "\u{1f3a5}", "\u{1f5d9}", "\u{1f56f}", "\u{1f36c}", "\u{1f697}", "\u{1f698}", "\u{23f7}", "\u{23f4}", "\u{23f5}", "\u{23f6}", "\u{1f3f0}", "\u{1f548}", "\u{1f4ba}", "\u{1f4ca}", "\u{1f4c9}", "\u{1f5e0}", "\u{1f4c8}", "\u{2714}", "\u{2611}", "\u{25a3}", "\u{2610}", "\u{265d}", "\u{265a}", "\u{265e}", "\u{265f}", "\u{265b}", "\u{265c}", "\u{2657}", "\u{2654}", "\u{2658}", "\u{2659}", "\u{2655}", "\u{2656}", "\u{2593}", "\u{2627}", "\u{1f357}", "\u{1f384}", "\u{26ea}", "\u{1f3a6}", "\u{23fa}", "\u{2b8b}", "\u{2b88}", "\u{2b8a}", "\u{2b89}", "\u{25cb}", "\u{1f3aa}", "\u{1f4cb}", "\u{1f553}", "\u{2297}", "\u{2601}", "\u{2663}", "\u{26b0}", "\u{2604}", "\u{2318}", "\u{1f5a7}", "\u{1f477}", "\u{25d1}", "\u{1f3ea}", "\u{1f373}", "\u{1f5d0}", "\u{a9}", "\u{1f4b3}", "\u{2629}", "\u{2628}", "\u{2626}", "\u{1f542}", "\u{2694}", "\u{2316}", "\u{1f451}", "\u{ff04}", "\u{20ac}", "\u{1f4b1}", "\u{ffe1}", "\u{1f5e1}", "\u{1f483}", "\u{26c3}", "\u{1f571}", "\u{1f48e}", "\u{2666}", "\u{1f3b2}", "\u{f1a6}", "\u{ff18}", "\u{ff15}", "\u{ff14}", "\u{ff19}", "\u{ff11}", "\u{ff17}", "\u{ff16}", "\u{ff13}", "\u{ff12}", "\u{ff10}", "\u{1f4bf}", "\u{2797}", "\u{26d3}", "\u{1f369}", "\u{1f37a}", "\u{1f378}", "\u{2615}", "\u{1f379}", "\u{1f377}", "\u{1f4a7}", "\u{1f442}", "\u{23cf}", "\u{1f50c}", "\u{2386}", "\u{2709}", "\u{1f583}", "\u{ff01}", "\u{1f4a5}", "\u{1f441}", "\u{1f453}", "\u{1f476}", "\u{1f43b}", "\u{1f466}", "\u{1f481}", "\u{1f436}", "\u{1f467}", "\u{1f439}", "\u{1f431}", "\u{1f468}", "\u{1f473}", "\u{1f435}", "\u{1f474}", "\u{1f478}", "\u{1f385}", "\u{1f469}", "\u{1f3ed}", "\u{1f46a}", "\u{262b}", "\u{1f3a1}", "\u{1f5cb}", "\u{1f5bb}", "\u{1f5b9}", "\u{1f39e}", "\u{2707}", "\u{1f525}", "\u{1f386}", "\u{23ee}", "\u{2691}", "\u{1f3c1}", "\u{2690}", "\u{1f526}", "\u{269c}", "\u{1f4be}", "\u{2740}", "\u{2698}", "\u{1f5c0}", "\u{1f5c1}", "\u{1f5db}", "\u{1f414}", "\u{1f354}", "\u{1f368}", "\u{1f355}", "\u{1f35a}", "\u{1f35d}", "\u{1f3c8}", "\u{26bd}", "\u{1f463}", "\u{1f6ab}", "\u{1f374}", "\u{1f37d}", "\u{23e9}", "\u{26f2}", "\u{26f6}", "\u{1f340}", "\u{1f35f}", "\u{26fd}", "\u{1d11e}", "\u{1f5d1}", "\u{2699}", "\u{26ed}", "\u{2640}", "\u{26a2}", "\u{2642}", "\u{26a4}", "\u{26a3}", "\u{26a7}", "\u{26a6}", "\u{1f47b}", "\u{1f381}", "\u{1f36a}", "\u{1f30d}", "\u{1f310}", "\u{1f393}", "\u{1f347}", "\u{1f482}", "\u{1f3b8}", "\u{1f528}", "\u{2692}", "\u{262d}", "\u{1f6e0}", "\u{270b}", "\u{270a}", "\u{1f45c}", "\u{1f5b4}", "\u{1f3a7}", "\u{26fc}", "\u{2665}", "\u{1f493}", "\u{1f494}", "\u{2661}", "\u{1f49d}", "\u{2765}", "\u{1f498}", "\u{1f495}", "\u{2388}", "\u{1f33f}", "\u{2b23}", "\u{1f460}", "\u{1f3e0}", "\u{1f3e8}", "\u{23f3}", "\u{26f8}", "\u{1f47f}", "\u{1f4e5}", "\u{221e}", "\u{1f383}", "\u{1f579}", "\u{1f511}", "\u{1f5dd}", "\u{1f5ae}", "\u{2328}", "\u{262c}", "\u{1f48b}", "\u{1f52a}", "\u{1f3f7}", "\u{1f4bb}", "\u{23ed}", "\u{e632}", "\u{271d}", "\u{271f}", "\u{1f342}", "\u{1f6c5}", "\u{1f34b}", "\u{ff21}", "\u{ff22}", "\u{ff23}", "\u{ff24}", "\u{ff25}", "\u{ff26}", "\u{ff27}", "\u{ff28}", "\u{ff29}", "\u{ff2a}", "\u{ff2b}", "\u{ff2c}", "\u{ff2d}", "\u{ff2e}", "\u{ff2f}", "\u{ff30}", "\u{ff31}", "\u{ff32}", "\u{ff34}", "\u{ff35}", "\u{ff36}", "\u{ff37}", "\u{ff38}", "\u{ff39}", "\u{59}", "\u{ff3a}", "\u{1f4a1}", "\u{1f517}", "\u{1f427}", "\u{1f484}", "\u{1f50f}", "\u{1f513}", "\u{1f36d}", "\u{1f501}", "\u{1f503}", "\u{2720}", "\u{1f46c}", "\u{1f46b}", "\u{1f341}", "\u{1f5d6}", "\u{1f396}", "\u{1f3c5}", "\u{2630}", "\u{1f3a4}", "\u{1f52c}", "\u{1f5d5}", "\u{2796}", "\u{1f4b0}", "\u{1f5b5}", "\u{1f313}", "\u{1f315}", "\u{1f317}", "\u{1f311}", "\u{1f318}", "\u{1f316}", "\u{1f312}", "\u{1f314}", "\u{1f3cd}", "\u{1f5b1}", "\u{1f3ac}", "\u{2716}", "\u{1f344}", "\u{266a}", "\u{266b}", "\u{1f4fe}", "\u{2669}", "\u{266c}", "\u{1f3ba}", "\u{1f3bb}", "\u{1f4f0}", "\u{2398}", "\u{26d4}", "\u{1f4d3}", "\u{1f5ca}", "\u{ff03}", "\u{1f529}", "\u{1f549}", "\u{2126}", "\u{e618}", "\u{f8ff}", "\u{e61f}", "\u{1f4e4}", "\u{1f459}", "\u{1f457}", "\u{1f454}", "\u{1f455}", "\u{1f4df}", "\u{1f3a8}", "\u{1f43c}", "\u{1f4ce}", "\u{ff08}", "\u{ff09}", "\u{1f6c2}", "\u{23f8}", "\u{1f43e}", "\u{1f5a5}", "\u{1f5b3}", "\u{262e}", "\u{1f54a}", "\u{1f350}", "\u{1f6b6}", "\u{1f58a}", "\u{270f}", "\u{2b1f}", "\u{26e4}", "\u{26e7}", "\u{ff05}", "\u{1f3ad}", "\u{267e}", "\u{2030}", "\u{260e}", "\u{2706}", "\u{1f4f1}", "\u{1f4de}", "\u{1f4f7}", "\u{1f4f8}", "\u{1f3b9}", "\u{26cf}", "\u{1f5bc}", "\u{25d5}", "\u{25d4}", "\u{1f48a}", "\u{1f52b}", "\u{25b6}", "\u{271a}", "\u{261f}", "\u{261c}", "\u{261e}", "\u{261d}", "\u{1f372}", "\u{2397}", "\u{2399}", "\u{1f5b6}", "\u{1f4fd}", "\u{1f45b}", "\u{1f4cc}", "\u{ff1f}", "\u{2622}", "\u{1f4fb}", "\u{1f518}", "\u{1f308}", "\u{2609}", "\u{267b}", "\u{ae}", "\u{1f6bb}", "\u{211e}", "\u{1f359}", "\u{1f48d}", "\u{1f680}", "\u{1f3a2}", "\u{21ba}", "\u{27f3}", "\u{21bb}", "\u{27f2}", "\u{1f4d0}", "\u{1f4cf}", "\u{1f3c3}", "\u{1f461}", "\u{1f4e1}", "\u{1f3b7}", "\u{2696}", "\u{1f3eb}", "\u{2702}", "\u{1f50d}", "\u{1f50e}", "\u{2618}", "\u{1f6e1}", "\u{26e8}", "\u{1f500}", "\u{26f7}", "\u{1f480}", "\u{2620}", "\u{1f3b0}", "\u{263a}", "\u{1f60e}", "\u{1f608}", "\u{1f604}", "\u{1f603}", "\u{2639}", "\u{1f6ac}", "\u{1f6ad}", "\u{1f40d}", "\u{1f3c2}", "\u{2744}", "\u{2603}", "\u{2660}", "\u{1f4ac}", "\u{1f577}", "\u{1f578}", "\u{1f575}", "\u{25a0}", "\u{ff3b}", "\u{ff3d}", "\u{229f}", "\u{229e}", "\u{ff33}", "\u{2605}", "\u{262a}", "\u{272a}", "\u{2734}", "\u{2721}", "\u{2606}", "\u{1f320}", "\u{1f35c}", "\u{23f9}", "\u{23f1}", "\u{1f4bc}", "\u{2600}", "\u{1f576}", "\u{1f363}", "\u{534d}", "\u{5350}", "\u{1f3ca}", "\u{1f489}", "\u{262f}", "\u{1f5ad}", "\u{1f3af}", "\u{1f52d}", "\u{1f4fa}", "\u{26e9}", "\u{1f3be}", "\u{26fa}", "\u{1f44e}", "\u{1f44d}", "\u{1f39f}", "\u{1f345}", "\u{1f3a9}", "\u{1f6a6}", "\u{1f333}", "\u{1f334}", "\u{1f332}", "\u{1f3c6}", "\u{1f69a}", "\u{2602}", "\u{1f464}", "\u{1f465}", "\u{1f4f9}", "\u{1f3ae}", "\u{f189}", "\u{1f508}", "\u{1f50a}", "\u{1f509}", "\u{1f3e1}", "\u{26a0}", "\u{231a}", "\u{1f30a}", "\u{e61a}", "\u{e626}", "\u{e61b}", "\u{e629}", "\u{e622}", "\u{e600}", "\u{e610}", "\u{e635}", "\u{e611}", "\u{e604}", "\u{e612}", "\u{e620}", "\u{e61e}", "\u{e633}", "\u{e625}", "\u{e624}", "\u{e62f}", "\u{e605}", "\u{e60f}", "\u{e631}", "\u{e60b}", "\u{e608}", "\u{e619}", "\u{e616}", "\u{e617}", "\u{e621}", "\u{e606}", "\u{e60e}", "\u{e60c}", "\u{e628}", "\u{e614}", "\u{e615}", "\u{e613}", "\u{e61d}", "\u{e627}", "\u{e60d}", "\u{e601}", "\u{e623}", "\u{e60a}", "\u{e607}", "\u{e603}", "\u{e602}", "\u{f1ca}", "\u{e61c}", "\u{e630}", "\u{e634}", "\u{1f3cb}", "\u{2638}", "\u{267f}", "\u{1f46d}", "\u{1f5fa}", "\u{1f527}", "\u{ffe5}", "\u{e636}"]


/**
 List of all icons in FontAwesome
 
 - Author - [Dave Gandy](https://twitter.com/davegandy)
 - Version: 4.7.0
 
 ## Important Notes ##
 For icons, please visit [font-awesome](http://fontawesome.io/icons/)
 Please check this [license](http://fontawesome.io/license/)
 */
public enum FAType: Int {
    static var count: Int {
        return faIcons.count
    }
    
    public var text: String? {
        return faIcons[rawValue]
    }
    
    case fivehundredpx, addressBook, addressBookO, addressCard, addressCardO, adjust, adn, alignCenter, alignJustify, alignLeft, alignRight, amazon, ambulance, americanSignLanguageInterpreting, anchor, android, angellist, angleDoubleDown, angleDoubleLeft, angleDoubleRight, angleDoubleUp, angleDown, angleLeft, angleRight, angleUp, apple, archive, areaChart, arrowCircleDown, arrowCircleLeft, arrowCircleODown, arrowCircleOLeft, arrowCircleORight, arrowCircleOUp, arrowCircleRight, arrowCircleUp, arrowDown, arrowLeft, arrowRight, arrowUp, arrows, arrowsAlt, arrowsH, arrowsV, aslInterpreting, assistiveListeningSystems, asterisk, at, audioDescription, automobile, backward, balanceScale, ban, bandcamp, bank, barChart, barChartO, barcode, bars, bath, bathtub, battery, battery0, battery1, battery2, battery3, battery4, batteryEmpty, batteryFull, batteryHalf, batteryQuarter, batteryThreeQuarters, bed, beer, behance, behanceSquare, bell, bellO, bellSlash, bellSlashO, bicycle, binoculars, birthdayCake, bitbucket, bitbucketSquare, bitcoin, blackTie, blind, bluetooth, bluetoothB, bold, bolt, bomb, book, bookmark, bookmarkO, braille, briefcase, btc, bug, building, buildingO, bullhorn, bullseye, bus, buysellads, cab, calculator, calendar, calendarCheckO, calendarMinusO, calendarO, calendarPlusO, calendarTimesO, camera, cameraRetro, car, caretDown, caretLeft, caretRight, caretSquareODown, caretSquareOLeft, caretSquareORight, caretSquareOUp, caretUp, cartArrowDown, cartPlus, cc, ccAmex, ccDinersClub, ccDiscover, ccJcb, ccMastercard, ccPaypal, ccStripe, ccVisa, certificate, chain, chainBroken, check, checkCircle, checkCircleO, checkSquare, checkSquareO, chevronCircleDown, chevronCircleLeft, chevronCircleRight, chevronCircleUp, chevronDown, chevronLeft, chevronRight, chevronUp, child, chrome, circle, circleO, circleONotch, circleThin, clipboard, clockO, clone, close, cloud, cloudDownload, cloudUpload, cny, code, codeFork, codepen, codiepie, coffee, cog, cogs, columns, comment, commentO, commenting, commentingO, comments, commentsO, compass, compress, connectdevelop, contao, copy, copyright, creativeCommons, creditCard, creditCardAlt, crop, crosshairs, css3, cube, cubes, cut, cutlery, dashboard, dashcube, database, deaf, deafness, dedent, delicious, desktop, deviantart, diamond, digg, dollar, dotCircleO, download, dribbble, driversLicense, driversLicenseO, dropbox, drupal, edge, edit, eercast, eject, ellipsisH, ellipsisV, empire, envelope, envelopeO, envelopeOpen, envelopeOpenO, envelopeSquare, envira, eraser, etsy, eur, euro, exchange, exclamation, exclamationCircle, exclamationTriangle, expand, expeditedssl, externalLink, externalLinkSquare, eye, eyeSlash, eyedropper, fa, facebook, facebookF, facebookOfficial, facebookSquare, fastBackward, fastForward, fax, feed, female, fighterJet, file, fileArchiveO, fileAudioO, fileCodeO, fileExcelO, fileImageO, fileMovieO, fileO, filePdfO, filePhotoO, filePictureO, filePowerpointO, fileSoundO, fileText, fileTextO, fileVideoO, fileWordO, fileZipO, filesO, film, filter, fire, fireExtinguisher, firefox, firstOrder, flag, flagCheckered, flagO, flash, flask, flickr, floppyO, folder, folderO, folderOpen, folderOpenO, font, fontAwesome, fonticons, fortAwesome, forumbee, forward, foursquare, freeCodeCamp, frownO, futbolO, gamepad, gavel, gbp, ge, gear, gears, genderless, getPocket, gg, ggCircle, gift, git, gitSquare, github, githubAlt, githubSquare, gitlab, gittip, glass, glide, glideG, globe, google, googlePlus, googlePlusCircle, googlePlusOfficial, googlePlusSquare, googleWallet, graduationCap, gratipay, grav, group, hSquare, hackerNews, handGrabO, handLizardO, handODown, handOLeft, handORight, handOUp, handPaperO, handPeaceO, handPointerO, handRockO, handScissorsO, handSpockO, handStopO, handshakeO, hardOfHearing, hashtag, hddO, header, headphones, heart, heartO, heartbeat, history, home, hospitalO, hotel, hourglass, hourglass1, hourglass2, hourglass3, hourglassEnd, hourglassHalf, hourglassO, hourglassStart, houzz, html5, iCursor, idBadge, idCard, idCardO, ils, image, imdb, inbox, indent, industry, info, infoCircle, inr, instagram, institution, internetExplorer, intersex, ioxhost, italic, joomla, jpy, jsfiddle, key, keyboardO, krw, language, laptop, lastfm, lastfmSquare, leaf, leanpub, legal, lemonO, levelDown, levelUp, lifeBouy, lifeBuoy, lifeRing, lifeSaver, lightbulbO, lineChart, link, linkedin, linkedinSquare, linode, linux, list, listAlt, listOl, listUl, locationArrow, lock, longArrowDown, longArrowLeft, longArrowRight, longArrowUp, lowVision, magic, magnet, mailForward, mailReply, mailReplyAll, male, map, mapMarker, mapO, mapPin, mapSigns, mars, marsDouble, marsStroke, marsStrokeH, marsStrokeV, maxcdn, meanpath, medium, medkit, meetup, mehO, mercury, microchip, microphone, microphoneSlash, minus, minusCircle, minusSquare, minusSquareO, mixcloud, mobile, mobilePhone, modx, money, moonO, mortarBoard, motorcycle, mousePointer, music, navicon, neuter, newspaperO, objectGroup, objectUngroup, odnoklassniki, odnoklassnikiSquare, opencart, openid, opera, optinMonster, outdent, pagelines, paintBrush, paperPlane, paperPlaneO, paperclip, paragraph, paste, pause, pauseCircle, pauseCircleO, paw, paypal, pencil, pencilSquare, pencilSquareO, percent, phone, phoneSquare, photo, pictureO, pieChart, piedPiper, piedPiperAlt, piedPiperPp, pinterest, pinterestP, pinterestSquare, plane, play, playCircle, playCircleO, plug, plus, plusCircle, plusSquare, plusSquareO, podcast, powerOff, print, productHunt, puzzlePiece, qq, qrcode, question, questionCircle, questionCircleO, quora, quoteLeft, quoteRight, ra, random, ravelry, rebel, recycle, reddit, redditAlien, redditSquare, refresh, registered, remove, renren, reorder, repeatIcon, reply, replyAll, resistance, retweet, rmb, road, rocket, rotateLeft, rotateRight, rouble, rss, rssSquare, rub, ruble, rupee, s15, safari, save, scissors, scribd, search, searchMinus, searchPlus, sellsy, send, sendO, server, share, shareAlt, shareAltSquare, shareSquare, shareSquareO, shekel, sheqel, shield, ship, shirtsinbulk, shoppingBag, shoppingBasket, shoppingCart, shower, signIn, signLanguage, signOut, signal, signing, simplybuilt, sitemap, skyatlas, skype, slack, sliders, slideshare, smileO, snapchat, snapchatGhost, snapchatSquare, snowflakeO, soccerBallO, sort, sortAlphaAsc, sortAlphaDesc, sortAmountAsc, sortAmountDesc, sortAsc, sortDesc, sortDown, sortNumericAsc, sortNumericDesc, sortUp, soundcloud, spaceShuttle, spinner, spoon, spotify, square, squareO, stackExchange, stackOverflow, star, starHalf, starHalfEmpty, starHalfFull, starHalfO, starO, steam, steamSquare, stepBackward, stepForward, stethoscope, stickyNote, stickyNoteO, stop, stopCircle, stopCircleO, streetView, strikethrough, stumbleupon, stumbleuponCircle, subscriptIcon, subway, suitcase, sunO, superpowers, superscript, support, table, tablet, tachometer, tag, tags, tasks, taxi, telegram, television, tencentWeibo, terminal, textHeight, textWidth, th, thLarge, thList, themeisle, thermometer, thermometer0, thermometer1, thermometer2, thermometer3, thermometer4, thermometerEmpty, thermometerFull, thermometerHalf, thermometerQuarter, thermometerThreeQuarters, thumbTack, thumbsDown, thumbsODown, thumbsOUp, thumbsUp, ticket, times, timesCircle, timesCircleO, timesRectangle, timesRectangleO, tint, toggleDown, toggleLeft, toggleOff, toggleOn, toggleRight, toggleUp, trademark, train, transgender, transgenderAlt, trash, trashO, tree, trello, tripadvisor, trophy, truck, tryIcon, tty, tumblr, tumblrSquare, turkishLira, tv, twitch, twitter, twitterSquare, umbrella, underline, undo, universalAccess, university, unlink, unlock, unlockAlt, unsorted, upload, usb, usd, user, userCircle, userCircleO, userMd, userO, userPlus, userSecret, userTimes, users, vcard, vcardO, venus, venusDouble, venusMars, viacoin, viadeo, viadeoSquare, videoCamera, vimeo, vimeoSquare, vine, vk, volumeControlPhone, volumeDown, volumeOff, volumeUp, warning, wechat, weibo, weixin, whatsapp, wheelchair, wheelchairAlt, wifi, wikipediaW, windowClose, windowCloseO, windowMaximize, windowMinimize, windowRestore, windows, won, wordpress, wpbeginner, wpexplorer, wpforms, wrench, xing, xingSquare, yCombinator, yCombinatorSquare, yahoo, yc, ycSquare, yelp, yen, yoast, youtube, youtubePlay, youtubeSquare
}

private let faIcons = ["\u{f26e}", "\u{f2b9}", "\u{f2ba}", "\u{f2bb}", "\u{f2bc}", "\u{f042}", "\u{f170}", "\u{f037}", "\u{f039}", "\u{f036}", "\u{f038}", "\u{f270}", "\u{f0f9}", "\u{f2a3}", "\u{f13d}", "\u{f17b}", "\u{f209}", "\u{f103}", "\u{f100}", "\u{f101}", "\u{f102}", "\u{f107}", "\u{f104}", "\u{f105}", "\u{f106}", "\u{f179}", "\u{f187}", "\u{f1fe}", "\u{f0ab}", "\u{f0a8}", "\u{f01a}", "\u{f190}", "\u{f18e}", "\u{f01b}", "\u{f0a9}", "\u{f0aa}", "\u{f063}", "\u{f060}", "\u{f061}", "\u{f062}", "\u{f047}", "\u{f0b2}", "\u{f07e}", "\u{f07d}", "\u{f2a3}", "\u{f2a2}", "\u{f069}", "\u{f1fa}", "\u{f29e}", "\u{f1b9}", "\u{f04a}", "\u{f24e}", "\u{f05e}", "\u{f2d5}", "\u{f19c}", "\u{f080}", "\u{f080}", "\u{f02a}", "\u{f0c9}", "\u{f2cd}", "\u{f2cd}", "\u{f240}", "\u{f244}", "\u{f243}", "\u{f242}", "\u{f241}", "\u{f240}", "\u{f244}", "\u{f240}", "\u{f242}", "\u{f243}", "\u{f241}", "\u{f236}", "\u{f0fc}", "\u{f1b4}", "\u{f1b5}", "\u{f0f3}", "\u{f0a2}", "\u{f1f6}", "\u{f1f7}", "\u{f206}", "\u{f1e5}", "\u{f1fd}", "\u{f171}", "\u{f172}", "\u{f15a}", "\u{f27e}", "\u{f29d}", "\u{f293}", "\u{f294}", "\u{f032}", "\u{f0e7}", "\u{f1e2}", "\u{f02d}", "\u{f02e}", "\u{f097}", "\u{f2a1}", "\u{f0b1}", "\u{f15a}", "\u{f188}", "\u{f1ad}", "\u{f0f7}", "\u{f0a1}", "\u{f140}", "\u{f207}", "\u{f20d}", "\u{f1ba}", "\u{f1ec}", "\u{f073}", "\u{f274}", "\u{f272}", "\u{f133}", "\u{f271}", "\u{f273}", "\u{f030}", "\u{f083}", "\u{f1b9}", "\u{f0d7}", "\u{f0d9}", "\u{f0da}", "\u{f150}", "\u{f191}", "\u{f152}", "\u{f151}", "\u{f0d8}", "\u{f218}", "\u{f217}", "\u{f20a}", "\u{f1f3}", "\u{f24c}", "\u{f1f2}", "\u{f24b}", "\u{f1f1}", "\u{f1f4}", "\u{f1f5}", "\u{f1f0}", "\u{f0a3}", "\u{f0c1}", "\u{f127}", "\u{f00c}", "\u{f058}", "\u{f05d}", "\u{f14a}", "\u{f046}", "\u{f13a}", "\u{f137}", "\u{f138}", "\u{f139}", "\u{f078}", "\u{f053}", "\u{f054}", "\u{f077}", "\u{f1ae}", "\u{f268}", "\u{f111}", "\u{f10c}", "\u{f1ce}", "\u{f1db}", "\u{f0ea}", "\u{f017}", "\u{f24d}", "\u{f00d}", "\u{f0c2}", "\u{f0ed}", "\u{f0ee}", "\u{f157}", "\u{f121}", "\u{f126}", "\u{f1cb}", "\u{f284}", "\u{f0f4}", "\u{f013}", "\u{f085}", "\u{f0db}", "\u{f075}", "\u{f0e5}", "\u{f27a}", "\u{f27b}", "\u{f086}", "\u{f0e6}", "\u{f14e}", "\u{f066}", "\u{f20e}", "\u{f26d}", "\u{f0c5}", "\u{f1f9}", "\u{f25e}", "\u{f09d}", "\u{f283}", "\u{f125}", "\u{f05b}", "\u{f13c}", "\u{f1b2}", "\u{f1b3}", "\u{f0c4}", "\u{f0f5}", "\u{f0e4}", "\u{f210}", "\u{f1c0}", "\u{f2a4}", "\u{f2a4}", "\u{f03b}", "\u{f1a5}", "\u{f108}", "\u{f1bd}", "\u{f219}", "\u{f1a6}", "\u{f155}", "\u{f192}", "\u{f019}", "\u{f17d}", "\u{f2c2}", "\u{f2c3}", "\u{f16b}", "\u{f1a9}", "\u{f282}", "\u{f044}", "\u{f2da}", "\u{f052}", "\u{f141}", "\u{f142}", "\u{f1d1}", "\u{f0e0}", "\u{f003}", "\u{f2b6}", "\u{f2b7}", "\u{f199}", "\u{f299}", "\u{f12d}", "\u{f2d7}", "\u{f153}", "\u{f153}", "\u{f0ec}", "\u{f12a}", "\u{f06a}", "\u{f071}", "\u{f065}", "\u{f23e}", "\u{f08e}", "\u{f14c}", "\u{f06e}", "\u{f070}", "\u{f1fb}", "\u{f2b4}", "\u{f09a}", "\u{f09a}", "\u{f230}", "\u{f082}", "\u{f049}", "\u{f050}", "\u{f1ac}", "\u{f09e}", "\u{f182}", "\u{f0fb}", "\u{f15b}", "\u{f1c6}", "\u{f1c7}", "\u{f1c9}", "\u{f1c3}", "\u{f1c5}", "\u{f1c8}", "\u{f016}", "\u{f1c1}", "\u{f1c5}", "\u{f1c5}", "\u{f1c4}", "\u{f1c7}", "\u{f15c}", "\u{f0f6}", "\u{f1c8}", "\u{f1c2}", "\u{f1c6}", "\u{f0c5}", "\u{f008}", "\u{f0b0}", "\u{f06d}", "\u{f134}", "\u{f269}", "\u{f2b0}", "\u{f024}", "\u{f11e}", "\u{f11d}", "\u{f0e7}", "\u{f0c3}", "\u{f16e}", "\u{f0c7}", "\u{f07b}", "\u{f114}", "\u{f07c}", "\u{f115}", "\u{f031}", "\u{f2b4}", "\u{f280}", "\u{f286}", "\u{f211}", "\u{f04e}", "\u{f180}", "\u{f2c5}", "\u{f119}", "\u{f1e3}", "\u{f11b}", "\u{f0e3}", "\u{f154}", "\u{f1d1}", "\u{f013}", "\u{f085}", "\u{f22d}", "\u{f265}", "\u{f260}", "\u{f261}", "\u{f06b}", "\u{f1d3}", "\u{f1d2}", "\u{f09b}", "\u{f113}", "\u{f092}", "\u{f296}", "\u{f184}", "\u{f000}", "\u{f2a5}", "\u{f2a6}", "\u{f0ac}", "\u{f1a0}", "\u{f0d5}", "\u{f2b3}", "\u{f2b3}", "\u{f0d4}", "\u{f1ee}", "\u{f19d}", "\u{f184}", "\u{f2d6}", "\u{f0c0}", "\u{f0fd}", "\u{f1d4}", "\u{f255}", "\u{f258}", "\u{f0a7}", "\u{f0a5}", "\u{f0a4}", "\u{f0a6}", "\u{f256}", "\u{f25b}", "\u{f25a}", "\u{f255}", "\u{f257}", "\u{f259}", "\u{f256}", "\u{f2b5}", "\u{f2a4}", "\u{f292}", "\u{f0a0}", "\u{f1dc}", "\u{f025}", "\u{f004}", "\u{f08a}", "\u{f21e}", "\u{f1da}", "\u{f015}", "\u{f0f8}", "\u{f236}", "\u{f254}", "\u{f251}", "\u{f252}", "\u{f253}", "\u{f253}", "\u{f252}", "\u{f250}", "\u{f251}", "\u{f27c}", "\u{f13b}", "\u{f246}", "\u{f2c1}", "\u{f2c2}", "\u{f2c3}", "\u{f20b}", "\u{f03e}", "\u{f2d8}", "\u{f01c}", "\u{f03c}", "\u{f275}", "\u{f129}", "\u{f05a}", "\u{f156}", "\u{f16d}", "\u{f19c}", "\u{f26b}", "\u{f224}", "\u{f208}", "\u{f033}", "\u{f1aa}", "\u{f157}", "\u{f1cc}", "\u{f084}", "\u{f11c}", "\u{f159}", "\u{f1ab}", "\u{f109}", "\u{f202}", "\u{f203}", "\u{f06c}", "\u{f212}", "\u{f0e3}", "\u{f094}", "\u{f149}", "\u{f148}", "\u{f1cd}", "\u{f1cd}", "\u{f1cd}", "\u{f1cd}", "\u{f0eb}", "\u{f201}", "\u{f0c1}", "\u{f0e1}", "\u{f08c}", "\u{f2b8}", "\u{f17c}", "\u{f03a}", "\u{f022}", "\u{f0cb}", "\u{f0ca}", "\u{f124}", "\u{f023}", "\u{f175}", "\u{f177}", "\u{f178}", "\u{f176}", "\u{f2a8}", "\u{f0d0}", "\u{f076}", "\u{f064}", "\u{f112}", "\u{f122}", "\u{f183}", "\u{f279}", "\u{f041}", "\u{f278}", "\u{f276}", "\u{f277}", "\u{f222}", "\u{f227}", "\u{f229}", "\u{f22b}", "\u{f22a}", "\u{f136}", "\u{f20c}", "\u{f23a}", "\u{f0fa}", "\u{f2e0}", "\u{f11a}", "\u{f223}", "\u{f2db}", "\u{f130}", "\u{f131}", "\u{f068}", "\u{f056}", "\u{f146}", "\u{f147}", "\u{f289}", "\u{f10b}", "\u{f10b}", "\u{f285}", "\u{f0d6}", "\u{f186}", "\u{f19d}", "\u{f21c}", "\u{f245}", "\u{f001}", "\u{f0c9}", "\u{f22c}", "\u{f1ea}", "\u{f247}", "\u{f248}", "\u{f263}", "\u{f264}", "\u{f23d}", "\u{f19b}", "\u{f26a}", "\u{f23c}", "\u{f03b}", "\u{f18c}", "\u{f1fc}", "\u{f1d8}", "\u{f1d9}", "\u{f0c6}", "\u{f1dd}", "\u{f0ea}", "\u{f04c}", "\u{f28b}", "\u{f28c}", "\u{f1b0}", "\u{f1ed}", "\u{f040}", "\u{f14b}", "\u{f044}", "\u{f295}", "\u{f095}", "\u{f098}", "\u{f03e}", "\u{f03e}", "\u{f200}", "\u{f2ae}", "\u{f1a8}", "\u{f1a7}", "\u{f0d2}", "\u{f231}", "\u{f0d3}", "\u{f072}", "\u{f04b}", "\u{f144}", "\u{f01d}", "\u{f1e6}", "\u{f067}", "\u{f055}", "\u{f0fe}", "\u{f196}", "\u{f2ce}", "\u{f011}", "\u{f02f}", "\u{f288}", "\u{f12e}", "\u{f1d6}", "\u{f029}", "\u{f128}", "\u{f059}", "\u{f29c}", "\u{f2c4}", "\u{f10d}", "\u{f10e}", "\u{f1d0}", "\u{f074}", "\u{f2d9}", "\u{f1d0}", "\u{f1b8}", "\u{f1a1}", "\u{f281}", "\u{f1a2}", "\u{f021}", "\u{f25d}", "\u{f00d}", "\u{f18b}", "\u{f0c9}", "\u{f01e}", "\u{f112}", "\u{f122}", "\u{f1d0}", "\u{f079}", "\u{f157}", "\u{f018}", "\u{f135}", "\u{f0e2}", "\u{f01e}", "\u{f158}", "\u{f09e}", "\u{f143}", "\u{f158}", "\u{f158}", "\u{f156}", "\u{f2cd}", "\u{f267}", "\u{f0c7}", "\u{f0c4}", "\u{f28a}", "\u{f002}", "\u{f010}", "\u{f00e}", "\u{f213}", "\u{f1d8}", "\u{f1d9}", "\u{f233}", "\u{f064}", "\u{f1e0}", "\u{f1e1}", "\u{f14d}", "\u{f045}", "\u{f20b}", "\u{f20b}", "\u{f132}", "\u{f21a}", "\u{f214}", "\u{f290}", "\u{f291}", "\u{f07a}", "\u{f2cc}", "\u{f090}", "\u{f2a7}", "\u{f08b}", "\u{f012}", "\u{f2a7}", "\u{f215}", "\u{f0e8}", "\u{f216}", "\u{f17e}", "\u{f198}", "\u{f1de}", "\u{f1e7}", "\u{f118}", "\u{f2ab}", "\u{f2ac}", "\u{f2ad}", "\u{f2dc}", "\u{f1e3}", "\u{f0dc}", "\u{f15d}", "\u{f15e}", "\u{f160}", "\u{f161}", "\u{f0de}", "\u{f0dd}", "\u{f0dd}", "\u{f162}", "\u{f163}", "\u{f0de}", "\u{f1be}", "\u{f197}", "\u{f110}", "\u{f1b1}", "\u{f1bc}", "\u{f0c8}", "\u{f096}", "\u{f18d}", "\u{f16c}", "\u{f005}", "\u{f089}", "\u{f123}", "\u{f123}", "\u{f123}", "\u{f006}", "\u{f1b6}", "\u{f1b7}", "\u{f048}", "\u{f051}", "\u{f0f1}", "\u{f249}", "\u{f24a}", "\u{f04d}", "\u{f28d}", "\u{f28e}", "\u{f21d}", "\u{f0cc}", "\u{f1a4}", "\u{f1a3}", "\u{f12c}", "\u{f239}", "\u{f0f2}", "\u{f185}", "\u{f2dd}", "\u{f12b}", "\u{f1cd}", "\u{f0ce}", "\u{f10a}", "\u{f0e4}", "\u{f02b}", "\u{f02c}", "\u{f0ae}", "\u{f1ba}", "\u{f2c6}", "\u{f26c}", "\u{f1d5}", "\u{f120}", "\u{f034}", "\u{f035}", "\u{f00a}", "\u{f009}", "\u{f00b}", "\u{f2b2}", "\u{f2c7}", "\u{f2cb}", "\u{f2ca}", "\u{f2c9}", "\u{f2c8}", "\u{f2c7}", "\u{f2cb}", "\u{f2c7}", "\u{f2c9}", "\u{f2ca}", "\u{f2c8}", "\u{f08d}", "\u{f165}", "\u{f088}", "\u{f087}", "\u{f164}", "\u{f145}", "\u{f00d}", "\u{f057}", "\u{f05c}", "\u{f2d3}", "\u{f2d4}", "\u{f043}", "\u{f150}", "\u{f191}", "\u{f204}", "\u{f205}", "\u{f152}", "\u{f151}", "\u{f25c}", "\u{f238}", "\u{f224}", "\u{f225}", "\u{f1f8}", "\u{f014}", "\u{f1bb}", "\u{f181}", "\u{f262}", "\u{f091}", "\u{f0d1}", "\u{f195}", "\u{f1e4}", "\u{f173}", "\u{f174}", "\u{f195}", "\u{f26c}", "\u{f1e8}", "\u{f099}", "\u{f081}", "\u{f0e9}", "\u{f0cd}", "\u{f0e2}", "\u{f29a}", "\u{f19c}", "\u{f127}", "\u{f09c}", "\u{f13e}", "\u{f0dc}", "\u{f093}", "\u{f287}", "\u{f155}", "\u{f007}", "\u{f2bd}", "\u{f2be}", "\u{f0f0}", "\u{f2c0}", "\u{f234}", "\u{f21b}", "\u{f235}", "\u{f0c0}", "\u{f2bb}", "\u{f2bc}", "\u{f221}", "\u{f226}", "\u{f228}", "\u{f237}", "\u{f2a9}", "\u{f2aa}", "\u{f03d}", "\u{f27d}", "\u{f194}", "\u{f1ca}", "\u{f189}", "\u{f2a0}", "\u{f027}", "\u{f026}", "\u{f028}", "\u{f071}", "\u{f1d7}", "\u{f18a}", "\u{f1d7}", "\u{f232}", "\u{f193}", "\u{f29b}", "\u{f1eb}", "\u{f266}", "\u{f2d3}", "\u{f2d4}", "\u{f2d0}", "\u{f2d1}", "\u{f2d2}", "\u{f17a}", "\u{f159}", "\u{f19a}", "\u{f297}", "\u{f2de}", "\u{f298}", "\u{f0ad}", "\u{f168}", "\u{f169}", "\u{f23b}", "\u{f1d4}", "\u{f19e}", "\u{f23b}", "\u{f1d4}", "\u{f1e9}", "\u{f157}", "\u{f2b1}", "\u{f167}", "\u{f16a}", "\u{f166}"]


/**
 List of all icons in Ionicons
 
 - Author - [Ben Sperry](https://twitter.com/benjsperry)
 - Version: 2.0.1
 
 ## Important Notes ##
 For icons, please visit [ionicons](http://ionicons.com/)
 Please check this [license](https://github.com/driftyco/ionicons/blob/master/LICENSE)
 */
public enum IoniconsType: Int {
    
    static var count: Int {
        return ioniconsIcons.count
    }
    
    public var text: String? {
        return ioniconsIcons[rawValue]
    }
    
    case alert, alertCircled, androidAdd, androidAddCircle, androidAlarmClock, androidAlert, androidApps, androidArchive, androidArrowBack, androidArrowDown, androidArrowDropdown, androidArrowDropdownCircle, androidArrowDroplet, androidArrowDropletCircle, androidArrowDropright, androidArrowDroprightCircle, androidDropup, androidDropupCircle, androidArrowForward, androidArrowUp, androidAttach, androidBar, androidBicycle, androidBoat, androidBookmark, androidBulb, androidBus, androidCalendar, androidCall, androidCamera, androidCancel, androidCar, androidCart, androidChat, androidCheckbox, androidCheckboxBlank, androidCheckboxOutline, androidCheckboxOutlineBlank, androidCheckmarkCircle, androidClipboard, androidClose, androidCloud, androidCloudCircle, androidCloudDone, androidCloudOutline, androidColorPalette, androidCompass, androidContact, androidContacts, androidContract, androidCreate, androidDelete, androidDesktop, androidDocument, androidDone, androidDoneAll, androidDownload, androidDrafts, androidExit, androidExpand, androidFavorite, androidFavoriteOutline, androidFilm, androidFolder, androidFolderOpen, androidFunnel, androidGlobe, androidHand, androidHangout, androidHappy, androidHome, androidImage, androidLaptop, androidList, androidLocate, androidLock, androidMail, androidMap, androidMenu, androidMicrophone, androidMicrophoneOff, androidMoreHorizontal, androidMoreVertical, androidNavigate, androidNotifications, androidNotificationsNone, androidNotificationsOff, androidOpen, androidOptions, androidPeople, androidPerson, androidPersonAdd, androidPhoneLandscape, androidPhonePortrait, androidPin, androidPlane, androidPlaystore, androidPrint, androidRadioButtonOff, androidRadioButtonOn, androidRefresh, androidRemove, androidRemoveCircle, androidRestaurant, androidSad, androidSearch, androidSend, androidSettings, androidShare, androidShareAlt, androidStar, androidStarHalf, androidStarOutline, androidStopwatch, androidSubway, androidSunny, androidSync, androidTextsms, androidTime, androidTrain, androidUnlock, androidUpload, androidVolumeDown, androidVolumeMute, androidVolumeOff, androidVolumeUp, androidWalk, androidWarning, androidWatch, androidWifi, aperture, archive, arrowDownA, arrowDownB, arrowDownC, arrowExpand, arrowGraphDownLeft, arrowGraphDownRight, arrowGraphUpLeft, arrowGraphUpRight, arrowLeftA, arrowLeftB, arrowLeftC, arrowMove, arrowResize, arrowReturnLeft, arrowReturnRight, arrowRightA, arrowRightB, arrowRightC, arrowShrink, arrowSwap, arrowUpA, arrowUpB, arrowUpC, asterisk, at, backspace, backspaceOutline, bag, batteryCharging, batteryEmpty, batteryFull, batteryHalf, batteryLow, beaker, beer, bluetooth, bonfire, bookmark, bowtie, briefcase, bug, calculator, calendar, camera, card, cash, chatbox, chatboxWorking, chatboxes, chatbubble, chatbubbleWorking, chatbubbles, checkmark, checkmarkCircled, checkmarkRound, chevronDown, chevronLeft, chevronRight, chevronUp, clipboard, clock, close, closeCircled, closeRound, closedCaptioning, cloud, code, codeDownload, codeWorking, coffee, compass, compose, connectionBars, contrast, crop, cube, disc, document, documentText, drag, earth, easel, edit, egg, eject, email, emailUnread, erlenmeyerFlask, erlenmeyerFlaskBubbles, eye, eyeDisabled, female, filing, filmMaker, fireball, flag, flame, flash, flashOff, folder, fork, forkRepo, forward, funnel, gearA, gearB, grid, hammer, happy, happyOutline, headphone, heart, heartBroken, help, helpBuoy, helpCircled, home, icecream, image, images, information, informationCircled, ionic, iosAlarm, iosAlarmOutline, iosAlbums, iosAlbumsOutline, iosAmericanfootball, iosAmericanfootballOutline, iosAnalytics, iosAnalyticsOutline, iosArrowBack, iosArrowDown, iosArrowForward, iosArrowLeft, iosArrowRight, iosArrowThinDown, iosArrowThinLeft, iosArrowThinRight, iosArrowThinUp, iosArrowUp, iosAt, iosAtOutline, iosBarcode, iosBarcodeOutline, iosBaseball, iosBaseballOutline, iosBasketball, iosBasketBallOutline, iosBell, iosBellOutline, iosBody, iosBodyOutline, iosBolt, iosBoltOutline, iosBook, iosBookOutline, iosBookmarks, iosBookmarksOutline, iosBox, iosBoxOutline, iosBriefcase, iosBriefcaseOutline, iosBrowsers, iosBrowsersOutline, iosCalculator, iosCalculatorOutline, iosCalendar, iosCalendarOutline, iosCamera, iosCameraOutline, iosCart, iosCartOutline, iosChatboxes, iosChatboxesOutline, iosChatbubble, iosChatbubbleOutline, iosCheckmark, iosCheckmarkEmpty, iosCheckmarkOutline, iosCircleFilled, iosCircleOutline, iosClock, iosClockOutline, iosClose, iosCloseEmpty, iosCloseOutline, iosCloud, iosCloudDownload, iosCloudDownloadOutline, iosCloudOutline, iosCloudUpload, iosCloudUploadOutline, iosCloudy, iosCloudyNight, iosCloudyNightOutline, iosCloudyOutline, iosCog, iosCogOutline, iosColorFilter, iosColorFilterOutline, iosColorWand, iosColorWandOutline, iosCompose, iosComposeOutline, iosContact, iosContactOutline, iosCopy, iosCopyOutline, iosCrop, iosCropStrong, iosDownload, iosDownloadOutline, iosDrag, iosEmail, iosEmailOutline, iosEye, iosEyeOutline, iosFastforward, iosFastforwardOutline, iosFiling, iosFilingOutline, iosFilm, iosFilmOutline, iosFlag, iosFlagOutline, iosFlame, iosFlameOutline, iosFlask, iosFlaskOutline, iosFlower, iosFlowerOutline, iosFolder, iosFolderOutline, iosFootball, iosFootballOutline, iosGameControllerA, iosGameControllerAOutline, iosGameControllerB, iosGameControllerBOutline, iosGear, iosGearOutline, iosGlasses, iosGlassesOutline, iosGridView, iosGridViewOutline, iosHeart, iosHeartOutline, iosHelp, iosHelpEmpty, iosHelpOutline, iosHome, iosHomeOutline, iosInfinite, iosInfiniteOutline, iosInformation, iosInformationEmpty, iosInformationOutline, iosIonicOutline, iosKeypad, iosKeypadOutline, iosLightbulb, iosLightbulbOutline, iosList, iosListOutline, iosLocation, iosLocationOutline, iosLocked, iosLockedOutline, iosLoop, iosLoopStrong, iosMedical, iosMedicalOutline, iosMedkit, iosMedkitOutline, iosMic, iosMicOff, iosMicOutline, iosMinus, iosMinusEmpty, iosMinusOutline, iosMonitor, iosMonitorOutline, iosMoon, iosMoonOutline, iosMore, iosMoreOutline, iosMusicalNote, iosMusicalNotes, iosNavigate, iosNavigateOutline, iosNutrition, iosNutritionOutline, iosPaper, iosPaperOutline, iosPaperplane, iosPaperplaneOutline, iosPartlySunny, iosPartlySunnyOutline, iosPause, iosPauseOutline, iosPaw, iosPawOutline, iosPeople, iosPeopleOutline, iosPerson, iosPersonOutline, iosPersonadd, iosPersonaddOutline, iosPhotos, iosPhotosOutline, iosPie, iosPieOutline, iosPint, iosPintOutline, iosPlay, iosPlayOutline, iosPlus, iosPlusEmpty, iosPlusOutline, iosPricetag, iosPricetagOutline, iosPricetags, iosPricetagsOutline, iosPrinter, iosPrinterOutline, iosPulse, iosPulseStrong, iosRainy, iosRainyOutline, iosRecording, iosRecordingOutline, iosRedo, iosRedoOutline, iosRefresh, iosRefreshEmpty,iosRefreshOutline, iosReload, iosReverseCamera, iosReverseCameraOutline, iosReward, iosRewardOutline, iosRose, iosRoseOutline, iosSearch, iosSearchStrong, iosSettings, iosSettingsStrong, iosShuffle, iosShuffleStrong, iosSkipbackward, iosSkipbackwardOutline, iosSkipforward, iosSkipforwardOutline, iosSnowy, iosSpeedometer, iosSpeedometerOutline, iosStar, iosStarHalf, iosStarOutline, iosStopwatch, iosStopwatchOutline, iosSunny, iosSunnyOutline, iosTelephone, iosTelephoneOutline, iosTennisball, iosTennisballOutline, iosThunderstorm, iosThunderstormOutline, iosTime, iosTimeOutline, iosTimer, iosTimerOutline, iosToggle, iosToggleOutline, iosTrash, iosTrashOutline, iosUndo, iosUndoOutline, iosUnlocked, iosUnlockedOutline, iosUpload, iosUploadOutline, iosVideocam, iosVideocamOutline, iosVolumeHigh, iosVolumeLow, iosWineglass, iosWineglassOutline, iosWorld, iosWorldOutline, ipad, iphone, ipod, jet, key, knife, laptop, leaf, levels, lightbulb, link, loadA, loadB, loadC, loadD, location, lockCombination, locked, logIn, logOut, loop, magnet, male, man, map, medkit, merge, micA, micB, micC, minus, minusCircled, minusRound, modelS, monitor, more, mouse, musicNote, navicon, naviconRound, navigate, network, noSmoking, nuclear, outlet, paintbrush, paintbucket, paperAirplane, paperclip, pause, person, personAdd, personStalker, pieGraph, pin, pinpoint, pizza, plane, planet, play, playstation, plus, plusCircled, plusRound, podium, pound, power, pricetag, pricetags, printer, pullRequest, qrScanner, quote, radioWaves, record, refresh, reply, replyAll, ribbonA, ribbonB, sad, sadOutline, scissors, search, settings, share, shuffle, skipBackward, skipForward, socialAndroid, socialAndroidOutline, socialAngular, socialAngularOutline, socialApple, socialAppleOutline, socialBitcoin, socialBitcoinOutline, socialBuffer, socialBufferOutline, socialChrome, socialChromeOutline, socialCodepan, socialCodepanOutline, socialCss3, socialCss3Outline, socialDesignernews, socialDesignernewsOutline, socialDribble, socialDribbleOutline, socialDropbox, socialDropboxOutline, socialEuro, socialEuroOutline, socialFacebook, socialFacebookOutline, socialFoursquare, socialFoursquareOutline, socialFreebsdDevil, socialGithub, socialGithubOutline, socialGoogle, socialGoogleOutline, socialGoogleplus, socialGoogleplusOutline, socialHackernews, socialHackernewsOutline, socialHtml5, socialHtml5Outline, socialInstagram, socialInstagramOutline, socialJavascript, socialJavascriptOutline, socialLinkedin, socialLinkedinOutline, socialMarkdown, socialNodejs, socialOctacat, socialPinterest, socialPinterestOutline, socialPython, socialReddit, socialRedditOutline, socialRss, socialRssOutline, socialSass, socialSkype, socialSkypeOutline, socialSnapchat, socialSnapchatOutline, socialTumblr, socialTumblrOutline, socialTux, socialTwitch, socialTwitchOutline, socialTwitter, socialTwitterOutline, socialUsd, socialUsdOutline, socialVimeo, socialVimeoOutline, socialWhatsapp, socialWhatsappOutline, socialWindows, socialWindowsOutline, socialWordpress, socialWordpressOutline, socialYahoo, socialYahooOutline, socialYen, socialYenOutline, socialYoutube, socialYoutubeOutline, soupCan, soupCanOutline, speakerphone, speedometer, spoon, star, statsBars, steam, stop, thermometer, thumbsdown, thumbsup, toggle, toggleFilled, transgender, trashA, trashB, trophy, tshirt, tshirtOutline, umbrella, university, unlocked, upload, usb, videocamera, volumeHigh, volumeLow, volumeMedium, volumeMute, wand, waterdrop, wifi, wineglass, woman, wrench, xbox
}

private let ioniconsIcons = ["\u{f101}", "\u{f100}", "\u{f2c7}", "\u{f359}", "\u{f35a}", "\u{f35b}", "\u{f35c}", "\u{f2c9}", "\u{f2ca}", "\u{f35d}", "\u{f35f}", "\u{f35e}", "\u{f361}", "\u{f360}", "\u{f363}", "\u{f362}", "\u{f365}", "\u{f364}", "\u{f30f}", "\u{f366}", "\u{f367}", "\u{f368}", "\u{f369}", "\u{f36a}", "\u{f36b}", "\u{f36c}", "\u{f36d}", "\u{f2d1}", "\u{f2d2}", "\u{f2d3}", "\u{f36e}", "\u{f36f}", "\u{f370}", "\u{f2d4}", "\u{f374}", "\u{f371}", "\u{f373}", "\u{f372}", "\u{f375}", "\u{f376}", "\u{f2d7}", "\u{f37a}", "\u{f377}", "\u{f378}", "\u{f379}", "\u{f37b}", "\u{f37c}", "\u{f2d8}", "\u{f2d9}", "\u{f37d}", "\u{f37e}", "\u{f37f}", "\u{f380}", "\u{f381}", "\u{f383}", "\u{f382}", "\u{f2dd}", "\u{f384}", "\u{f385}", "\u{f386}", "\u{f388}", "\u{f387}", "\u{f389}", "\u{f2e0}", "\u{f38a}", "\u{f38b}", "\u{f38c}", "\u{f2e3}", "\u{f38d}", "\u{f38e}", "\u{f38f}", "\u{f2e4}", "\u{f390}", "\u{f391}", "\u{f2e9}", "\u{f392}", "\u{f2eb}", "\u{f393}", "\u{f394}", "\u{f2ec}", "\u{f395}", "\u{f396}", "\u{f397}", "\u{f398}", "\u{f39b}", "\u{f399}", "\u{f39a}", "\u{f39c}", "\u{f39d}", "\u{f39e}", "\u{f3a0}", "\u{f39f}", "\u{f3a1}", "\u{f3a2}", "\u{f3a3}", "\u{f3a4}", "\u{f2f0}", "\u{f3a5}", "\u{f3a6}", "\u{f3a7}", "\u{f3a8}", "\u{f2f4}", "\u{f3a9}", "\u{f3aa}", "\u{f3ab}", "\u{f2f5}", "\u{f2f6}", "\u{f2f7}", "\u{f2f8}", "\u{f3ac}", "\u{f2fc}", "\u{f3ad}", "\u{f3ae}", "\u{f2fd}", "\u{f3af}", "\u{f3b0}", "\u{f3b1}", "\u{f3b2}", "\u{f3b3}", "\u{f3b4}", "\u{f3b5}", "\u{f3b6}", "\u{f3b7}", "\u{f3b8}", "\u{f3b9}", "\u{f3ba}", "\u{f3bb}", "\u{f3bc}", "\u{f3bd}", "\u{f305}", "\u{f313}", "\u{f102}", "\u{f103}", "\u{f104}", "\u{f105}", "\u{f25e}", "\u{f25f}", "\u{f260}", "\u{f261}", "\u{f262}", "\u{f106}", "\u{f107}", "\u{f108}", "\u{f263}", "\u{f264}", "\u{f265}", "\u{f266}", "\u{f109}", "\u{f10a}", "\u{f10b}", "\u{f267}", "\u{f268}", "\u{f10c}", "\u{f10d}", "\u{f10e}", "\u{f314}", "\u{f10f}", "\u{f3bf}", "\u{f3be}", "\u{f110}", "\u{f111}", "\u{f112}", "\u{f113}", "\u{f114}", "\u{f115}", "\u{f269}", "\u{f26a}", "\u{f116}", "\u{f315}", "\u{f26b}", "\u{f3c0}", "\u{f26c}", "\u{f2be}", "\u{f26d}", "\u{f117}", "\u{f118}", "\u{f119}", "\u{f316}", "\u{f11b}", "\u{f11a}", "\u{f11c}", "\u{f11e}", "\u{f11d}", "\u{f11f}", "\u{f122}", "\u{f120}", "\u{f121}", "\u{f123}", "\u{f124}", "\u{f125}", "\u{f126}", "\u{f127}", "\u{f26e}", "\u{f12a}", "\u{f128}", "\u{f129}", "\u{f317}", "\u{f12b}", "\u{f271}", "\u{f26f}", "\u{f270}", "\u{f272}", "\u{f273}", "\u{f12c}", "\u{f274}", "\u{f275}", "\u{f3c1}", "\u{f318}", "\u{f12d}", "\u{f12f}", "\u{f12e}", "\u{f130}", "\u{f276}", "\u{f3c2}", "\u{f2bf}", "\u{f277}", "\u{f131}", "\u{f132}", "\u{f3c3}", "\u{f3c5}", "\u{f3c4}", "\u{f133}", "\u{f306}", "\u{f278}", "\u{f134}", "\u{f135}", "\u{f319}", "\u{f279}", "\u{f31a}", "\u{f137}", "\u{f136}", "\u{f139}", "\u{f27a}", "\u{f2c0}", "\u{f13a}", "\u{f31b}", "\u{f13d}", "\u{f13e}", "\u{f13f}", "\u{f27b}", "\u{f31c}", "\u{f3c6}", "\u{f140}", "\u{f141}", "\u{f31d}", "\u{f143}", "\u{f27c}", "\u{f142}", "\u{f144}", "\u{f27d}", "\u{f147}", "\u{f148}", "\u{f14a}", "\u{f149}", "\u{f14b}", "\u{f3c8}", "\u{f3c7}", "\u{f3ca}", "\u{f3c9}", "\u{f3cc}", "\u{f3cb}", "\u{f3ce}", "\u{f3cd}", "\u{f3cf}", "\u{f3d0}", "\u{f3d1}", "\u{f3d2}", "\u{f3d3}", "\u{f3d4}", "\u{f3d5}", "\u{f3d6}", "\u{f3d7}", "\u{f3d8}", "\u{f3da}", "\u{f3d9}", "\u{f3dc}", "\u{f3db}", "\u{f3de}", "\u{f3dd}", "\u{f3e0}", "\u{f3df}", "\u{f3e2}", "\u{f3e1}", "\u{f3e4}", "\u{f3e3}", "\u{f3e6}", "\u{f3e5}", "\u{f3e8}", "\u{f3e7}", "\u{f3ea}", "\u{f3e9}", "\u{f3ec}", "\u{f3eb}", "\u{f3ee}", "\u{f3ed}", "\u{f3f0}", "\u{f3ef}", "\u{f3f2}", "\u{f3f1}", "\u{f3f4}", "\u{f3f3}", "\u{f3f6}", "\u{f3f5}", "\u{f3f8}", "\u{f3f7}", "\u{f3fa}", "\u{f3f9}", "\u{f3fc}", "\u{f3fb}", "\u{f3ff}", "\u{f3fd}", "\u{f3fe}", "\u{f400}", "\u{f401}", "\u{f403}", "\u{f402}", "\u{f406}", "\u{f404}", "\u{f405}", "\u{f40c}", "\u{f408}", "\u{f407}", "\u{f409}", "\u{f40b}", "\u{f40a}", "\u{f410}", "\u{f40e}", "\u{f40d}", "\u{f40f}", "\u{f412}", "\u{f411}", "\u{f414}", "\u{f413}", "\u{f416}", "\u{f415}", "\u{f418}", "\u{f417}", "\u{f41a}", "\u{f419}", "\u{f41c}", "\u{f41b}", "\u{f41e}", "\u{f41d}", "\u{f420}", "\u{f41f}", "\u{f421}", "\u{f423}", "\u{f422}", "\u{f425}", "\u{f424}", "\u{f427}", "\u{f426}", "\u{f429}", "\u{f428}", "\u{f42b}", "\u{f42a}", "\u{f42d}", "\u{f42c}", "\u{f42f}", "\u{f42e}", "\u{f431}", "\u{f430}", "\u{f433}", "\u{f432}", "\u{f435}", "\u{f434}", "\u{f437}", "\u{f436}", "\u{f439}", "\u{f438}", "\u{f43b}", "\u{f43a}", "\u{f43d}", "\u{f43c}", "\u{f43f}", "\u{f43e}", "\u{f441}", "\u{f440}", "\u{f443}", "\u{f442}", "\u{f446}", "\u{f444}", "\u{f445}", "\u{f448}", "\u{f447}", "\u{f44a}", "\u{f449}", "\u{f44d}", "\u{f44b}", "\u{f44c}", "\u{f44e}", "\u{f450}", "\u{f44f}", "\u{f452}", "\u{f451}", "\u{f454}", "\u{f453}", "\u{f456}", "\u{f455}", "\u{f458}", "\u{f457}", "\u{f45a}", "\u{f459}", "\u{f45c}", "\u{f45b}", "\u{f45e}", "\u{f45d}", "\u{f461}", "\u{f45f}", "\u{f460}", "\u{f464}", "\u{f462}", "\u{f463}", "\u{f466}", "\u{f465}", "\u{f468}", "\u{f467}", "\u{f46a}", "\u{f469}", "\u{f46b}", "\u{f46c}", "\u{f46e}", "\u{f46d}", "\u{f470}", "\u{f46f}", "\u{f472}", "\u{f471}", "\u{f474}", "\u{f473}", "\u{f476}", "\u{f475}", "\u{f478}", "\u{f477}", "\u{f47a}", "\u{f479}", "\u{f47c}", "\u{f47b}", "\u{f47e}", "\u{f47d}", "\u{f480}", "\u{f47f}", "\u{f482}", "\u{f481}", "\u{f484}", "\u{f483}", "\u{f486}", "\u{f485}", "\u{f488}", "\u{f487}", "\u{f48b}", "\u{f489}", "\u{f48a}", "\u{f48d}", "\u{f48c}", "\u{f48f}", "\u{f48e}", "\u{f491}", "\u{f490}", "\u{f493}", "\u{f492}", "\u{f495}", "\u{f494}", "\u{f497}", "\u{f496}", "\u{f499}", "\u{f498}", "\u{f49c}", "\u{f49a}", "\u{f49b}", "\u{f49d}", "\u{f49f}", "\u{f49e}", "\u{f4a1}", "\u{f4a0}", "\u{f4a3}", "\u{f4a2}", "\u{f4a5}", "\u{f4a4}", "\u{f4a7}", "\u{f4a6}", "\u{f4a9}", "\u{f4a8}", "\u{f4ab}", "\u{f4aa}", "\u{f4ad}", "\u{f4ac}", "\u{f4ae}", "\u{f4b0}", "\u{f4af}", "\u{f4b3}", "\u{f4b1}", "\u{f4b2}", "\u{f4b5}", "\u{f4b4}", "\u{f4b7}", "\u{f4b6}", "\u{f4b9}", "\u{f4b8}", "\u{f4bb}", "\u{f4ba}", "\u{f4bd}", "\u{f4bc}", "\u{f4bf}", "\u{f4be}", "\u{f4c1}", "\u{f4c0}", "\u{f4c3}", "\u{f4c2}", "\u{f4c5}", "\u{f4c4}", "\u{f4c7}", "\u{f4c6}", "\u{f4c9}", "\u{f4c8}", "\u{f4cb}", "\u{f4ca}", "\u{f4cd}", "\u{f4cc}", "\u{f4ce}", "\u{f4cf}", "\u{f4d1}", "\u{f4d0}", "\u{f4d3}", "\u{f4d2}", "\u{f1f9}", "\u{f1fa}", "\u{f1fb}", "\u{f295}", "\u{f296}", "\u{f297}", "\u{f1fc}", "\u{f1fd}", "\u{f298}", "\u{f299}", "\u{f1fe}", "\u{f29a}", "\u{f29b}", "\u{f29c}", "\u{f29d}", "\u{f1ff}", "\u{f4d4}", "\u{f200}", "\u{f29e}", "\u{f29f}", "\u{f201}", "\u{f2a0}", "\u{f2a1}", "\u{f202}", "\u{f203}", "\u{f2a2}", "\u{f33f}", "\u{f204}", "\u{f205}", "\u{f206}", "\u{f209}", "\u{f207}", "\u{f208}", "\u{f2c1}", "\u{f20a}", "\u{f20b}", "\u{f340}", "\u{f20c}", "\u{f20e}", "\u{f20d}", "\u{f2a3}", "\u{f341}", "\u{f2c2}", "\u{f2a4}", "\u{f342}", "\u{f4d5}", "\u{f4d6}", "\u{f2c3}", "\u{f20f}", "\u{f210}", "\u{f213}", "\u{f211}", "\u{f212}", "\u{f2a5}", "\u{f2a6}", "\u{f2a7}", "\u{f2a8}", "\u{f214}", "\u{f343}", "\u{f215}", "\u{f30a}", "\u{f218}", "\u{f216}", "\u{f217}", "\u{f344}", "\u{f219}", "\u{f2a9}", "\u{f2aa}", "\u{f2ab}", "\u{f21a}", "\u{f345}", "\u{f346}", "\u{f347}", "\u{f2ac}", "\u{f21b}", "\u{f21c}", "\u{f21e}", "\u{f21d}", "\u{f348}", "\u{f349}", "\u{f34a}", "\u{f4d7}", "\u{f34b}", "\u{f21f}", "\u{f2ad}", "\u{f220}", "\u{f221}", "\u{f222}", "\u{f223}", "\u{f225}", "\u{f224}", "\u{f4d9}", "\u{f4d8}", "\u{f227}", "\u{f226}", "\u{f2af}", "\u{f2ae}", "\u{f229}", "\u{f228}", "\u{f4db}", "\u{f4da}", "\u{f4dd}", "\u{f4dc}", "\u{f4df}", "\u{f4de}", "\u{f22b}", "\u{f22a}", "\u{f22d}", "\u{f22c}", "\u{f22f}", "\u{f22e}", "\u{f4e1}", "\u{f4e0}", "\u{f231}", "\u{f230}", "\u{f34d}", "\u{f34c}", "\u{f2c4}", "\u{f233}", "\u{f232}", "\u{f34f}", "\u{f34e}", "\u{f235}", "\u{f234}", "\u{f237}", "\u{f236}", "\u{f4e3}", "\u{f4e2}", "\u{f351}", "\u{f350}", "\u{f4e5}", "\u{f4e4}", "\u{f239}", "\u{f238}", "\u{f4e6}", "\u{f4e7}", "\u{f4e8}", "\u{f2b1}", "\u{f2b0}", "\u{f4e9}", "\u{f23b}", "\u{f23a}", "\u{f23d}", "\u{f23c}", "\u{f4ea}", "\u{f23f}", "\u{f23e}", "\u{f4ec}", "\u{f4eb}", "\u{f241}", "\u{f240}", "\u{f2c5}", "\u{f4ee}", "\u{f4ed}", "\u{f243}", "\u{f242}", "\u{f353}", "\u{f352}", "\u{f245}", "\u{f244}", "\u{f4f0}", "\u{f4ff}", "\u{f247}", "\u{f246}", "\u{f249}", "\u{f248}", "\u{f24b}", "\u{f24a}", "\u{f4f2}", "\u{f4f1}", "\u{f24d}", "\u{f24c}", "\u{f4f4}", "\u{f4f3}", "\u{f2b2}", "\u{f2b3}", "\u{f2b4}", "\u{f24e}", "\u{f2b5}", "\u{f30b}", "\u{f24f}", "\u{f2b6}", "\u{f250}", "\u{f251}", "\u{f355}", "\u{f354}", "\u{f4f5}", "\u{f252}", "\u{f253}", "\u{f356}", "\u{f4f7}", "\u{f4f6}", "\u{f2b7}", "\u{f357}", "\u{f254}", "\u{f255}", "\u{f2b8}", "\u{f256}", "\u{f257}", "\u{f258}", "\u{f259}", "\u{f25a}", "\u{f358}", "\u{f25b}", "\u{f25c}", "\u{f2b9}", "\u{f25d}", "\u{f2ba}", "\u{f30c}"]


/**
 List of all icons in LinearIcons
 
 - Authors:
 [Linearicons](https://linearicons.com/)
 [Perxis](https://perxis.com/)
 - Version: 1.0.0
 
 ## Important Notes ##
 For icons, please visit [linearicons](https://linearicons.com/free)
 Please check this [license](https://linearicons.com/free)
 */
public enum LinearIconType: Int {
    
    static var count: Int {
        return linearIcons.count
    }
    
    public var text: String? {
        return linearIcons[rawValue]
    }
    
    case alarm, apartment, arrowDown, arrowDownCircle, arrowLeft, arrowLeftCircle, arrowRight, arrowRightCircle, arrowUp, arrowUpCircle, bicycle, bold, book, bookmark, briefcase, bubble, bug, bullhorn, bus, calendarFull, camera, cameraVideo, car, cart, chartBars, checkmarkCircle, chevronDown, chevronDownCircle, chevronLeft, chevronLeftCircle, chevronRight, chevronRightCircle, chevronUp, chevronUpCircle, circleMinus, clock, cloud, cloudCheck, cloudDownload, cloudSync, cloudUpload, code, coffeeCup, cog, construction, crop, cross, crossCircle, database, diamond, dice, dinner, directionLtr, directionRtl, download, drop, earth, enter, enterDown, envelope, exit, exitUp, eye, fileAdd, fileEmpty, filmPlay, flag, frameContract, frameExpand, funnel, gift, graduationHat, hand, heart, heartPulse, highlight, history, home, hourglass, inbox, indentDecrease, indentIncrease, italic, keyboard, laptop, laptopPhone, layers, leaf, license, lighter, lineSpacing, linearicons, link, list, location, lock, magicWand, magnifier, map, mapMarker, menu, menuCircle, mic, moon, move, musicNote, mustache, neutral, pageBreak, paperclip, paw, pencil, phone, phoneHandset, picture, pieChart, pilcrow, plusCircle, pointerDown, pointerLeft, pointerRight, pointerUp, poop, powerSwitch, printer, pushpin, questionCircle, redo, rocket, sad, screen, select, shirt, smartphone, smile, sortAlphaAsc, sortAmountAsc, spellCheck, star, starEmpty, starHalf, store, strikethrough, sun, sync, tablet, tag, textAlignCenter, textAlignJustify, textAlignLeft, textAlignRight, textFormat, textFormatRemove, textSize, thumbsDown, thumbsUp, train, trash, underline, undo, unlink, upload, user, users, volume, volumeHigh, volumeLow, volumeMedium, warning, wheelchair
}

private let linearIcons = ["\u{e858}", "\u{e801}", "\u{e878}", "\u{e884}", "\u{e879}", "\u{e885}", "\u{e87a}", "\u{e886}", "\u{e877}", "\u{e883}", "\u{e850}", "\u{e893}", "\u{e828}", "\u{e829}", "\u{e84c}", "\u{e83f}", "\u{e869}", "\u{e859}", "\u{e84d}", "\u{e836}", "\u{e826}", "\u{e825}", "\u{e84e}", "\u{e82e}", "\u{e843}", "\u{e87f}", "\u{e874}", "\u{e888}", "\u{e875}", "\u{e889}", "\u{e876}", "\u{e88a}", "\u{e873}", "\u{e887}", "\u{e882}", "\u{e864}", "\u{e809}", "\u{e80d}", "\u{e80b}", "\u{e80c}", "\u{e80a}", "\u{e86a}", "\u{e848}", "\u{e810}", "\u{e841}", "\u{e88b}", "\u{e870}", "\u{e880}", "\u{e80e}", "\u{e845}", "\u{e812}", "\u{e847}", "\u{e8a0}", "\u{e8a1}", "\u{e865}", "\u{e804}", "\u{e853}", "\u{e81f}", "\u{e867}", "\u{e818}", "\u{e820}", "\u{e868}", "\u{e81b}", "\u{e81e}", "\u{e81d}", "\u{e824}", "\u{e817}", "\u{e88d}", "\u{e88c}", "\u{e88f}", "\u{e844}", "\u{e821}", "\u{e8a5}", "\u{e813}", "\u{e840}", "\u{e897}", "\u{e863}", "\u{e800}", "\u{e85f}", "\u{e81a}", "\u{e89e}", "\u{e89d}", "\u{e894}", "\u{e837}", "\u{e83c}", "\u{e83d}", "\u{e88e}", "\u{e849}", "\u{e822}", "\u{e805}", "\u{e89c}", "\u{e846}", "\u{e86b}", "\u{e872}", "\u{e835}", "\u{e80f}", "\u{e803}", "\u{e86f}", "\u{e834}", "\u{e833}", "\u{e871}", "\u{e87e}", "\u{e85e}", "\u{e808}", "\u{e87b}", "\u{e823}", "\u{e857}", "\u{e856}", "\u{e8a2}", "\u{e819}", "\u{e84a}", "\u{e802}", "\u{e831}", "\u{e830}", "\u{e827}", "\u{e842}", "\u{e89f}", "\u{e881}", "\u{e8a8}", "\u{e8a9}", "\u{e8a7}", "\u{e8a6}", "\u{e806}", "\u{e83e}", "\u{e81c}", "\u{e832}", "\u{e87d}", "\u{e861}", "\u{e84b}", "\u{e855}", "\u{e839}", "\u{e852}", "\u{e82c}", "\u{e83a}", "\u{e854}", "\u{e8a3}", "\u{e8a4}", "\u{e838}", "\u{e814}", "\u{e816}", "\u{e815}", "\u{e82d}", "\u{e896}", "\u{e807}", "\u{e862}", "\u{e83b}", "\u{e82f}", "\u{e899}", "\u{e89b}", "\u{e898}", "\u{e89a}", "\u{e890}", "\u{e891}", "\u{e892}", "\u{e86e}", "\u{e86d}", "\u{e84f}", "\u{e811}", "\u{e895}", "\u{e860}", "\u{e86c}", "\u{e866}", "\u{e82a}", "\u{e82b}", "\u{e85d}", "\u{e85a}", "\u{e85c}", "\u{e85b}", "\u{e87c}", "\u{e851}"]


/**
 List of all icons in FontAwesome
 
 - Author - [Scott de Jonge](https://twitter.com/scottdejonge)
 - Version: 3.0.2
 
 ## Important Notes ##
 For icons, please visit [map-icons](http://map-icons.com/)
 Please check this [license](https://github.com/scottdejonge/map-icons/blob/master/LICENSE)
 */
public enum MapiconsType: Int {
    
    static var count: Int {
        return mapicons.count
    }
    
    public var text: String? {
        return mapicons[rawValue]
    }
    
    case abseiling, accounting, airport, amusementPark, aquarium, archery, artGallery, assistiveListeningSystem, atm, audioDescription, bakery, bank, bar, baseball, beautySalon, bicycleStore, bicycling, boatRamp, boatTour, boating, bookStore, bowlingAlley, braille, busStation, cafe, campground, canoe, carDealer, carRental, carRepair, carWash, casino, cemetery, chairlift, church, circle, cityHall, climbing, closedCaptioning, clothingStore, compass, convenienceStore, courthouse, crossCountrySkiing, crosshairs, dentist, departmentStore, diving, doctor, electrician, electronicsStore, embassy, expand, female, finance, fireStation, fishCleaning, fishing, fishingPier, florist, food, fullscreen, funeralHome, furnitureStore, gasStation, generalContractor, golf, groceryOrSupermarket, gym, hairCare, hangGliding, hardwareStore, health, hinduTemple, horseRiding, hospital, iceFishing, iceSkating, inlineSkating, insuranceAgency, jetSkiing, jewelryStore, kayaking, laundry, lawyer, library, liquorStore, localGovernment, locationArrow, locksmith, lodging, lowVisionAccess, male, mapPin, marina, mosque, motobikeTrail, movieRental, movieTheater, movingCompany, museum, naturalFeature, nightClub, openCaptioning, painter, park, parking, petStore, pharmacy, physiotherapist, placeOfWorship, playground, plumber, pointOfInterest, police, political, postBox, postOffice, postalCode, postalCodePrefix, rafting, realEstateAgency, restaurant, roofingContractor, route, routePin, rvPark, sailing, school, scubaDiving, search, shield, shoppingMall, signLanguage, skateboarding, skiJumping, skiing, sledding, snow, snowShoeing, snowboarding, snowmobile, spa, square, squarePin, squareRounded, stadium, storage, store, subwayStation, surfing, swimming, synagogue, taxiStand, tennis, toilet, trailWalking, trainStation, transitStation, travelAgency, unisex, university, veterinaryCare, viewing, volumeControlTelephone, walking, waterskiing, whaleWatching, wheelchair, windSurfing, zoo, zoomIn, zoomInAlt, zoomOut, zoomOutAlt
}

private let mapicons = ["\u{e800}", "\u{e801}", "\u{e802}", "\u{e803}", "\u{e804}", "\u{e805}", "\u{e806}", "\u{e807}", "\u{e808}", "\u{e809}", "\u{e80a}", "\u{e80b}", "\u{e80c}", "\u{e80d}", "\u{e80e}", "\u{e80f}", "\u{e810}", "\u{e811}", "\u{e812}", "\u{e813}", "\u{e814}", "\u{e815}", "\u{e816}", "\u{e817}", "\u{e818}", "\u{e819}", "\u{e81a}", "\u{e81b}", "\u{e81c}", "\u{e81d}", "\u{e81e}", "\u{e81f}", "\u{e820}", "\u{e821}", "\u{e822}", "\u{e823}", "\u{e824}", "\u{e825}", "\u{e826}", "\u{e827}", "\u{e828}", "\u{e829}", "\u{e82a}", "\u{e82b}", "\u{e82c}", "\u{e82d}", "\u{e82e}", "\u{e82f}", "\u{e830}", "\u{e831}", "\u{e832}", "\u{e833}", "\u{e834}", "\u{e835}", "\u{e836}", "\u{e837}", "\u{e838}", "\u{e83a}", "\u{e839}", "\u{e83b}", "\u{e83c}", "\u{e83d}", "\u{e83e}", "\u{e83f}", "\u{e840}", "\u{e841}", "\u{e842}", "\u{e843}", "\u{e844}", "\u{e845}", "\u{e846}", "\u{e847}", "\u{e848}", "\u{e849}", "\u{e84a}", "\u{e84b}", "\u{e84c}", "\u{e84d}", "\u{e84e}", "\u{e84f}", "\u{e850}", "\u{e851}", "\u{e852}", "\u{e853}", "\u{e854}", "\u{e855}", "\u{e856}", "\u{e857}", "\u{e858}", "\u{e859}", "\u{e85a}", "\u{e85b}", "\u{e85c}", "\u{e85d}", "\u{e85e}", "\u{e85f}", "\u{e860}", "\u{e861}", "\u{e862}", "\u{e863}", "\u{e864}", "\u{e865}", "\u{e866}", "\u{e867}", "\u{e868}", "\u{e869}", "\u{e86a}", "\u{e86b}", "\u{e86c}", "\u{e86d}", "\u{e86e}", "\u{e86f}", "\u{e870}", "\u{e871}", "\u{e872}", "\u{e873}", "\u{e874}", "\u{e875}", "\u{e877}", "\u{e876}", "\u{e878}", "\u{e879}", "\u{e87a}", "\u{e87b}", "\u{e87d}", "\u{e87c}", "\u{e87e}", "\u{e87f}", "\u{e880}", "\u{e881}", "\u{e882}", "\u{e883}", "\u{e884}", "\u{e885}", "\u{e886}", "\u{e887}", "\u{e888}", "\u{e889}", "\u{e88b}", "\u{e88a}", "\u{e88c}", "\u{e88d}", "\u{e88e}", "\u{e891}", "\u{e88f}", "\u{e890}", "\u{e892}", "\u{e893}", "\u{e894}", "\u{e895}", "\u{e896}", "\u{e897}", "\u{e898}", "\u{e899}", "\u{e89a}", "\u{e89b}", "\u{e89c}", "\u{e89d}", "\u{e89e}", "\u{e89f}", "\u{e8a0}", "\u{e8a1}", "\u{e8a2}", "\u{e8a3}", "\u{e8a4}", "\u{e8a5}", "\u{e8a6}", "\u{e8a7}", "\u{e8a8}", "\u{e8a9}", "\u{e8aa}", "\u{e8ac}", "\u{e8ab}", "\u{e8ae}", "\u{e8ad}"]


/**
 List of all icons in material icons
 
 - Author - [Google](http://google.github.io/material-design-icons/)
 - Version: 2.2.0
 
 ## Important Notes ##
 For icons, please visit [material icons](https://material.io/icons/)
 Please check this [license](https://github.com/google/material-design-icons/blob/master/LICENSE)
 */
public enum GoogleMaterialDesignType: Int {
    static var count: Int {
        return googleMaterialDesignIcons.count
    }
    
    public var text: String? {
        return googleMaterialDesignIcons[rawValue]
    }
    
    case acUnit, accessAlarm, accessAlarms, accessTime, accessibility, accessible, accountBalance, accountBalanceWallet, accountBox, accountCircle, adb, add, addAPhoto, addAlarm, addAlert, addBox, addCircle, addCircleOutline, addLocation, addShoppingCart, addToPhotos, addToQueue, adjust, airlineSeatFlat, airlineSeatFlatAngled, airlineSeatIndividualSuite, airlineSeatLegroomExtra, airlineSeatLegroomNormal, airlineSeatLegroomReduced, airlineSeatReclineExtra, airlineSeatReclineNormal, airplanemodeActive, airplanemodeInactive, airplay, airportShuttle, alarm, alarmAdd, alarmOff, alarmOn, album, allInclusive, allOut, android, announcement, apps, archive, arrowBack, arrowDownward, arrowDropDown, arrowDropDownCircle, arrowDropUp, arrowForward, arrowUpward, artTrack, aspectRatio, assessment, assignment, assignmentInd, assignmentLate, assignmentReturn, assignmentReturned, assignmentTurnedIn, assistant, assistantPhoto, attachFile, attachMoney, attachment, audiotrack, autorenew, avTimer, backspace, backup, batteryAlert, batteryChargingFull, batteryFull, batteryStd, batteryUnknown, beachAccess, beenhere, block, bluetooth, bluetoothAudio, bluetoothConnected, bluetoothDisabled, bluetoothSearching, blurCircular, blurLinear, blurOff, blurOn, book, bookmark, bookmarkBorder, borderAll, borderBottom, borderClear, borderColor, borderHorizontal, borderInner, borderLeft, borderOuter, borderRight, borderStyle, borderTop, borderVertical, brandingWatermark, brightness1, brightness2, brightness3, brightness4, brightness5, brightness6, brightness7, brightnessAuto, brightnessHigh, brightnessLow, brightnessMedium, brokenImage, brush, bubbleChart, bugReport, build, burstMode, business, businessCenter, cached, cake, call, callEnd, callMade, callMerge, callMissed, callMissedOutgoing, callReceived, callSplit, callToAction, camera, cameraAlt, cameraEnhance, cameraFront, cameraRear, cameraRoll, cancel, cardGiftcard, cardMembership, cardTravel, casino, cast, castConnected, centerFocusStrong, centerFocusWeak, changeHistory, chat, chatBubble, chatBubbleOutline, check, checkBox, checkBoxOutlineBlank, checkCircle, chevronLeft, chevronRight, childCare, childFriendly, chromeReaderMode, classIcon, clear, clearAll, close, closedCaption, cloud, cloudCircle, cloudDone, cloudDownload, cloudOff, cloudQueue, cloudUpload, code, collections, collectionsBookmark, colorLens, colorize, comment, compare, compareArrows, computer, confirmationNumber, contactMail, contactPhone, contacts, contentCopy, contentCut, contentPaste, controlPoint, controlPointDuplicate, copyright, create, createNewFolder, creditCard, crop, crop169, crop32, crop54, crop75, cropDin, cropFree, cropLandscape, cropOriginal, cropPortrait, cropRotate, cropSquare, dashboard, dataUsage, dateRange, dehaze, delete, deleteForever, deleteSweep, description, desktopMac, desktopWindows, details, developerBoard, developerMode, deviceHub, devices, devicesOther, dialerSip, dialpad, directions, directionsBike, directionsBoat, directionsBus, directionsCar, directionsRailway, directionsRun, directionsSubway, directionsTransit, directionsWalk, discFull, dns, doNotDisturb, doNotDisturbAlt, doNotDisturbOff, doNotDisturbOn, dock, domain, done, doneAll, donutLarge, donutSmall, drafts, dragHandle, driveEta, dvr, edit, editLocation, eject, email, enhancedEncryption, equalizer, error, errorOutline, euroSymbol, evStation, event, eventAvailable, eventBusy, eventNote, eventSeat, exitToApp, expandLess, expandMore, explicit, explore, exposure, exposureNeg1, exposureNeg2, exposurePlus1, exposurePlus2, exposureZero, extensionIcon, face, fastForward, fastRewind, favorite, favoriteBorder, featuredPlayList, featuredVideo, feedback, fiberDvr, fiberManualRecord, fiberNew, fiberPin, fiberSmartRecord, fileDownload, fileUpload, filter, filter1, filter2, filter3, filter4, filter5, filter6, filter7, filter8, filter9, filter9Plus, filterBAndW, filterCenterFocus, filterDrama, filterFrames, filterHdr, filterList, filterNone, filterTiltShift, filterVintage, findInPage, findReplace, fingerprint, firstPage, fitnessCenter, flag, flare, flashAuto, flashOff, flashOn, flight, flightLand, flightTakeoff, flip, flipToBack, flipToFront, folder, folderOpen, folderShared, folderSpecial, fontDownload, formatAlignCenter, formatAlignJustify, formatAlignLeft, formatAlignRight, formatBold, formatClear, formatColorFill, formatColorReset, formatColorText, formatIndentDecrease, formatIndentIncrease, formatItalic, formatLineSpacing, formatListBulleted, formatListNumbered, formatPaint, formatQuote, formatShapes, formatSize, formatStrikethrough, formatTextdirectionLToR, formatTextdirectionRToL, formatUnderlined, forum, forward, forward10, forward30, forward5, freeBreakfast, fullscreen, fullscreenExit, functions, gTranslate, gamepad, games, gavel, gesture, getApp, gif, golfCourse, gpsFixed, gpsNotFixed, gpsOff, grade, gradient, grain, graphicEq, gridOff, gridOn, group, groupAdd, groupWork, hd, hdrOff, hdrOn, hdrStrong, hdrWeak, headset, headsetMic, healing, hearing, help, helpOutline, highQuality, highlight, highlightOff, history, home, hotTub, hotel, hourglassEmpty, hourglassFull, http, https, image, imageAspectRatio, importContacts, importExport, importantDevices, inbox, indeterminateCheckBox, info, infoOutline, input, insertChart, insertComment, insertDriveFile, insertEmoticon, insertInvitation, insertLink, insertPhoto, invertColors, invertColorsOff, iso, keyboard, keyboardArrowDown, keyboardArrowLeft, keyboardArrowRight, keyboardArrowUp, keyboardBackspace, keyboardCapslock, keyboardHide, keyboardReturn, keyboardTab, keyboardVoice, kitchen, label, labelOutline, landscape, language, laptop, laptopChromebook, laptopMac, laptopWindows, lastPage, launch, layers, layersClear, leakAdd, leakRemove, lens, libraryAdd, libraryBooks, libraryMusic, lightbulbOutline, lineStyle, lineWeight, linearScale, link, linkedCamera, list, liveHelp, liveTv, localActivity, localAirport, localAtm, localBar, localCafe, localCarWash, localConvenienceStore, localDining, localDrink, localFlorist, localGasStation, localGroceryStore, localHospital, localHotel, localLaundryService, localLibrary, localMall, localMovies, localOffer, localParking, localPharmacy, localPhone, localPizza, localPlay, localPostOffice, localPrintshop, localSee, localShipping, localTaxi, locationCity, locationDisabled, locationOff, locationOn, locationSearching, lock, lockOpen, lockOutline, looks, looks3, looks4, looks5, looks6, looksOne, looksTwo, loop, loupe, lowPriority, loyalty, mail, mailOutline, map, markunread, markunreadMailbox, memory, menu, mergeType, message, mic, micNone, micOff, mms, modeComment, modeEdit, monetizationOn, moneyOff, monochromePhotos, mood, moodBad, more, moreHoriz, moreVert, motorcycle, mouse, moveToInbox, movie, movieCreation, movieFilter, multilineChart, musicNote, musicVideo, myLocation, nature, naturePeople, navigateBefore, navigateNext, navigation, nearMe, networkCell, networkCheck, networkLocked, networkWifi, newReleases, nextWeek, nfc, noEncryption, noSim, notInterested, note, noteAdd, notifications, notificationsActive, notificationsNone, notificationsOff, notificationsPaused, offlinePin, ondemandVideo, opacity, openInBrowser, openInNew, openWith, pages, pageview, palette, panTool, panorama, panoramaFishEye, panoramaHorizontal, panoramaVertical, panoramaWideAngle, partyMode, pause, pauseCircleFilled, pauseCircleOutline, payment, people, peopleOutline, permCameraMic, permContactCalendar, permDataSetting, permDeviceInformation, permIdentity, permMedia, permPhoneMsg, permScanWifi, person, personAdd, personOutline, personPin, personPinCircle, personalVideo, pets, phone, phoneAndroid, phoneBluetoothSpeaker, phoneForwarded, phoneInTalk, phoneIphone, phoneLocked, phoneMissed, phonePaused, phonelink, phonelinkErase, phonelinkLock, phonelinkOff, phonelinkRing, phonelinkSetup, photo, photoAlbum, photoCamera, photoFilter, photoLibrary, photoSizeSelectActual, photoSizeSelectLarge, photoSizeSelectSmall, pictureAsPdf, pictureInPicture, pictureInPictureAlt, pieChart, pieChartOutlined, pinDrop, place, playArrow, playCircleFilled, playCircleOutline, playForWork, playlistAdd, playlistAddCheck, playlistPlay, plusOne, poll, polymer, pool, portableWifiOff, portrait, power, powerInput, powerSettingsNew, pregnantWoman, presentToAll, print, priorityHigh, publicIcon, publish, queryBuilder, questionAnswer, queue, queueMusic, queuePlayNext, radio, radioButtonChecked, radioButtonUnchecked, rateReview, receipt, recentActors, recordVoiceOver, redeem, redo, refresh, remove, removeCircle, removeCircleOutline, removeFromQueue, removeRedEye, removeShoppingCart, reorder, repeatIcon, repeatOne, replay, replay10, replay30, replay5, reply, replyAll, report, reportProblem, restaurant, restaurantMenu, restore, restorePage, ringVolume, room, roomService, rotate90DegreesCcw, rotateLeft, rotateRight, roundedCorner, router, rowing, rssFeed, rvHookup, satellite, save, scanner, schedule, school, screenLockLandscape, screenLockPortrait, screenLockRotation, screenRotation, screenShare, sdCard, sdStorage, search, security, selectAll, send, sentimentDissatisfied, sentimentNeutral, sentimentSatisfied, sentimentVeryDissatisfied, sentimentVerySatisfied, settings, settingsApplications, settingsBackupRestore, settingsBluetooth, settingsBrightness, settingsCell, settingsEthernet, settingsInputAntenna, settingsInputComponent, settingsInputComposite, settingsInputHdmi, settingsInputSvideo, settingsOverscan, settingsPhone, settingsPower, settingsRemote, settingsSystemDaydream, settingsVoice, share, shop, shopTwo, shoppingBasket, shoppingCart, shortText, showChart, shuffle, signalCellular4Bar, signalCellularConnectedNoInternet4Bar, signalCellularNoSim, signalCellularNull, signalCellularOff, signalWifi4Bar, signalWifi4BarLock, signalWifiOff, simCard, simCardAlert, skipNext, skipPrevious, slideshow, slowMotionVideo, smartphone, smokeFree, smokingRooms, sms, smsFailed, snooze, sort, sortByAlpha, spa, spaceBar, speaker, speakerGroup, speakerNotes, speakerNotesOff, speakerPhone, spellcheck, star, starBorder, starHalf, stars, stayCurrentLandscape, stayCurrentPortrait, stayPrimaryLandscape, stayPrimaryPortrait, stop, stopScreenShare, storage, store, storeMallDirectory, straighten, streetview, strikethroughS, style, subdirectoryArrowLeft, subdirectoryArrowRight, subject, subscriptions, subtitles, subway, supervisorAccount, surroundSound, swapCalls, swapHoriz, swapVert, swapVerticalCircle, switchCamera, switchVideo, sync, syncDisabled, syncProblem, systemUpdate, systemUpdateAlt, tab, tabUnselected, tablet, tabletAndroid, tabletMac, tagFaces, tapAndPlay, terrain, textFields, textFormat, textsms, texture, theaters, threedRotation, thumbDown, thumbUp, thumbsUpDown, timeToLeave, timelapse, timeline, timer, timer10, timer3, timerOff, title, toc, today, toll, tonality, touchApp, toys, trackChanges, traffic, train, tram, transferWithinAStation, transform, translate, trendingDown, trendingFlat, trendingUp, tune, turnedIn, turnedInNot, tv, unarchive, undo, unfoldLess, unfoldMore, update, usb, verifiedUser, verticalAlignBottom, verticalAlignCenter, verticalAlignTop, vibration, videoCall, videoLabel, videoLibrary, videocam, videocamOff, videogameAsset, viewAgenda, viewArray, viewCarousel, viewColumn, viewComfy, viewCompact, viewDay, viewHeadline, viewList, viewModule, viewQuilt, viewStream, viewWeek, vignette, visibility, visibilityOff, voiceChat, voicemail, volumeDown, volumeMute, volumeOff, volumeUp, vpnKey, vpnLock, wallpaper, warning, watch, watchLater, wbAuto, wbCloudy, wbIncandescent, wbIridescent, wbSunny, wc, web, webAsset, weekend, whatshot, widgets, wifi, wifiLock, wifiTethering, work, wrapText, youtubeSearchedFor, zoomIn, zoomOut, zoomOutMap
}

private let googleMaterialDesignIcons = ["\u{eb3b}", "\u{e190}", "\u{e191}", "\u{e192}", "\u{e84e}", "\u{e914}", "\u{e84f}", "\u{e850}", "\u{e851}", "\u{e853}", "\u{e60e}", "\u{e145}", "\u{e439}", "\u{e193}", "\u{e003}", "\u{e146}", "\u{e147}", "\u{e148}", "\u{e567}", "\u{e854}", "\u{e39d}", "\u{e05c}", "\u{e39e}", "\u{e630}", "\u{e631}", "\u{e632}", "\u{e633}", "\u{e634}", "\u{e635}", "\u{e636}", "\u{e637}", "\u{e195}", "\u{e194}", "\u{e055}", "\u{eb3c}", "\u{e855}", "\u{e856}", "\u{e857}", "\u{e858}", "\u{e019}", "\u{eb3d}", "\u{e90b}", "\u{e859}", "\u{e85a}", "\u{e5c3}", "\u{e149}", "\u{e5c4}", "\u{e5db}", "\u{e5c5}", "\u{e5c6}", "\u{e5c7}", "\u{e5c8}", "\u{e5d8}", "\u{e060}", "\u{e85b}", "\u{e85c}", "\u{e85d}", "\u{e85e}", "\u{e85f}", "\u{e860}", "\u{e861}", "\u{e862}", "\u{e39f}", "\u{e3a0}", "\u{e226}", "\u{e227}", "\u{e2bc}", "\u{e3a1}", "\u{e863}", "\u{e01b}", "\u{e14a}", "\u{e864}", "\u{e19c}", "\u{e1a3}", "\u{e1a4}", "\u{e1a5}", "\u{e1a6}", "\u{eb3e}", "\u{e52d}", "\u{e14b}", "\u{e1a7}", "\u{e60f}", "\u{e1a8}", "\u{e1a9}", "\u{e1aa}", "\u{e3a2}", "\u{e3a3}", "\u{e3a4}", "\u{e3a5}", "\u{e865}", "\u{e866}", "\u{e867}", "\u{e228}", "\u{e229}", "\u{e22a}", "\u{e22b}", "\u{e22c}", "\u{e22d}", "\u{e22e}", "\u{e22f}", "\u{e230}", "\u{e231}", "\u{e232}", "\u{e233}", "\u{e06b}", "\u{e3a6}", "\u{e3a7}", "\u{e3a8}", "\u{e3a9}", "\u{e3aa}", "\u{e3ab}", "\u{e3ac}", "\u{e1ab}", "\u{e1ac}", "\u{e1ad}", "\u{e1ae}", "\u{e3ad}", "\u{e3ae}", "\u{e6dd}", "\u{e868}", "\u{e869}", "\u{e43c}", "\u{e0af}", "\u{eb3f}", "\u{e86a}", "\u{e7e9}", "\u{e0b0}", "\u{e0b1}", "\u{e0b2}", "\u{e0b3}", "\u{e0b4}", "\u{e0e4}", "\u{e0b5}", "\u{e0b6}", "\u{e06c}", "\u{e3af}", "\u{e3b0}", "\u{e8fc}", "\u{e3b1}", "\u{e3b2}", "\u{e3b3}", "\u{e5c9}", "\u{e8f6}", "\u{e8f7}", "\u{e8f8}", "\u{eb40}", "\u{e307}", "\u{e308}", "\u{e3b4}", "\u{e3b5}", "\u{e86b}", "\u{e0b7}", "\u{e0ca}", "\u{e0cb}", "\u{e5ca}", "\u{e834}", "\u{e835}", "\u{e86c}", "\u{e5cb}", "\u{e5cc}", "\u{eb41}", "\u{eb42}", "\u{e86d}", "\u{e86e}", "\u{e14c}", "\u{e0b8}", "\u{e5cd}", "\u{e01c}", "\u{e2bd}", "\u{e2be}", "\u{e2bf}", "\u{e2c0}", "\u{e2c1}", "\u{e2c2}", "\u{e2c3}", "\u{e86f}", "\u{e3b6}", "\u{e431}", "\u{e3b7}", "\u{e3b8}", "\u{e0b9}", "\u{e3b9}", "\u{e915}", "\u{e30a}", "\u{e638}", "\u{e0d0}", "\u{e0cf}", "\u{e0ba}", "\u{e14d}", "\u{e14e}", "\u{e14f}", "\u{e3ba}", "\u{e3bb}", "\u{e90c}", "\u{e150}", "\u{e2cc}", "\u{e870}", "\u{e3be}", "\u{e3bc}", "\u{e3bd}", "\u{e3bf}", "\u{e3c0}", "\u{e3c1}", "\u{e3c2}", "\u{e3c3}", "\u{e3c4}", "\u{e3c5}", "\u{e437}", "\u{e3c6}", "\u{e871}", "\u{e1af}", "\u{e916}", "\u{e3c7}", "\u{e872}", "\u{e92b}", "\u{e16c}", "\u{e873}", "\u{e30b}", "\u{e30c}", "\u{e3c8}", "\u{e30d}", "\u{e1b0}", "\u{e335}", "\u{e1b1}", "\u{e337}", "\u{e0bb}", "\u{e0bc}", "\u{e52e}", "\u{e52f}", "\u{e532}", "\u{e530}", "\u{e531}", "\u{e534}", "\u{e566}", "\u{e533}", "\u{e535}", "\u{e536}", "\u{e610}", "\u{e875}", "\u{e612}", "\u{e611}", "\u{e643}", "\u{e644}", "\u{e30e}", "\u{e7ee}", "\u{e876}", "\u{e877}", "\u{e917}", "\u{e918}", "\u{e151}", "\u{e25d}", "\u{e613}", "\u{e1b2}", "\u{e3c9}", "\u{e568}", "\u{e8fb}", "\u{e0be}", "\u{e63f}", "\u{e01d}", "\u{e000}", "\u{e001}", "\u{e926}", "\u{e56d}", "\u{e878}", "\u{e614}", "\u{e615}", "\u{e616}", "\u{e903}", "\u{e879}", "\u{e5ce}", "\u{e5cf}", "\u{e01e}", "\u{e87a}", "\u{e3ca}", "\u{e3cb}", "\u{e3cc}", "\u{e3cd}", "\u{e3ce}", "\u{e3cf}", "\u{e87b}", "\u{e87c}", "\u{e01f}", "\u{e020}", "\u{e87d}", "\u{e87e}", "\u{e06d}", "\u{e06e}", "\u{e87f}", "\u{e05d}", "\u{e061}", "\u{e05e}", "\u{e06a}", "\u{e062}", "\u{e2c4}", "\u{e2c6}", "\u{e3d3}", "\u{e3d0}", "\u{e3d1}", "\u{e3d2}", "\u{e3d4}", "\u{e3d5}", "\u{e3d6}", "\u{e3d7}", "\u{e3d8}", "\u{e3d9}", "\u{e3da}", "\u{e3db}", "\u{e3dc}", "\u{e3dd}", "\u{e3de}", "\u{e3df}", "\u{e152}", "\u{e3e0}", "\u{e3e2}", "\u{e3e3}", "\u{e880}", "\u{e881}", "\u{e90d}", "\u{e5dc}", "\u{eb43}", "\u{e153}", "\u{e3e4}", "\u{e3e5}", "\u{e3e6}", "\u{e3e7}", "\u{e539}", "\u{e904}", "\u{e905}", "\u{e3e8}", "\u{e882}", "\u{e883}", "\u{e2c7}", "\u{e2c8}", "\u{e2c9}", "\u{e617}", "\u{e167}", "\u{e234}", "\u{e235}", "\u{e236}", "\u{e237}", "\u{e238}", "\u{e239}", "\u{e23a}", "\u{e23b}", "\u{e23c}", "\u{e23d}", "\u{e23e}", "\u{e23f}", "\u{e240}", "\u{e241}", "\u{e242}", "\u{e243}", "\u{e244}", "\u{e25e}", "\u{e245}", "\u{e246}", "\u{e247}", "\u{e248}", "\u{e249}", "\u{e0bf}", "\u{e154}", "\u{e056}", "\u{e057}", "\u{e058}", "\u{eb44}", "\u{e5d0}", "\u{e5d1}", "\u{e24a}", "\u{e927}", "\u{e30f}", "\u{e021}", "\u{e90e}", "\u{e155}", "\u{e884}", "\u{e908}", "\u{eb45}", "\u{e1b3}", "\u{e1b4}", "\u{e1b5}", "\u{e885}", "\u{e3e9}", "\u{e3ea}", "\u{e1b8}", "\u{e3eb}", "\u{e3ec}", "\u{e7ef}", "\u{e7f0}", "\u{e886}", "\u{e052}", "\u{e3ed}", "\u{e3ee}", "\u{e3f1}", "\u{e3f2}", "\u{e310}", "\u{e311}", "\u{e3f3}", "\u{e023}", "\u{e887}", "\u{e8fd}", "\u{e024}", "\u{e25f}", "\u{e888}", "\u{e889}", "\u{e88a}", "\u{eb46}", "\u{e53a}", "\u{e88b}", "\u{e88c}", "\u{e902}", "\u{e88d}", "\u{e3f4}", "\u{e3f5}", "\u{e0e0}", "\u{e0c3}", "\u{e912}", "\u{e156}", "\u{e909}", "\u{e88e}", "\u{e88f}", "\u{e890}", "\u{e24b}", "\u{e24c}", "\u{e24d}", "\u{e24e}", "\u{e24f}", "\u{e250}", "\u{e251}", "\u{e891}", "\u{e0c4}", "\u{e3f6}", "\u{e312}", "\u{e313}", "\u{e314}", "\u{e315}", "\u{e316}", "\u{e317}", "\u{e318}", "\u{e31a}", "\u{e31b}", "\u{e31c}", "\u{e31d}", "\u{eb47}", "\u{e892}", "\u{e893}", "\u{e3f7}", "\u{e894}", "\u{e31e}", "\u{e31f}", "\u{e320}", "\u{e321}", "\u{e5dd}", "\u{e895}", "\u{e53b}", "\u{e53c}", "\u{e3f8}", "\u{e3f9}", "\u{e3fa}", "\u{e02e}", "\u{e02f}", "\u{e030}", "\u{e90f}", "\u{e919}", "\u{e91a}", "\u{e260}", "\u{e157}", "\u{e438}", "\u{e896}", "\u{e0c6}", "\u{e639}", "\u{e53f}", "\u{e53d}", "\u{e53e}", "\u{e540}", "\u{e541}", "\u{e542}", "\u{e543}", "\u{e556}", "\u{e544}", "\u{e545}", "\u{e546}", "\u{e547}", "\u{e548}", "\u{e549}", "\u{e54a}", "\u{e54b}", "\u{e54c}", "\u{e54d}", "\u{e54e}", "\u{e54f}", "\u{e550}", "\u{e551}", "\u{e552}", "\u{e553}", "\u{e554}", "\u{e555}", "\u{e557}", "\u{e558}", "\u{e559}", "\u{e7f1}", "\u{e1b6}", "\u{e0c7}", "\u{e0c8}", "\u{e1b7}", "\u{e897}", "\u{e898}", "\u{e899}", "\u{e3fc}", "\u{e3fb}", "\u{e3fd}", "\u{e3fe}", "\u{e3ff}", "\u{e400}", "\u{e401}", "\u{e028}", "\u{e402}", "\u{e16d}", "\u{e89a}", "\u{e158}", "\u{e0e1}", "\u{e55b}", "\u{e159}", "\u{e89b}", "\u{e322}", "\u{e5d2}", "\u{e252}", "\u{e0c9}", "\u{e029}", "\u{e02a}", "\u{e02b}", "\u{e618}", "\u{e253}", "\u{e254}", "\u{e263}", "\u{e25c}", "\u{e403}", "\u{e7f2}", "\u{e7f3}", "\u{e619}", "\u{e5d3}", "\u{e5d4}", "\u{e91b}", "\u{e323}", "\u{e168}", "\u{e02c}", "\u{e404}", "\u{e43a}", "\u{e6df}", "\u{e405}", "\u{e063}", "\u{e55c}", "\u{e406}", "\u{e407}", "\u{e408}", "\u{e409}", "\u{e55d}", "\u{e569}", "\u{e1b9}", "\u{e640}", "\u{e61a}", "\u{e1ba}", "\u{e031}", "\u{e16a}", "\u{e1bb}", "\u{e641}", "\u{e0cc}", "\u{e033}", "\u{e06f}", "\u{e89c}", "\u{e7f4}", "\u{e7f7}", "\u{e7f5}", "\u{e7f6}", "\u{e7f8}", "\u{e90a}", "\u{e63a}", "\u{e91c}", "\u{e89d}", "\u{e89e}", "\u{e89f}", "\u{e7f9}", "\u{e8a0}", "\u{e40a}", "\u{e925}", "\u{e40b}", "\u{e40c}", "\u{e40d}", "\u{e40e}", "\u{e40f}", "\u{e7fa}", "\u{e034}", "\u{e035}", "\u{e036}", "\u{e8a1}", "\u{e7fb}", "\u{e7fc}", "\u{e8a2}", "\u{e8a3}", "\u{e8a4}", "\u{e8a5}", "\u{e8a6}", "\u{e8a7}", "\u{e8a8}", "\u{e8a9}", "\u{e7fd}", "\u{e7fe}", "\u{e7ff}", "\u{e55a}", "\u{e56a}", "\u{e63b}", "\u{e91d}", "\u{e0cd}", "\u{e324}", "\u{e61b}", "\u{e61c}", "\u{e61d}", "\u{e325}", "\u{e61e}", "\u{e61f}", "\u{e620}", "\u{e326}", "\u{e0db}", "\u{e0dc}", "\u{e327}", "\u{e0dd}", "\u{e0de}", "\u{e410}", "\u{e411}", "\u{e412}", "\u{e43b}", "\u{e413}", "\u{e432}", "\u{e433}", "\u{e434}", "\u{e415}", "\u{e8aa}", "\u{e911}", "\u{e6c4}", "\u{e6c5}", "\u{e55e}", "\u{e55f}", "\u{e037}", "\u{e038}", "\u{e039}", "\u{e906}", "\u{e03b}", "\u{e065}", "\u{e05f}", "\u{e800}", "\u{e801}", "\u{e8ab}", "\u{eb48}", "\u{e0ce}", "\u{e416}", "\u{e63c}", "\u{e336}", "\u{e8ac}", "\u{e91e}", "\u{e0df}", "\u{e8ad}", "\u{e645}", "\u{e80b}", "\u{e255}", "\u{e8ae}", "\u{e8af}", "\u{e03c}", "\u{e03d}", "\u{e066}", "\u{e03e}", "\u{e837}", "\u{e836}", "\u{e560}", "\u{e8b0}", "\u{e03f}", "\u{e91f}", "\u{e8b1}", "\u{e15a}", "\u{e5d5}", "\u{e15b}", "\u{e15c}", "\u{e15d}", "\u{e067}", "\u{e417}", "\u{e928}", "\u{e8fe}", "\u{e040}", "\u{e041}", "\u{e042}", "\u{e059}", "\u{e05a}", "\u{e05b}", "\u{e15e}", "\u{e15f}", "\u{e160}", "\u{e8b2}", "\u{e56c}", "\u{e561}", "\u{e8b3}", "\u{e929}", "\u{e0d1}", "\u{e8b4}", "\u{eb49}", "\u{e418}", "\u{e419}", "\u{e41a}", "\u{e920}", "\u{e328}", "\u{e921}", "\u{e0e5}", "\u{e642}", "\u{e562}", "\u{e161}", "\u{e329}", "\u{e8b5}", "\u{e80c}", "\u{e1be}", "\u{e1bf}", "\u{e1c0}", "\u{e1c1}", "\u{e0e2}", "\u{e623}", "\u{e1c2}", "\u{e8b6}", "\u{e32a}", "\u{e162}", "\u{e163}", "\u{e811}", "\u{e812}", "\u{e813}", "\u{e814}", "\u{e815}", "\u{e8b8}", "\u{e8b9}", "\u{e8ba}", "\u{e8bb}", "\u{e8bd}", "\u{e8bc}", "\u{e8be}", "\u{e8bf}", "\u{e8c0}", "\u{e8c1}", "\u{e8c2}", "\u{e8c3}", "\u{e8c4}", "\u{e8c5}", "\u{e8c6}", "\u{e8c7}", "\u{e1c3}", "\u{e8c8}", "\u{e80d}", "\u{e8c9}", "\u{e8ca}", "\u{e8cb}", "\u{e8cc}", "\u{e261}", "\u{e6e1}", "\u{e043}", "\u{e1c8}", "\u{e1cd}", "\u{e1ce}", "\u{e1cf}", "\u{e1d0}", "\u{e1d8}", "\u{e1d9}", "\u{e1da}", "\u{e32b}", "\u{e624}", "\u{e044}", "\u{e045}", "\u{e41b}", "\u{e068}", "\u{e32c}", "\u{eb4a}", "\u{eb4b}", "\u{e625}", "\u{e626}", "\u{e046}", "\u{e164}", "\u{e053}", "\u{eb4c}", "\u{e256}", "\u{e32d}", "\u{e32e}", "\u{e8cd}", "\u{e92a}", "\u{e0d2}", "\u{e8ce}", "\u{e838}", "\u{e83a}", "\u{e839}", "\u{e8d0}", "\u{e0d3}", "\u{e0d4}", "\u{e0d5}", "\u{e0d6}", "\u{e047}", "\u{e0e3}", "\u{e1db}", "\u{e8d1}", "\u{e563}", "\u{e41c}", "\u{e56e}", "\u{e257}", "\u{e41d}", "\u{e5d9}", "\u{e5da}", "\u{e8d2}", "\u{e064}", "\u{e048}", "\u{e56f}", "\u{e8d3}", "\u{e049}", "\u{e0d7}", "\u{e8d4}", "\u{e8d5}", "\u{e8d6}", "\u{e41e}", "\u{e41f}", "\u{e627}", "\u{e628}", "\u{e629}", "\u{e62a}", "\u{e8d7}", "\u{e8d8}", "\u{e8d9}", "\u{e32f}", "\u{e330}", "\u{e331}", "\u{e420}", "\u{e62b}", "\u{e564}", "\u{e262}", "\u{e165}", "\u{e0d8}", "\u{e421}", "\u{e8da}", "\u{e84d}", "\u{e8db}", "\u{e8dc}", "\u{e8dd}", "\u{e62c}", "\u{e422}", "\u{e922}", "\u{e425}", "\u{e423}", "\u{e424}", "\u{e426}", "\u{e264}", "\u{e8de}", "\u{e8df}", "\u{e8e0}", "\u{e427}", "\u{e913}", "\u{e332}", "\u{e8e1}", "\u{e565}", "\u{e570}", "\u{e571}", "\u{e572}", "\u{e428}", "\u{e8e2}", "\u{e8e3}", "\u{e8e4}", "\u{e8e5}", "\u{e429}", "\u{e8e6}", "\u{e8e7}", "\u{e333}", "\u{e169}", "\u{e166}", "\u{e5d6}", "\u{e5d7}", "\u{e923}", "\u{e1e0}", "\u{e8e8}", "\u{e258}", "\u{e259}", "\u{e25a}", "\u{e62d}", "\u{e070}", "\u{e071}", "\u{e04a}", "\u{e04b}", "\u{e04c}", "\u{e338}", "\u{e8e9}", "\u{e8ea}", "\u{e8eb}", "\u{e8ec}", "\u{e42a}", "\u{e42b}", "\u{e8ed}", "\u{e8ee}", "\u{e8ef}", "\u{e8f0}", "\u{e8f1}", "\u{e8f2}", "\u{e8f3}", "\u{e435}", "\u{e8f4}", "\u{e8f5}", "\u{e62e}", "\u{e0d9}", "\u{e04d}", "\u{e04e}", "\u{e04f}", "\u{e050}", "\u{e0da}", "\u{e62f}", "\u{e1bc}", "\u{e002}", "\u{e334}", "\u{e924}", "\u{e42c}", "\u{e42d}", "\u{e42e}", "\u{e436}", "\u{e430}", "\u{e63d}", "\u{e051}", "\u{e069}", "\u{e16b}", "\u{e80e}", "\u{e1bd}", "\u{e63e}", "\u{e1e1}", "\u{e1e2}", "\u{e8f9}", "\u{e25b}", "\u{e8fa}", "\u{e8ff}", "\u{e900}", "\u{e56b}"]


/**
 List of all icons in open-iconic
 
 - Author - [Iconic](https://useiconic.com/)
 - Version: 1.1.1
 
 ## Important Notes ##
 For icons, please visit [open iconic icons](https://useiconic.com/open)
 Please check this [license](https://github.com/iconic/open-iconic/blob/master/ICON-LICENSE)
 */
public enum OpenIconicType: Int {
    
    static var count: Int {
        return openIconicIcons.count
    }
    
    public var text: String? {
        return openIconicIcons[rawValue]
    }
    
    case accountLogin, accountLogout, actionRedo, actionUndo, alignCenter, alignLeft, alignRight, aperture, arrowBottom, arrowCircleBottom, arrowCircleLeft, arrowCircleRight, arrowCircleTop, arrowLeft, arrowRight, arrowThickBottom, arrowThickLeft, arrowThickRight, arrowThickTop, arrowTop, audio, audioSpectrum, badge, ban, barChart, basket, batteryEmpty, batteryFull, beaker, bell, bluetooth, bold, bolt, book, bookmark, box, briefcase, britishPound, browser, brush, bug, bullhorn, calculator, calendar, cameraSlr, caretBottom, caretLeft, caretRight, caretTop, cart, chat, check, chevronBottom, chevronLeft, chevronRight, chevronTop, circleCheck, circleX, clipboard, clock, cloud, cloudDownload, cloudUpload, cloudy, code, cog, collapseDown, collapseLeft, collapseRight, collapseUp, command, commentSquare, compass, contrast, copywriting, creditCard, crop, dashboard, dataTransferDownload, dataTransferUpload, delete, dial, document, dollar, doubleQuoteSansLeft, doubleQuoteSansRight, doubleQuoteSerifLeft, doubleQuoteSerifRight, droplet, eject, elevator, ellipses, envelopeClosed, envelopeOpen, euro, excerpt, expandDown, expandLeft, expandRight, expandUp, externalLink, eye, eyedropper, file, fire, flag, flash, folder, fork, fullscreenEnter, fullscreenExit, globe, graph, gridFourUp, gridThreeUp, gridTwoUp, hardDrive, header, headphones, heart, home, image, inbox, infinity, info, italic, justifyCenter, justifyLeft, justifyRight, key, laptop, layers, lightbulb, linkBroken, linkIntact, list, listRich, location, lockLocked, lockUnlocked, loop, loopCircular, loopSquare, magnifyingGlass, map, mapMarker, mediaPause, mediaPlay, mediaRecord, mediaSkipBackward, mediaSkipForward, mediaStepBackward, mediaStepForward, mediaStop, medicalCross, menu, microphone, minus, monitor, moon, move, musicalNote, paperclip, pencil, people, person, phone, pieChart, pin, playCircle, plus, powerStandby, print, project, pulse, puzzlePiece, questionMark, rain, random, reload, resizeBoth, resizeHeight, resizeWidth, rss, rssAlt, script, share, shareBoxed, shield, signal, signpost, sortAscending, sortDescending, spreadsheet, star, sun, tablet, tag, tags, target, task, terminal, text, thumbDown, thumbUp, timer, transfer, trash, underline, verticalAlignBottom, verticalAlignCenter, verticalAlignTop, video, volumeHigh, volumeLow, volumeOff, warning, wifi, wrench, x, yen, zoomIn, zoomOut
}

private let openIconicIcons = ["\u{e000}", "\u{e001}", "\u{e002}", "\u{e003}", "\u{e004}", "\u{e005}", "\u{e006}", "\u{e007}", "\u{e008}", "\u{e009}", "\u{e00a}", "\u{e00b}", "\u{e00c}", "\u{e00d}", "\u{e00e}", "\u{e00f}", "\u{e010}", "\u{e011}", "\u{e012}", "\u{e013}", "\u{e015}", "\u{e014}", "\u{e016}", "\u{e017}", "\u{e018}", "\u{e019}", "\u{e01a}", "\u{e01b}", "\u{e01c}", "\u{e01d}", "\u{e01e}", "\u{e01f}", "\u{e020}", "\u{e021}", "\u{e022}", "\u{e023}", "\u{e024}", "\u{e025}", "\u{e026}", "\u{e027}", "\u{e028}", "\u{e029}", "\u{e02a}", "\u{e02b}", "\u{e02c}", "\u{e02d}", "\u{e02e}", "\u{e02f}", "\u{e030}", "\u{e031}", "\u{e032}", "\u{e033}", "\u{e034}", "\u{e035}", "\u{e036}", "\u{e037}", "\u{e038}", "\u{e039}", "\u{e03a}", "\u{e03b}", "\u{e03e}", "\u{e03c}", "\u{e03d}", "\u{e03f}", "\u{e040}", "\u{e041}", "\u{e042}", "\u{e043}", "\u{e044}", "\u{e045}", "\u{e046}", "\u{e047}", "\u{e048}", "\u{e049}", "\u{e04a}", "\u{e04b}", "\u{e04c}", "\u{e04d}", "\u{e04e}", "\u{e04f}", "\u{e050}", "\u{e051}", "\u{e052}", "\u{e053}", "\u{e054}", "\u{e055}", "\u{e056}", "\u{e057}", "\u{e058}", "\u{e059}", "\u{e05a}", "\u{e05b}", "\u{e05c}", "\u{e05d}", "\u{e05e}", "\u{e05f}", "\u{e060}", "\u{e061}", "\u{e062}", "\u{e063}", "\u{e064}", "\u{e065}", "\u{e066}", "\u{e067}", "\u{e068}", "\u{e069}", "\u{e06a}", "\u{e06b}", "\u{e06c}", "\u{e06d}", "\u{e06e}", "\u{e06f}", "\u{e070}", "\u{e071}", "\u{e072}", "\u{e073}", "\u{e074}", "\u{e075}", "\u{e076}", "\u{e077}", "\u{e078}", "\u{e079}", "\u{e07a}", "\u{e07b}", "\u{e07c}", "\u{e07d}", "\u{e07e}", "\u{e07f}", "\u{e080}", "\u{e081}", "\u{e082}", "\u{e083}", "\u{e084}", "\u{e085}", "\u{e086}", "\u{e088}", "\u{e087}", "\u{e089}", "\u{e08a}", "\u{e08b}", "\u{e08e}", "\u{e08c}", "\u{e08d}", "\u{e08f}", "\u{e091}", "\u{e090}", "\u{e092}", "\u{e093}", "\u{e094}", "\u{e095}", "\u{e096}", "\u{e097}", "\u{e098}", "\u{e099}", "\u{e09a}", "\u{e09b}", "\u{e09c}", "\u{e09d}", "\u{e09e}", "\u{e09f}", "\u{e0a0}", "\u{e0a1}", "\u{e0a2}", "\u{e0a3}", "\u{e0a4}", "\u{e0a5}", "\u{e0a6}", "\u{e0a7}", "\u{e0a8}", "\u{e0a9}", "\u{e0aa}", "\u{e0ab}", "\u{e0ac}", "\u{e0ad}", "\u{e0ae}", "\u{e0af}", "\u{e0b0}", "\u{e0b1}", "\u{e0b2}", "\u{e0b3}", "\u{e0b4}", "\u{e0b5}", "\u{e0b6}", "\u{e0b8}", "\u{e0b7}", "\u{e0b9}", "\u{e0bb}", "\u{e0ba}", "\u{e0bc}", "\u{e0bd}", "\u{e0be}", "\u{e0bf}", "\u{e0c0}", "\u{e0c1}", "\u{e0c2}", "\u{e0c3}", "\u{e0c4}", "\u{e0c5}", "\u{e0c6}", "\u{e0c7}", "\u{e0c8}", "\u{e0c9}", "\u{e0ca}", "\u{e0cb}", "\u{e0cc}", "\u{e0cd}", "\u{e0ce}", "\u{e0cf}", "\u{e0d0}", "\u{e0d1}", "\u{e0d2}", "\u{e0d3}", "\u{e0d4}", "\u{e0d5}", "\u{e0d6}", "\u{e0d7}", "\u{e0d8}", "\u{e0d9}", "\u{e0da}", "\u{e0db}", "\u{e0dc}", "\u{e0dd}", "\u{e0de}"]


/**
 List of all icons in state face
 
 - Author - [Propublica](https://www.propublica.org/)
 
 ## Important Notes ##
 For icons, please visit [state face](http://propublica.github.io/stateface/)
 Please check this [license](https://github.com/propublica/stateface/blob/master/LICENSE.txt)
 */
public enum StatefaceType: Int {
    
    static var count: Int {
        return statefaceIcons.count
    }
    
    public var text: String? {
        return statefaceIcons[rawValue]
    }
    
    case AK, AL, AR, AZ, CA, CO, CT, DC, DE, FL, GA, HI, IA, ID, IL, IN, KS, KY, LA, MA, MD, ME, MI, MN, MO, MS, MT, NC, ND, NE, NH, NJ, NM, NV, NY, OH, OK, OR, PA, RI, SC, SD, TN, TX, US, UT, VA, VT, WA, WI, WV, WY
}

private let statefaceIcons = ["A", "B", "C", "D", "E", "F", "G", "y", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "z", "r", "s", "t", "u", "v", "w", "x"]


/**
 List of all icons in weather icons
 
 - Author - [Erik Flowers](https://twitter.com/erik_flowers)
 - Version: 2.0.10
 
 ## Important Notes ##
 For icons, please visit [weather icons](http://weathericons.io/)
 Please check this [license](http://weathericons.io/)
 */
public enum WeatherType: Int {
    
    static var count: Int {
        return weatherIcons.count
    }
    
    public var text: String? {
        return weatherIcons[rawValue]
    }
    
    case alien, barometer, celsius, cloud, cloudDown, cloudRefresh, cloudUp, cloudy, cloudyGusts, cloudyWindy, dayCloudy, dayCloudyGusts, dayCloudyHigh, dayCloudyWindy, dayFog, dayHail, dayHaze, dayLightWind, dayLightning, dayRain, dayRainMix, dayRainWind, dayShowers, daySleet, daySleetStorm, daySnow, daySnowThunderstorm, daySnowWind, daySprinkle, dayStormShowers, daySunny, daySunnyOvercast, dayThunderstorm, dayWindy, degrees, directionDown, directionDownLeft, directionDownRight, directionLeft, directionRight, directionUp, directionUpLeft, directionUpRight, dust, earthquake, fahrenheit, fire, flood, fog, forecastIoClearDay, forecastIoClearNight, forecastIoCloudy, forecastIoFog, forecastIoHail, forecastIoPartlyCloudyDay, forecastIoPartlyCloudyNight, forecastIoRain, forecastIoSleet, forecastIoSnow, forecastIoThunderstorm, forecastIoTornado, forecastIoWind, galeWarning, hail, horizon, horizonAlt, hot, humidity, hurricane, hurricaneWarning, lightning, lunarEclipse, meteor, moon0, moon1, moon10, moon11, moon12, moon13, moon14, moon15, moon16, moon17, moon18, moon19, moon2, moon20, moon21, moon22, moon23, moon24, moon25, moon26, moon27, moon3, moon4, moon5, moon6, moon7, moon8, moon9, moonAltFirstQuarter, moonAltFull, moonAltNew, moonAltThirdQuarter, moonAltWaningCrescent1, moonAltWaningCrescent2, moonAltWaningCrescent3, moonAltWaningCrescent4, moonAltWaningCrescent5, moonAltWaningCrescent6, moonAltWaningGibbous1, moonAltWaningGibbous2, moonAltWaningGibbous3, moonAltWaningGibbous4, moonAltWaningGibbous5, moonAltWaningGibbous6, moonAltWaxingCrescent1, moonAltWaxingCrescent2, moonAltWaxingCrescent3, moonAltWaxingCrescent4, moonAltWaxingCrescent5, moonAltWaxingCrescent6, moonAltWaxingGibbous1, moonAltWaxingGibbous2, moonAltWaxingGibbous3, moonAltWaxingGibbous4, moonAltWaxingGibbous5, moonAltWaxingGibbous6, moonFirstQuarter, moonFull, moonNew, moonThirdQuarter, moonWaningCrescent1, moonWaningCrescent2, moonWaningCrescent3, moonWaningCrescent4, moonWaningCrescent5, moonWaningCrescent6, moonWaningGibbous1, moonWaningGibbous2, moonWaningGibbous3, moonWaningGibbous4, moonWaningGibbous5, moonWaningGibbous6, moonWaxingCrescent1, moonWaxingCrescent2, moonWaxingCrescent3, moonWaxingCrescent4, moonWaxingCrescent5, moonWaxingCrescent6, moonWaxingGibbous1, moonWaxingGibbous2, moonWaxingGibbous3, moonWaxingGibbous4, moonWaxingGibbous5, moonWaxingGibbous6, moonrise, moonset, na, nightAltCloudy, nightAltCloudyGusts, nightAltCloudyHigh, nightAltCloudyWindy, nightAltHail, nightAltLightning, nightAltPartlyCloudy, nightAltRain, nightAltRainMix, nightAltRainWind, nightAltShowers, nightAltSleet, nightAltSleetStorm, nightAltSnow, nightAltSnowThunderstorm, nightAltSnowWind, nightAltSprinkle, nightAltStormShowers, nightAltThunderstorm, nightClear, nightCloudy, nightCloudyGusts, nightCloudyHigh, nightCloudyWindy, nightFog, nightHail, nightLightning, nightPartlyCloudy, nightRain, nightRainMix, nightRainWind, nightShowers, nightSleet, nightSleetStorm, nightSnow, nightSnowThunderstorm, nightSnowWind, nightSprinkle, nightStormShowers, nightThunderstorm, owm200, owm201, owm202, owm210, owm211, owm212, owm221, owm230, owm231, owm232, owm300, owm301, owm302, owm310, owm311, owm312, owm313, owm314, owm321, owm500, owm501, owm502, owm503, owm504, owm511, owm520, owm521, owm522, owm531, owm600, owm601, owm602, owm611, owm612, owm615, owm616, owm620, owm621, owm622, owm701, owm711, owm721, owm731, owm741, owm761, owm762, owm771, owm781, owm800, owm801, owm802, owm803, owm804, owm900, owm901, owm902, owm903, owm904, owm905, owm906, owm957, owmDay200, owmDay201, owmDay202, owmDay210, owmDay211, owmDay212, owmDay221, owmDay230, owmDay231, owmDay232, owmDay300, owmDay301, owmDay302, owmDay310, owmDay311, owmDay312, owmDay313, owmDay314, owmDay321, owmDay500, owmDay501, owmDay502, owmDay503, owmDay504, owmDay511, owmDay520, owmDay521, owmDay522, owmDay531, owmDay600, owmDay601, owmDay602, owmDay611, owmDay612, owmDay615, owmDay616, owmDay620, owmDay621, owmDay622, owmDay701, owmDay711, owmDay721, owmDay731, owmDay741, owmDay761, owmDay762, owmDay781, owmDay800, owmDay801, owmDay802, owmDay803, owmDay804, owmDay900, owmDay902, owmDay903, owmDay904, owmDay906, owmDay957, owmNight200, owmNight201, owmNight202, owmNight210, owmNight211, owmNight212, owmNight221, owmNight230, owmNight231, owmNight232, owmNight300, owmNight301, owmNight302, owmNight310, owmNight311, owmNight312, owmNight313, owmNight314, owmNight321, owmNight500, owmNight501, owmNight502, owmNight503, owmNight504, owmNight511, owmNight520, owmNight521, owmNight522, owmNight531, owmNight600, owmNight601, owmNight602, owmNight611, owmNight612, owmNight615, owmNight616, owmNight620, owmNight621, owmNight622, owmNight701, owmNight711, owmNight721, owmNight731, owmNight741, owmNight761, owmNight762, owmNight781, owmNight800, owmNight801, owmNight802, owmNight803, owmNight804, owmNight900, owmNight902, owmNight903, owmNight904, owmNight906, owmNight957, rain, rainMix, rainWind, raindrop, raindrops, refresh, refreshAlt, sandstorm, showers, sleet, smallCraftAdvisory, smog, smoke, snow, snowWind, snowflakeCold, solarEclipse, sprinkle, stars, stormShowers, stormWarning, strongWind, sunrise, sunset, thermometer, thermometerExterior, thermometerInternal, thunderstorm, time1, time10, time11, time12, time2, time3, time4, time5, time6, time7, time8, time9, tornado, train, tsunami, umbrella, volcano, windBeaufort0, windBeaufort1, windBeaufort10, windBeaufort11, windBeaufort12, windBeaufort2, windBeaufort3, windBeaufort4, windBeaufort5, windBeaufort6, windBeaufort7, windBeaufort8, windBeaufort9, windDirection, windy, wmo46800, wmo468000, wmo468001, wmo468002, wmo468003, wmo468004, wmo468005, wmo46801, wmo468010, wmo468011, wmo468012, wmo468018, wmo46802, wmo468020, wmo468021, wmo468022, wmo468023, wmo468024, wmo468025, wmo468026, wmo468027, wmo468028, wmo468029, wmo46803, wmo468030, wmo468031, wmo468032, wmo468033, wmo468034, wmo468035, wmo46804, wmo468040, wmo468041, wmo468042, wmo468043, wmo468044, wmo468045, wmo468046, wmo468047, wmo468048, wmo46805, wmo468050, wmo468051, wmo468052, wmo468053, wmo468054, wmo468055, wmo468056, wmo468057, wmo468058, wmo468060, wmo468061, wmo468062, wmo468063, wmo468064, wmo468065, wmo468066, wmo468067, wmo468068, wmo468070, wmo468071, wmo468072, wmo468073, wmo468074, wmo468075, wmo468076, wmo468077, wmo468078, wmo468080, wmo468081, wmo468082, wmo468083, wmo468084, wmo468085, wmo468086, wmo468087, wmo468089, wmo468090, wmo468091, wmo468092, wmo468093, wmo468094, wmo468095, wmo468096, wmo468099, wuChanceflurries, wuChancerain, wuChancesleat, wuChancesnow, wuChancetstorms, wuClear, wuCloudy, wuFlurries, wuHazy, wuMostlycloudy, wuMostlysunny, wuPartlycloudy, wuPartlysunny, wuRain, wuSleat, wuSnow, wuSunny, wuTstorms, wuUnknown, yahoo0, yahoo1, yahoo10, yahoo11, yahoo12, yahoo13, yahoo14, yahoo15, yahoo16, yahoo17, yahoo18, yahoo19, yahoo2, yahoo20, yahoo21, yahoo22, yahoo23, yahoo24, yahoo25, yahoo26, yahoo27, yahoo28, yahoo29, yahoo3, yahoo30, yahoo31, yahoo32, yahoo3200, yahoo33, yahoo34, yahoo35, yahoo36, yahoo37, yahoo38, yahoo39, yahoo4, yahoo40, yahoo41, yahoo42, yahoo43, yahoo44, yahoo45, yahoo46, yahoo47, yahoo5, yahoo6, yahoo7, yahoo8, yahoo9
}

private let weatherIcons = ["\u{f075}", "\u{f079}", "\u{f03c}", "\u{f041}", "\u{f03d}", "\u{f03e}", "\u{f040}", "\u{f013}", "\u{f011}", "\u{f012}", "\u{f002}", "\u{f000}", "\u{f07d}", "\u{f001}", "\u{f003}", "\u{f004}", "\u{f0b6}", "\u{f0c4}", "\u{f005}", "\u{f008}", "\u{f006}", "\u{f007}", "\u{f009}", "\u{f0b2}", "\u{f068}", "\u{f00a}", "\u{f06b}", "\u{f065}", "\u{f00b}", "\u{f00e}", "\u{f00d}", "\u{f00c}", "\u{f010}", "\u{f085}", "\u{f042}", "\u{f044}", "\u{f043}", "\u{f088}", "\u{f048}", "\u{f04d}", "\u{f058}", "\u{f087}", "\u{f057}", "\u{f063}", "\u{f0c6}", "\u{f045}", "\u{f0c7}", "\u{f07c}", "\u{f014}", "\u{f00d}", "\u{f02e}", "\u{f013}", "\u{f014}", "\u{f015}", "\u{f002}", "\u{f031}", "\u{f019}", "\u{f0b5}", "\u{f01b}", "\u{f01e}", "\u{f056}", "\u{f050}", "\u{f0cd}", "\u{f015}", "\u{f047}", "\u{f046}", "\u{f072}", "\u{f07a}", "\u{f073}", "\u{f0cf}", "\u{f016}", "\u{f070}", "\u{f071}", "\u{f095}", "\u{f096}", "\u{f09f}", "\u{f0a0}", "\u{f0a1}", "\u{f0a2}", "\u{f0a3}", "\u{f0a4}", "\u{f0a5}", "\u{f0a6}", "\u{f0a7}", "\u{f0a8}", "\u{f097}", "\u{f0a9}", "\u{f0aa}", "\u{f0ab}", "\u{f0ac}", "\u{f0ad}", "\u{f0ae}", "\u{f0af}", "\u{f0b0}", "\u{f098}", "\u{f099}", "\u{f09a}", "\u{f09b}", "\u{f09c}", "\u{f09d}", "\u{f09e}", "\u{f0d6}", "\u{f0dd}", "\u{f0eb}", "\u{f0e4}", "\u{f0e5}", "\u{f0e6}", "\u{f0e7}", "\u{f0e8}", "\u{f0e9}", "\u{f0ea}", "\u{f0de}", "\u{f0df}", "\u{f0e0}", "\u{f0e1}", "\u{f0e2}", "\u{f0e3}", "\u{f0d0}", "\u{f0d1}", "\u{f0d2}", "\u{f0d3}", "\u{f0d4}", "\u{f0d5}", "\u{f0d7}", "\u{f0d8}", "\u{f0d9}", "\u{f0da}", "\u{f0db}", "\u{f0dc}", "\u{f09c}", "\u{f0a3}", "\u{f095}", "\u{f0aa}", "\u{f0ab}", "\u{f0ac}", "\u{f0ad}", "\u{f0ae}", "\u{f0af}", "\u{f0b0}", "\u{f0a4}", "\u{f0a5}", "\u{f0a6}", "\u{f0a7}", "\u{f0a8}", "\u{f0a9}", "\u{f096}", "\u{f097}", "\u{f098}", "\u{f099}", "\u{f09a}", "\u{f09b}", "\u{f09d}", "\u{f09e}", "\u{f09f}", "\u{f0a0}", "\u{f0a1}", "\u{f0a2}", "\u{f0c9}", "\u{f0ca}", "\u{f07b}", "\u{f086}", "\u{f022}", "\u{f07e}", "\u{f023}", "\u{f024}", "\u{f025}", "\u{f081}", "\u{f028}", "\u{f026}", "\u{f027}", "\u{f029}", "\u{f0b4}", "\u{f06a}", "\u{f02a}", "\u{f06d}", "\u{f067}", "\u{f02b}", "\u{f02c}", "\u{f02d}", "\u{f02e}", "\u{f031}", "\u{f02f}", "\u{f080}", "\u{f030}", "\u{f04a}", "\u{f032}", "\u{f033}", "\u{f083}", "\u{f036}", "\u{f034}", "\u{f035}", "\u{f037}", "\u{f0b3}", "\u{f069}", "\u{f038}", "\u{f06c}", "\u{f066}", "\u{f039}", "\u{f03a}", "\u{f03b}", "\u{f01e}", "\u{f01e}", "\u{f01e}", "\u{f016}", "\u{f016}", "\u{f016}", "\u{f016}", "\u{f01e}", "\u{f01e}", "\u{f01e}", "\u{f01c}", "\u{f01c}", "\u{f019}", "\u{f017}", "\u{f019}", "\u{f019}", "\u{f01a}", "\u{f019}", "\u{f01c}", "\u{f01c}", "\u{f019}", "\u{f019}", "\u{f019}", "\u{f019}", "\u{f017}", "\u{f01a}", "\u{f01a}", "\u{f01a}", "\u{f01d}", "\u{f01b}", "\u{f01b}", "\u{f0b5}", "\u{f017}", "\u{f017}", "\u{f017}", "\u{f017}", "\u{f017}", "\u{f01b}", "\u{f01b}", "\u{f01a}", "\u{f062}", "\u{f0b6}", "\u{f063}", "\u{f014}", "\u{f063}", "\u{f063}", "\u{f011}", "\u{f056}", "\u{f00d}", "\u{f011}", "\u{f011}", "\u{f012}", "\u{f013}", "\u{f056}", "\u{f01d}", "\u{f073}", "\u{f076}", "\u{f072}", "\u{f021}", "\u{f015}", "\u{f050}", "\u{f010}", "\u{f010}", "\u{f010}", "\u{f005}", "\u{f005}", "\u{f005}", "\u{f005}", "\u{f010}", "\u{f010}", "\u{f010}", "\u{f00b}", "\u{f00b}", "\u{f008}", "\u{f008}", "\u{f008}", "\u{f008}", "\u{f008}", "\u{f008}", "\u{f00b}", "\u{f00b}", "\u{f008}", "\u{f008}", "\u{f008}", "\u{f008}", "\u{f006}", "\u{f009}", "\u{f009}", "\u{f009}", "\u{f00e}", "\u{f00a}", "\u{f0b2}", "\u{f00a}", "\u{f006}", "\u{f006}", "\u{f006}", "\u{f006}", "\u{f006}", "\u{f00a}", "\u{f00a}", "\u{f009}", "\u{f062}", "\u{f0b6}", "\u{f063}", "\u{f003}", "\u{f063}", "\u{f063}", "\u{f056}", "\u{f00d}", "\u{f000}", "\u{f000}", "\u{f000}", "\u{f00c}", "\u{f056}", "\u{f073}", "\u{f076}", "\u{f072}", "\u{f004}", "\u{f050}", "\u{f02d}", "\u{f02d}", "\u{f02d}", "\u{f025}", "\u{f025}", "\u{f025}", "\u{f025}", "\u{f02d}", "\u{f02d}", "\u{f02d}", "\u{f02b}", "\u{f02b}", "\u{f028}", "\u{f028}", "\u{f028}", "\u{f028}", "\u{f028}", "\u{f028}", "\u{f02b}", "\u{f02b}", "\u{f028}", "\u{f028}", "\u{f028}", "\u{f028}", "\u{f026}", "\u{f029}", "\u{f029}", "\u{f029}", "\u{f02c}", "\u{f02a}", "\u{f0b4}", "\u{f02a}", "\u{f026}", "\u{f026}", "\u{f026}", "\u{f026}", "\u{f026}", "\u{f02a}", "\u{f02a}", "\u{f029}", "\u{f062}", "\u{f0b6}", "\u{f063}", "\u{f04a}", "\u{f063}", "\u{f063}", "\u{f056}", "\u{f02e}", "\u{f022}", "\u{f022}", "\u{f022}", "\u{f086}", "\u{f056}", "\u{f073}", "\u{f076}", "\u{f072}", "\u{f024}", "\u{f050}", "\u{f019}", "\u{f017}", "\u{f018}", "\u{f078}", "\u{f04e}", "\u{f04c}", "\u{f04b}", "\u{f082}", "\u{f01a}", "\u{f0b5}", "\u{f0cc}", "\u{f074}", "\u{f062}", "\u{f01b}", "\u{f064}", "\u{f076}", "\u{f06e}", "\u{f01c}", "\u{f077}", "\u{f01d}", "\u{f0ce}", "\u{f050}", "\u{f051}", "\u{f052}", "\u{f055}", "\u{f053}", "\u{f054}", "\u{f01e}", "\u{f08a}", "\u{f093}", "\u{f094}", "\u{f089}", "\u{f08b}", "\u{f08c}", "\u{f08d}", "\u{f08e}", "\u{f08f}", "\u{f090}", "\u{f091}", "\u{f092}", "\u{f056}", "\u{f0cb}", "\u{f0c5}", "\u{f084}", "\u{f0c8}", "\u{f0b7}", "\u{f0b8}", "\u{f0c1}", "\u{f0c2}", "\u{f0c3}", "\u{f0b9}", "\u{f0ba}", "\u{f0bb}", "\u{f0bc}", "\u{f0bd}", "\u{f0be}", "\u{f0bf}", "\u{f0c0}", "\u{f0b1}", "\u{f021}", "\u{f055}", "\u{f055}", "\u{f013}", "\u{f055}", "\u{f013}", "\u{f014}", "\u{f014}", "\u{f013}", "\u{f014}", "\u{f014}", "\u{f016}", "\u{f050}", "\u{f055}", "\u{f014}", "\u{f017}", "\u{f017}", "\u{f019}", "\u{f01b}", "\u{f015}", "\u{f01e}", "\u{f063}", "\u{f063}", "\u{f063}", "\u{f013}", "\u{f014}", "\u{f014}", "\u{f014}", "\u{f014}", "\u{f014}", "\u{f014}", "\u{f014}", "\u{f017}", "\u{f01c}", "\u{f019}", "\u{f01c}", "\u{f019}", "\u{f015}", "\u{f015}", "\u{f01b}", "\u{f01b}", "\u{f014}", "\u{f01c}", "\u{f01c}", "\u{f019}", "\u{f019}", "\u{f076}", "\u{f076}", "\u{f076}", "\u{f01c}", "\u{f019}", "\u{f01c}", "\u{f01c}", "\u{f019}", "\u{f019}", "\u{f015}", "\u{f015}", "\u{f015}", "\u{f017}", "\u{f017}", "\u{f01b}", "\u{f01b}", "\u{f01b}", "\u{f01b}", "\u{f076}", "\u{f076}", "\u{f076}", "\u{f01b}", "\u{f076}", "\u{f019}", "\u{f01c}", "\u{f019}", "\u{f019}", "\u{f01d}", "\u{f017}", "\u{f017}", "\u{f017}", "\u{f015}", "\u{f016}", "\u{f01d}", "\u{f01e}", "\u{f01e}", "\u{f016}", "\u{f01e}", "\u{f01e}", "\u{f056}", "\u{f064}", "\u{f019}", "\u{f0b5}", "\u{f01b}", "\u{f01e}", "\u{f00d}", "\u{f002}", "\u{f064}", "\u{f0b6}", "\u{f002}", "\u{f00d}", "\u{f002}", "\u{f00d}", "\u{f01a}", "\u{f0b5}", "\u{f01b}", "\u{f00d}", "\u{f01e}", "\u{f00d}", "\u{f056}", "\u{f00e}", "\u{f015}", "\u{f01a}", "\u{f01a}", "\u{f01b}", "\u{f00a}", "\u{f064}", "\u{f01b}", "\u{f015}", "\u{f017}", "\u{f063}", "\u{f073}", "\u{f014}", "\u{f021}", "\u{f062}", "\u{f050}", "\u{f050}", "\u{f076}", "\u{f013}", "\u{f031}", "\u{f002}", "\u{f031}", "\u{f01e}", "\u{f002}", "\u{f02e}", "\u{f00d}", "\u{f077}", "\u{f083}", "\u{f00c}", "\u{f017}", "\u{f072}", "\u{f00e}", "\u{f00e}", "\u{f00e}", "\u{f01e}", "\u{f01a}", "\u{f064}", "\u{f01b}", "\u{f064}", "\u{f00c}", "\u{f00e}", "\u{f01b}", "\u{f00e}", "\u{f017}", "\u{f017}", "\u{f017}", "\u{f015}", "\u{f01a}"]
