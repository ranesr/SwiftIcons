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

class ObjectsDetailsViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    var index: Int!
    var textColors = ["e74c3c", "e67e22", "f1c40f", "2ecc71", "1abc9c", "3498db", "9b59b6", "e4Accf", "95a5a6", "34495e", "6c6998"]
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

        let attributes = [NSAttributedStringKey.font : font!, NSAttributedStringKey.foregroundColor: textColor]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.title = objects[index!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(goBack(sender:)))
        navigationItem.leftBarButtonItem?.setIcon(icon: .fontAwesomeSolid(.longArrowAltLeft), iconSize: 30, color: textColor)
        
        switch index! {
        case 0:
            let imageView1 = UIImageView(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            let image1 = UIImage.init(icon: .emoji(.airplane), size: imageView1.frame.size)
            imageView1.image = image1
            imageView1.isUserInteractionEnabled = true
            imageView1.tag = 1
            let tap01 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            imageView1.addGestureRecognizer(tap01)
            
            let imageView2 = UIImageView(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            let image2 = UIImage.init(icon: .emoji(.airplane), size: imageView2.frame.size, textColor: textColor)
            imageView2.image = image2
            imageView2.isUserInteractionEnabled = true
            imageView2.tag = 2
            let tap02 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            imageView2.addGestureRecognizer(tap02)

            let imageView3 = UIImageView(frame: CGRect(x: 20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            let image3 = UIImage.init(icon: .emoji(.airplane), size: imageView3.frame.size, textColor: .white, backgroundColor: textColor)
            imageView3.image = image3
            imageView3.isUserInteractionEnabled = true
            imageView3.tag = 3
            let tap03 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            imageView3.addGestureRecognizer(tap03)

            let imageView4 = UIImageView(frame: CGRect(x: screenWidth/2+20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            let image4 = UIImage.init(bgIcon: .fontAwesomeRegular(.circle), topIcon: .fontAwesomeRegular(.square))
            imageView4.image = image4
            imageView4.isUserInteractionEnabled = true
            imageView4.tag = 4
            let tap04 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            imageView4.addGestureRecognizer(tap04)

            let imageView5 = UIImageView(frame: CGRect(x: 20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            let image5 = UIImage.init(bgIcon: .fontAwesomeSolid(.cameraRetro), topIcon: .fontAwesomeSolid(.ban), topTextColor: textColor, bgLarge: false)
            imageView5.image = image5
            imageView5.isUserInteractionEnabled = true
            imageView5.tag = 5
            let tap05 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            imageView5.addGestureRecognizer(tap05)

            scrollView.addSubview(imageView1)
            scrollView.addSubview(imageView2)
            scrollView.addSubview(imageView3)
            scrollView.addSubview(imageView4)
            scrollView.addSubview(imageView5)

            scrollView.contentSize = CGSize(width: screenWidth, height: 3*screenWidth/2-40)
            
        case 1:
            let imageView1 = UIImageView(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            imageView1.setIcon(icon: .weather(.rainMix))
            imageView1.isUserInteractionEnabled = true
            imageView1.tag = 11
            let tap11 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            imageView1.addGestureRecognizer(tap11)
            
            let imageView2 = UIImageView(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            imageView2.setIcon(icon: .mapicons(.amusementPark), textColor: .white, backgroundColor: textColor, size: nil)
            imageView2.isUserInteractionEnabled = true
            imageView2.tag = 12
            let tap12 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            imageView2.addGestureRecognizer(tap12)
            
            scrollView.addSubview(imageView1)
            scrollView.addSubview(imageView2)
            
        case 2:
            let label1 = UILabel(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            label1.setIcon(icon: .ionicons(.paintbrush), iconSize: 70)
            label1.isUserInteractionEnabled = true
            label1.tag = 21
            let tap21 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            label1.addGestureRecognizer(tap21)
            
            let label2 = UILabel(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            label2.setIcon(icon: .googleMaterialDesign(.rowing), iconSize: 70, color: .white, bgColor: textColor)
            label2.isUserInteractionEnabled = true
            label2.tag = 22
            let tap22 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            label2.addGestureRecognizer(tap22)

            let label3 = UILabel(frame: CGRect(x: 20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            label3.setIcon(prefixText: "Bus ", icon: .linearIcons(.bus), postfixText: " icon", size: 20)
            label3.isUserInteractionEnabled = true
            label3.tag = 23
            let tap23 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            label3.addGestureRecognizer(tap23)

            let label4 = UILabel(frame: CGRect(x: screenWidth/2+20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            label4.setIcon(prefixText: "Medal ", prefixTextColor: textColor, icon: .ionicons(.ribbonA), iconColor: textColor, postfixText: "", postfixTextColor: textColor, size: nil, iconSize: 40)
            label4.isUserInteractionEnabled = true
            label4.tag = 24
            let tap24 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            label4.addGestureRecognizer(tap24)
            
            let label5 = UILabel(frame: CGRect(x: 20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            label5.setIcon(prefixText: "Font ", prefixTextFont: font1!, icon: .fontAwesomeSolid(.font), postfixText: " icon", postfixTextFont: font2!)
            label5.isUserInteractionEnabled = true
            label5.tag = 25
            let tap25 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            label5.addGestureRecognizer(tap25)
            
            let label6 = UILabel(frame: CGRect(x: screenWidth/2+20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            label6.setIcon(prefixText: "Bike ", prefixTextFont: font1!, prefixTextColor: .red, icon: .mapicons(.bicycling), iconColor: textColor, postfixText: " icon", postfixTextFont: font2!, postfixTextColor: .blue, iconSize: 30)
            label6.isUserInteractionEnabled = true
            label6.tag = 26
            let tap26 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            label6.addGestureRecognizer(tap26)

            scrollView.addSubview(label1)
            scrollView.addSubview(label2)
            scrollView.addSubview(label3)
            scrollView.addSubview(label4)
            scrollView.addSubview(label5)
            scrollView.addSubview(label6)
            
            scrollView.contentSize = CGSize(width: screenWidth, height: 3*screenWidth/2-40)
           
        case 3:
            let button1 = UIButton(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            button1.setIcon(icon: .linearIcons(.phone), forState: .normal)
            button1.isUserInteractionEnabled = true
            button1.tag = 31
            let tap31 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            button1.addGestureRecognizer(tap31)

            let button2 = UIButton(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40))
            button2.setIcon(icon: .openIconic(.clipboard), iconSize: 70, color: textColor, backgroundColor: .blue, forState: .normal)
            button2.isUserInteractionEnabled = true
            button2.tag = 32
            let tap32 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            button2.addGestureRecognizer(tap32)

            let button3 = UIButton(frame: CGRect(x: 20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            button3.setIcon(prefixText: "Please ", icon: .googleMaterialDesign(.print), postfixText: " print", forState: .normal)
            button3.isUserInteractionEnabled = true
            button3.tag = 33
            let tap33 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            button3.addGestureRecognizer(tap33)
            
            let button4 = UIButton(frame: CGRect(x: screenWidth/2+20, y: screenWidth/2, width: screenWidth/2-40, height: screenWidth/2-40))
            button4.setIcon(prefixText: "Happy ", prefixTextFont: font1!, icon: .ionicons(.happy), postfixText: " face", postfixTextFont: font2!, forState: .normal)
            button4.isUserInteractionEnabled = true
            button4.tag = 34
            let tap34 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            button4.addGestureRecognizer(tap34)

            let button5 = UIButton(frame: CGRect(x: 20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            button5.setIcon(prefixText: "Lock ", prefixTextColor: .red, icon: .googleMaterialDesign(.lock), iconColor: textColor, postfixText: " icon", postfixTextColor: .blue, backgroundColor: .yellow, forState: .normal, textSize: 15, iconSize: 20)
            button5.isUserInteractionEnabled = true
            button5.tag = 35
            let tap35 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            button5.addGestureRecognizer(tap35)
            
            let button6 = UIButton(frame: CGRect(x: screenWidth/2+20, y: screenWidth-20, width: screenWidth/2-40, height: screenWidth/2-40))
            button6.setIcon(prefixText: "Pulse ", prefixTextFont: font1!, prefixTextColor: .darkGray, icon: .openIconic(.pulse), iconColor: textColor, postfixText: " icon", postfixTextFont: font2!, postfixTextColor: .purple, forState: .normal, iconSize: 40)
            button6.isUserInteractionEnabled = true
            button6.tag = 36
            let tap36 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            button6.addGestureRecognizer(tap36)

            let button7 = UIButton(frame: CGRect(x: 20, y: 3*screenWidth/2-40, width: screenWidth/2-40, height: screenWidth/2-80))
            button7.setIcon(icon: .emoji(.ferrisWheel), title: "Ferris Wheel", color: textColor, forState: .normal)
            button7.isUserInteractionEnabled = true
            button7.tag = 37
            let tap37 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            button7.addGestureRecognizer(tap37)

            let button8 = UIButton(frame: CGRect(x: screenWidth/2+50, y: 3*screenWidth/2-40, width: screenWidth/2-100, height: screenWidth/2-80))
            button8.setIcon(icon: .weather(.rainMix), iconColor: textColor, title: "RAIN MIX", titleColor: .red, font: font!, backgroundColor: .clear, borderSize: 1, borderColor: textColor, forState: .normal)
            button8.isUserInteractionEnabled = true
            button8.tag = 38
            let tap38 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            button8.addGestureRecognizer(tap38)

            let button9 = UIButton(frame: CGRect(x: 20, y: 2*screenWidth-60, width: screenWidth/2-40, height: screenWidth/2-40))
            button9.setIcon(icon: .mapicons(.airport), iconColor: textColor, title: "AIRPLANE", font: font!, forState: .normal)
            button9.isUserInteractionEnabled = true
            button9.tag = 39
            let tap39 = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
            button9.addGestureRecognizer(tap39)

            scrollView.addSubview(button1)
            scrollView.addSubview(button2)
            scrollView.addSubview(button3)
            scrollView.addSubview(button4)
            scrollView.addSubview(button5)
            scrollView.addSubview(button6)
            scrollView.addSubview(button7)
            scrollView.addSubview(button8)
            scrollView.addSubview(button9)
            
            scrollView.contentSize = CGSize(width: screenWidth, height: 5*screenWidth/2-80)
            
        case 4:
            let items = ["", ""]
            let segmentedControl1 = UISegmentedControl(items: items)
            segmentedControl1.frame = CGRect(x: 20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40)
            segmentedControl1.selectedSegmentIndex = 0
            segmentedControl1.setIcon(icon: .linearIcons(.thumbsUp), forSegmentAtIndex: 0)
            segmentedControl1.setIcon(icon: .linearIcons(.thumbsDown), forSegmentAtIndex: 1)
            segmentedControl1.tag = 41
            segmentedControl1.addTarget(self, action: #selector(valueChanged), for: .valueChanged)

            let segmentedControl2 = UISegmentedControl(items: items)
            segmentedControl2.frame = CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: screenWidth/2-40)
            segmentedControl2.selectedSegmentIndex = 0
            segmentedControl2.setIcon(icon: .fontAwesomeSolid(.male), color: textColor, iconSize: 50, forSegmentAtIndex: 0)
            segmentedControl2.setIcon(icon: .fontAwesomeSolid(.female), color: textColor, iconSize: 50, forSegmentAtIndex: 1)
            segmentedControl2.tag = 42
            segmentedControl2.addTarget(self, action: #selector(valueChanged), for: .valueChanged)

            scrollView.addSubview(segmentedControl1)
            scrollView.addSubview(segmentedControl2)
            
        case 5:            
            print("")
            print("Example Usage")
            print("=============")
            print("tabBar.items?[0].setIcon(icon: .icofont(.font), size: nil, textColor: .lightGray)")
            print("tabBar.items?[1].setIcon(bgIcon: .fontAwesome(.circleThin), bgTextColor: .lightGray, topIcon: .fontAwesome(.squareO), topTextColor: .lightGray, bgLarge: true, size: nil)")
            print("tabBar.items?[2].setIcon(icon: .ionicons(.iosInformation), size: nil, textColor: .lightGray)")
            
        case 6:
            let slider1 = UISlider(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: 40))
            slider1.setMaximumValueIcon(icon: .emoji(.digitNine))
            slider1.setMinimumValueIcon(icon: .emoji(.digitZero))
            slider1.minimumValue = 0
            slider1.maximumValue = 100
            slider1.isContinuous = false
            slider1.tag = 61
            slider1.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            
            let slider2 = UISlider(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: 40))
            slider2.setMaximumValueIcon(icon: .mapicons(.female), customSize: nil)
            slider2.setMinimumValueIcon(icon: .mapicons(.male), customSize: nil)
            slider2.minimumValue = 0
            slider2.maximumValue = 100
            slider2.isContinuous = false
            slider2.tag = 62
            slider2.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            
            let slider3 = UISlider(frame: CGRect(x: 20, y: 80, width: screenWidth-40, height: 40))
            slider3.setMaximumValueIcon(icon: .linearIcons(.pointerUp), customSize: nil, textColor: textColor, backgroundColor: .clear)
            slider3.setMinimumValueIcon(icon: .linearIcons(.pointerDown), customSize: nil, textColor: textColor, backgroundColor: .clear)
            slider3.minimumValue = 0
            slider3.maximumValue = 100
            slider3.isContinuous = false
            slider3.tag = 63
            slider3.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            
            scrollView.addSubview(slider1)
            scrollView.addSubview(slider2)
            scrollView.addSubview(slider3)
            
        case 7:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(barButtonItem(sender:)))
            navigationItem.rightBarButtonItem?.setIcon(icon: .ionicons(.navicon), iconSize: 36, color: textColor, cgRect: CGRect(x: 30, y: 30, width: 30, height: 30), target: self, action: #selector(barButtonItem(sender:)))

            print("")
            print("Example Usage")
            print("=============")
            print("navigationItem.rightBarButtonItem?.setIcon(icon: .ionicons(.navicon), iconSize: 36, color: textColor, cgRect: CGRect(x: 30, y: 30, width: 30, height: 30), target: self, action: #selector(barButtonItem(sender:)))")

        
        case 8:
            self.setTitleIcon(icon: .emoji(.animalHorse), iconSize: 30, color: textColor)

            print("")
            print("Example Usage")
            print("=============")
            print("self.setTitleIcon(icon: .emoji(.animalHorse), iconSize: 30, color: textColor)")

        case 9:
            let textfield1 = UITextField(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: 40))
            textfield1.bottomBorder(textColor)
            textfield1.setLeftViewIcon(icon: .fontAwesomeSolid(.search))
            textfield1.tag = 91
            textfield1.addTarget(self, action: #selector(textFieldTouched), for: .editingDidBegin)
            
            let textfield2 = UITextField(frame: CGRect(x: screenWidth/2+20, y: 20, width: screenWidth/2-40, height: 40))
            textfield2.bottomBorder(textColor)
            textfield2.setRightViewIcon(icon: .openIconic(.questionMark))
            textfield2.tag = 92
            textfield2.addTarget(self, action: #selector(textFieldTouched), for: .editingDidBegin)
            
            let textfield3 = UITextField(frame: CGRect(x: 20, y: 80, width: screenWidth/2-40, height: 40))
            textfield3.bottomBorder(textColor)
            textfield3.setLeftViewIcon(icon: .state(.TX), leftViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)
            textfield3.tag = 93
            textfield3.addTarget(self, action: #selector(textFieldTouched), for: .editingDidBegin)

            let textfield4 = UITextField(frame: CGRect(x: screenWidth/2+20, y: 80, width: screenWidth/2-40, height: 40))
            textfield4.bottomBorder(textColor)
            textfield4.setRightViewIcon(icon: .weather(.rainMix), rightViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)
            textfield4.tag = 94
            textfield4.addTarget(self, action: #selector(textFieldTouched), for: .editingDidBegin)

            let textfield5 = UITextField(frame: CGRect(x: 20, y: 140, width: screenWidth/2-40, height: 40))
            textfield5.bottomBorder(textColor)
            textfield5.setLeftViewIcon(icon: .googleMaterialDesign(.plusOne), leftViewMode: .unlessEditing, textColor: textColor, backgroundColor: .clear, size: nil)
            textfield5.tag = 95
            textfield5.addTarget(self, action: #selector(textFieldTouched), for: .editingDidBegin)

            let textfield6 = UITextField(frame: CGRect(x: screenWidth/2+20, y: 140, width: screenWidth/2-40, height: 40))
            textfield6.bottomBorder(textColor)
            textfield6.setLeftViewIcon(icon: .mapicons(.police), leftViewMode: .always, textColor: .blue, backgroundColor: .clear, size: nil)
            textfield6.setRightViewIcon(icon: .mapicons(.routePin), rightViewMode: .always, textColor: .purple, backgroundColor: .clear, size: nil)
            textfield6.tag = 96
            textfield6.addTarget(self, action: #selector(textFieldTouched), for: .editingDidBegin)

            scrollView.addSubview(textfield1)
            scrollView.addSubview(textfield2)
            scrollView.addSubview(textfield3)
            scrollView.addSubview(textfield4)
            scrollView.addSubview(textfield5)
            scrollView.addSubview(textfield6)
            
            scrollView.contentSize = CGSize(width: screenWidth, height: 3*screenWidth/2-40)
        case 10:
            let stepper1 = UIStepper(frame: CGRect(x: 20, y: 20, width: screenWidth/2-40, height: 40))
            stepper1.setDecrementIcon(icon: .ionicons(.iosPause), forState: .normal)
            stepper1.setIncrementIcon(icon: .ionicons(.iosPlay), forState: .normal)
            stepper1.tag = 101
            stepper1.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
            
            scrollView.addSubview(stepper1)
        
        default:
            break
        }
    }
    
    // MARK: - Description Methods
    
    // UIStepper Methods
    @objc func stepperValueChanged(sender: UIStepper) {
        
        print("")
        print("Example Usage")
        print("=============")
        
        let currentValue = Int(sender.value)
        
        switch sender.tag {
        case 101:
            switch currentValue {
            case 1:
                print("stepper.setIncrementIcon(icon: .ionicons(.iosPlay), forState: .normal)")
            default:
                print("stepper.setDecrementIcon(icon: .ionicons(.iosPause), forState: .normal)")
            }
        default:
            print("Default")
        }
    }
    
    // UITextField Methods
    @objc func textFieldTouched(sender: UITextField) {
        print("")
        print("Example Usage")
        print("=============")
        
        switch sender.tag {
        case 91:
            print("textfield.setLeftViewIcon(icon: .fontAwesome(.search))")
        case 92:
            print("textfield.setRightViewIcon(icon: .openIconic(.questionMark))")
        case 93:
            print("textfield.setLeftViewIcon(icon: .state(.TX), leftViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)")
        case 94:
            print("textfield.setRightViewIcon(icon: .weather(.rainMix), rightViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)")
        case 95:
            print("textfield.setLeftViewIcon(icon: .googleMaterialDesign(.plusOne), leftViewMode: .unlessEditing, textColor: textColor, backgroundColor: .clear, size: nil)")
        case 96:
            print("textfield.setLeftViewIcon(icon: .mapicons(.police), leftViewMode: .always, textColor: .blue, backgroundColor: .clear, size: nil)")
            print("textfield.setRightViewIcon(icon: .mapicons(.routePin), rightViewMode: .always, textColor: .purple, backgroundColor: .clear, size: nil)")
        default:
            print("Default")
        }
    }
    
    // UISlider Methods
    @objc func sliderValueChanged(sender: UISlider) {
        print("")
        print("Example Usage")
        print("=============")
        let currentValue = Int(sender.value)
        
        switch sender.tag {
        case 61:
            switch currentValue {
            case 100:
                print("slider.setMaximumValueIcon(icon: .emoji(.digitNine))")
            default:
                print("slider.setMinimumValueIcon(icon: .emoji(.digitZero))")
            }
        case 62:
            switch currentValue {
            case 100:
                print("slider.setMaximumValueIcon(icon: .mapicons(.female), customSize: nil)")
            default:
                print("slider.setMinimumValueIcon(icon: .mapicons(.male), customSize: nil)")
            }
        case 63:
            switch currentValue {
            case 100:
                print("slider.setMaximumValueIcon(icon: .linearIcons(.pointerUp), customSize: nil, textColor: textColor, backgroundColor: .clear)")
            default:
                print("slider.setMinimumValueIcon(icon: .linearIcons(.pointerDown), customSize: nil, textColor: textColor, backgroundColor: .clear)")
            }
        default:
            print("Default")
        }
    }
    
    // UISegmentedControl Methods
    @objc func valueChanged(sender: UISegmentedControl) {
        
        print("")
        print("Example Usage")
        print("=============")
        
        switch sender.tag {
        case 41:
            switch sender.selectedSegmentIndex {
            case 1:
                print("segmentedControl.setIcon(icon: .linearIcons(.thumbsDown), forSegmentAtIndex: 1)")
            default:
                print("segmentedControl.setIcon(icon: .linearIcons(.thumbsUp), forSegmentAtIndex: 0)")
            }
        case 42:
            switch sender.selectedSegmentIndex {
            case 1:
                print("segmentedControl.setIcon(icon: .fontAwesome(.female), color: textColor, iconSize: 50, forSegmentAtIndex: 1)")
            default:
                print("segmentedControl.setIcon(icon: .fontAwesome(.male), color: textColor, iconSize: 50, forSegmentAtIndex: 0)")
            }
        default:
            print("Default")
        }
    }
    
    @objc func tapped(gesture: UIGestureRecognizer) {
        
        print("")
        print("Example Usage")
        print("=============")
        
        switch gesture.view!.tag {
            
        // UIImage Methods
        case 1:
            print("UIImage.init(icon: .emoji(.airplane), size: imageView.frame.size)")
        case 2:
            print("UIImage.init(icon: .emoji(.airplane), size: imageView.frame.size, textColor: textColor)")
        case 3:
            print("UIImage.init(icon: .emoji(.airplane), size: imageView.frame.size, textColor: .white, backgroundColor: textColor)")
        case 4:
            print("UIImage.init(bgIcon: .fontAwesome(.circleO), topIcon: .fontAwesome(.squareO))")
        case 5:
            print("UIImage.init(bgIcon: .fontAwesome(.camera), topIcon: .fontAwesome(.ban), topTextColor: textColor, bgLarge: false)")
            
        // UIImageView Methods
        case 11:
            print("imageView.setIcon(icon: .weather(.rainMix))")
        case 12:
            print("imageView.setIcon(icon: .mapicons(.amusementPark), textColor: .white, backgroundColor: textColor, size: nil)")
            
        // Label Methods
        case 21:
            print("label.setIcon(icon: .ionicons(.paintbrush), iconSize: 70)")
        case 22:
            print("label.setIcon(icon: .googleMaterialDesign(.rowing), iconSize: 70, color: .white, bgColor: textColor)")
        case 23:
            print("label.setIcon(prefixText: \"Bus \", icon: .linearIcons(.bus), postfixText: \" icon\", size: 20)")
        case 24:
            print("label.setIcon(prefixText: \"Medal \", prefixTextColor: textColor, icon: .ionicons(.ribbonA), iconColor: textColor, postfixText: \"\", postfixTextColor: textColor, size: nil, iconSize: 40)")
        case 25:
            print("label.setIcon(prefixText: \"Font \", prefixTextFont: font1!, icon: .fontAwesome(.font), postfixText: \" icon\", postfixTextFont: font2!)")
        case 26:
            print("label.setIcon(prefixText: \"Bike \", prefixTextFont: font1!, prefixTextColor: .red, icon: .mapicons(.bicycling), iconColor: textColor, postfixText: \" icon\", postfixTextFont: font2!, postfixTextColor: .blue, iconSize: 30)")
            
        // Button Methods
        case 31:
            print("button.setIcon(icon: .linearIcons(.phone), forState: .normal)")
        case 32:
            print("button.setIcon(icon: .openIconic(.clipboard), iconSize: 70, color: textColor, backgroundColor: .blue, forState: .normal)")
        case 33:
            print("button.setIcon(prefixText: \"Please \", icon: .googleMaterialDesign(.print), postfixText: \" print\", forState: .normal)")
        case 34:
            print("button.setIcon(prefixText: \"Happy \", prefixTextFont: font1!, icon: .ionicons(.happy), postfixText: \" face\", postfixTextFont: font2!, forState: .normal)")
        case 35:
            print("button.setIcon(prefixText: \"Lock \", prefixTextColor: .red, icon: .googleMaterialDesign(.lock), iconColor: textColor, postfixText: \" icon\", postfixTextColor: .blue, backgroundColor: .yellow, forState: .normal, textSize: 15, iconSize: 20)")
        case 36:
            print("button.setIcon(prefixText: \"Pulse \", prefixTextFont: font1!, prefixTextColor: .darkGray, icon: .openIconic(.pulse), iconColor: textColor, postfixText: \" icon\", postfixTextFont: font2!, postfixTextColor: .purple, forState: .normal, iconSize: 40)")
        case 37:
            print("button.setIcon(icon: .emoji(.ferrisWheel), title: \"Ferris Wheel\", color: textColor, forState: .normal)")
        case 38:
            print("button.setIcon(icon: .weather(.rainMix), iconColor: textColor, title: \"RAIN MIX\", titleColor: .red, font: font!, backgroundColor: .clear, borderSize: 1, borderColor: textColor, forState: .normal)")
        case 39:
            print("button.setIcon(icon: .mapicons(.airport), iconColor: textColor, title: \"AIRPLANE\", font: font!, forState: .normal)")
            
        default:
            print("Default")
        }
    }

    // MARK: - Navigation
    @objc func goBack(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func barButtonItem(sender: UIBarButtonItem) {
        print("")
        print("barButtonItem pressed.")
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
