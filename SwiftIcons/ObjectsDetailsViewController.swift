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

class ObjectsDetailsViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    var index: Int!
    var textColors = ["e74c3c", "e67e22", "f1c40f", "2ecc71", "1abc9c", "3498db", "9b59b6", "E4ACCF", "95a5a6", "34495e", "6c6998"]
    var objects = ["UIImage", "UIImageView", "UILabel", "UIButton", "UISegmentedControl", "UITabBarItem", "UISlider", "UIBarButtonItem", "UIViewController", "UITextField", "UIStepper"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let textColor = UIColor.init(hex: textColors[index!])
        
        let font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        let font1 = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        let font2 = UIFont(name: "AppleSDGothicNeo-Thin", size: 12)

        let attributes = [NSFontAttributeName : font!, NSForegroundColorAttributeName: textColor]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.title = objects[index!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(goBack(sender:)))
        navigationItem.leftBarButtonItem?.setIcon(icon: .fontAwesome(.arrowLeft), iconSize: 30, color: textColor)
        
        switch index! {
        case 0:
            let imageView1 = UIImageView(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            let image1 = UIImage.init(icon: .emoji(.airplane), size: imageView1.frame.size)
            imageView1.image = image1
            
            let imageView2 = UIImageView(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            let image2 = UIImage.init(icon: .emoji(.airplane), size: imageView2.frame.size, textColor: textColor)
            imageView2.image = image2

            let imageView3 = UIImageView(frame: CGRect(x: 20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            let image3 = UIImage.init(icon: .emoji(.airplane), size: imageView3.frame.size, textColor: .white, backgroundColor: textColor)
            imageView3.image = image3

            let imageView4 = UIImageView(frame: CGRect(x: screenWidth/2+20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            let image4 = UIImage.init(bgIcon: .fontAwesome(.circleO), topIcon: .fontAwesome(.squareO))
            imageView4.image = image4

            let imageView5 = UIImageView(frame: CGRect(x: 20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            let image5 = UIImage.init(bgIcon: .fontAwesome(.camera), topIcon: .fontAwesome(.ban), topTextColor: textColor, bgLarge: false)
            imageView5.image = image5

            scrollView.addSubview(imageView1)
            scrollView.addSubview(imageView2)
            scrollView.addSubview(imageView3)
            scrollView.addSubview(imageView4)
            scrollView.addSubview(imageView5)

            scrollView.contentSize = CGSize(width: screenWidth, height: 3*screenWidth/2-40)
            break
            
        case 1:
            let imageView1 = UIImageView(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            imageView1.setIcon(icon: .weather(.rainMix))
            
            let imageView2 = UIImageView(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            imageView2.setIcon(icon: .mapicons(.amusementPark), textColor: .white, backgroundColor: textColor, size: nil)
            
            scrollView.addSubview(imageView1)
            scrollView.addSubview(imageView2)
            break
            
        case 2:
            let label1 = UILabel(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            label1.setIcon(icon: .ionicons(.paintbrush), iconSize: 70)
            
            let label2 = UILabel(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            label2.setIcon(icon: .googleMaterialDesign(.rowing), iconSize: 70, color: .white, bgColor: textColor)

            let label3 = UILabel(frame: CGRect(x: 20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            label3.setIcon(prefixText: "Bus ", icon: .linearIcons(.bus), postfixText: " icon", size: 20)

            let label4 = UILabel(frame: CGRect(x: screenWidth/2+20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            label4.setIcon(prefixText: "Medal ", prefixTextColor: textColor, icon: .ionicons(.ribbonA), iconColor: textColor, postfixText: "", postfixTextColor: textColor, size: nil, iconSize: 40)
            
            let label5 = UILabel(frame: CGRect(x: 20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            label5.setIcon(prefixText: "Font ", prefixTextFont: font1!, icon: .fontAwesome(.font), postfixText: " icon", postfixTextFont: font2!)
            
            let label6 = UILabel(frame: CGRect(x: screenWidth/2+20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            label6.setIcon(prefixText: "Bike ", prefixTextFont: font1!, prefixTextColor: .red, icon: .mapicons(.bicycling), iconColor: textColor, postfixText: " icon", postfixTextFont: font2!, postfixTextColor: .blue, iconSize: 30)

            scrollView.addSubview(label1)
            scrollView.addSubview(label2)
            scrollView.addSubview(label3)
            scrollView.addSubview(label4)
            scrollView.addSubview(label5)
            scrollView.addSubview(label6)
            
            scrollView.contentSize = CGSize(width: screenWidth, height: 3*screenWidth/2-40)
            break
           
        case 3:
            let button1 = UIButton(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            button1.setIcon(icon: .linearIcons(.phone), forState: .normal)

            let button2 = UIButton(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            button2.setIcon(icon: .openIconic(.clipboard), iconSize: 70, color: textColor, backgroundColor: .blue, forState: .normal)

            let button3 = UIButton(frame: CGRect(x: 20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            button3.setIcon(prefixText: "Please ", icon: .googleMaterialDesign(.print), postfixText: " print", forState: .normal)
            
            let button4 = UIButton(frame: CGRect(x: screenWidth/2+20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            button4.setIcon(prefixText: "Happy ", prefixTextFont: font1!, icon: .ionicons(.happy), postfixText: " face", postfixTextFont: font2!, forState: .normal)

            let button5 = UIButton(frame: CGRect(x: 20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            button5.setIcon(prefixText: "Lock ", prefixTextColor: .red, icon: .googleMaterialDesign(.lock), iconColor: textColor, postfixText: " icon", postfixTextColor: .blue, backgroundColor: .yellow, forState: .normal, textSize: 15, iconSize: 20)
            
            let button6 = UIButton(frame: CGRect(x: screenWidth/2+20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            button6.setIcon(prefixText: "Pulse ", prefixTextFont: font1!, prefixTextColor: .darkGray, icon: .openIconic(.pulse), iconColor: textColor, postfixText: " icon", postfixTextFont: font2!, postfixTextColor: .purple, forState: .normal, iconSize: 40)
            
            scrollView.addSubview(button1)
            scrollView.addSubview(button2)
            scrollView.addSubview(button3)
            scrollView.addSubview(button4)
            scrollView.addSubview(button5)
            scrollView.addSubview(button6)
            
            scrollView.contentSize = CGSize(width: screenWidth, height: 3*screenWidth/2-40)
            break
            
        case 4:
            let items = ["", ""]
            let segmentedControl1 = UISegmentedControl(items: items)
            segmentedControl1.frame = CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40)
            segmentedControl1.selectedSegmentIndex = 0
            segmentedControl1.setIcon(icon: .linearIcons(.thumbsUp), forSegmentAtIndex: 0)
            segmentedControl1.setIcon(icon: .linearIcons(.thumbsDown), forSegmentAtIndex: 1)

            let segmentedControl2 = UISegmentedControl(items: items)
            segmentedControl2.frame = CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40)
            segmentedControl2.selectedSegmentIndex = 0
            segmentedControl2.setIcon(icon: .fontAwesome(.male), color: textColor, iconSize: 50, forSegmentAtIndex: 0)
            segmentedControl2.setIcon(icon: .fontAwesome(.female), color: textColor, iconSize: 50, forSegmentAtIndex: 1)

            scrollView.addSubview(segmentedControl1)
            scrollView.addSubview(segmentedControl2)
            break
            
        case 5:            
            break
            
        case 6:
            let slider1 = UISlider(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: 40))
            slider1.setMaximumValueIcon(icon: .emoji(.digitNine))
            slider1.setMinimumValueIcon(icon: .emoji(.digitZero))
            
            let slider2 = UISlider(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: 40))
            slider2.setMaximumValueIcon(icon: .mapicons(.female), customSize: nil)
            slider2.setMinimumValueIcon(icon: .mapicons(.male), customSize: nil)
            
            let slider3 = UISlider(frame: CGRect(x: 20, y: 80, width: screenWidth-40, height: 40))
            slider3.setMaximumValueIcon(icon: .linearIcons(.pointerUp), customSize: nil, textColor: textColor, backgroundColor: .clear)
            slider3.setMinimumValueIcon(icon: .linearIcons(.pointerDown), customSize: nil, textColor: textColor, backgroundColor: .clear)
            
            scrollView.addSubview(slider1)
            scrollView.addSubview(slider2)
            scrollView.addSubview(slider3)
            break
            
        case 7:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(barButtonItem(sender:)))
            navigationItem.rightBarButtonItem?.setIcon(icon: .ionicons(.iosFootball), iconSize: 30, color: textColor)
            break
        
        case 8:
            self.setTitleIcon(icon: .emoji(.animalHorse), iconSize: 30, color: textColor)
            
            break
        case 9:
            let textfield1 = UITextField(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: 40))
            textfield1.bottomBorder(textColor)
            textfield1.setLeftViewIcon(icon: .fontAwesome(.search))
            
            let textfield2 = UITextField(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: 40))
            textfield2.bottomBorder(textColor)
            textfield2.setRightViewIcon(icon: .openIconic(.questionMark))
            
            let textfield3 = UITextField(frame: CGRect(x: 20, y: 80, width: screenWidth/2-40, height: 40))
            textfield3.bottomBorder(textColor)
            textfield3.setLeftViewIcon(icon: .state(.TX), leftViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)

            let textfield4 = UITextField(frame: CGRect(x: screenWidth/2+20, y: 80, width: screenWidth/2-40, height: 40))
            textfield4.bottomBorder(textColor)
            textfield4.setRightViewIcon(icon: .weather(.rainMix), rightViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)

            let textfield5 = UITextField(frame: CGRect(x: 20, y: 140, width: screenWidth/2-40, height: 40))
            textfield5.bottomBorder(textColor)
            textfield5.setLeftViewIcon(icon: .googleMaterialDesign(.plusOne), leftViewMode: .unlessEditing, textColor: textColor, backgroundColor: .clear, size: nil)

            let textfield6 = UITextField(frame: CGRect(x: screenWidth/2+20, y: 140, width: screenWidth/2-40, height: 40))
            textfield6.bottomBorder(textColor)
            textfield6.setLeftViewIcon(icon: .mapicons(.police), leftViewMode: .always, textColor: .blue, backgroundColor: .clear, size: nil)
            textfield6.setRightViewIcon(icon: .mapicons(.routePin), rightViewMode: .always, textColor: .purple, backgroundColor: .clear, size: nil)

            scrollView.addSubview(textfield1)
            scrollView.addSubview(textfield2)
            scrollView.addSubview(textfield3)
            scrollView.addSubview(textfield4)
            scrollView.addSubview(textfield5)
            scrollView.addSubview(textfield6)
            
            scrollView.contentSize = CGSize(width: screenWidth, height: 3*screenWidth/2-40)
            break
        case 10:
            let stepper1 = UIStepper(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: 40))
            stepper1.setDecrementIcon(icon: .ionicons(.iosPause), forState: .normal)
            stepper1.setIncrementIcon(icon: .ionicons(.iosPlay), forState: .normal)
            
            scrollView.addSubview(stepper1)
            break
        
        default:
            break
        }
    }
    
    // MARK: - Navigation
    func goBack(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func barButtonItem(sender: UIBarButtonItem) {
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
