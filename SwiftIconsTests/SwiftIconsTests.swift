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

import XCTest
@testable import SwiftIcons

class SwiftIconsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImageViewImage() {
        let view = UIImageView()
        view.setIcon(icon: .ionicons(.pizza))
        XCTAssertNotNil(view.image)
    }
    
    func testLabelFontShouldBeRegisted() {
        let label = UILabel()
        label.setIcon(icon: .emoji(.baby), iconSize: 20)
        XCTAssertNotNil(label.font, "Label Font Should Not Be Nil.")
    }
    
    func testLabelFontName() {
        let label = UILabel()
        label.setIcon(icon: .emoji(.baby), iconSize: 20)
        XCTAssertEqual(label.font.fontName, "emoji")
    }

    func testLabelText() {
        let label = UILabel()
        label.setIcon(icon: .icofont(.abacus), iconSize: 20)
        XCTAssertEqual(label.text, "\u{ecc1}")
    }
    
    func testButtonTitleLabelFontShouldBeRegisted() {
        let button = UIButton()
        button.setIcon(icon: .mapicons(.abseiling), forState: UIControl.State.normal)
        XCTAssertNotNil(button.titleLabel?.font, "Button Title Label Font Should Not Be Nil.")
    }
    
    func testButtonTitleText() {
        let button = UIButton()
        button.setIcon(icon: .googleMaterialDesign(.zoomOutMap), forState: UIControl.State.normal)
        XCTAssertEqual(button.titleLabel?.text, "\u{e56b}")
    }
    
    func testSegmentedControlTitleText() {
        let items = [""]
        let control = UISegmentedControl(items: items)
        control.setIcon(icon: .weather(.celsius), forSegmentAtIndex: 0)
        XCTAssertEqual(control.titleForSegment(at: 0), "\u{f03c}")
    }
    
    func testTabBarItemImages() {
        let tabBarItem = UITabBarItem()
        tabBarItem.setIcon(icon: .dripicon(.zoomOut))
        XCTAssertNotNil(tabBarItem.image)
        XCTAssertNotNil(tabBarItem.selectedImage)
    }
    
    func testSliderImages() {
        let slider = UISlider()
        slider.setMaximumValueIcon(icon: .fontAwesomeRegular(.addressBook))
        slider.setMinimumValueIcon(icon: .state(.TX))
        XCTAssertNotNil(slider.maximumValueImage)
        XCTAssertNotNil(slider.minimumValueImage)
    }
    
    func testBarButtonItemTitleText() {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.setIcon(icon: .dripicon(.alarm), iconSize: 20)
        XCTAssertEqual(barButtonItem.title, "\u{61}")
    }
    
    func testStepperImages() {
        let stepper = UIStepper()
        stepper.setIncrementIcon(icon: .weather(.celsius), forState: UIControl.State.normal)
        stepper.setDecrementIcon(icon: .linearIcons(.arrowDown), forState: UIControl.State.normal)
        XCTAssertNotNil(stepper.incrementImage(for: UIControl.State.normal))
        XCTAssertNotNil(stepper.decrementImage(for: UIControl.State.normal))
    }
    
    func testTextFieldImages() {
        let textField = UITextField()
        textField.setRightViewIcon(icon: .openIconic(.alignCenter))
        textField.setLeftViewIcon(icon: .ionicons(.wifi))
        XCTAssertNotNil(textField.leftView)
        XCTAssertNotNil(textField.rightView)
    }
    
    func testViewControllerTitleShouldBeSet() {
        let viewController = UIViewController()
        viewController.setTitleIcon(icon: .icofont(.xray))
        XCTAssertNotNil(viewController.title, "View Controller Title Font Should Not Be Nil.")
    }

    func testViewControllerTitle() {
        let viewController = UIViewController()
        viewController.setTitleIcon(icon: .fontAwesomeBrands(.youtube))
        XCTAssertEqual(viewController.title, "\u{f167}")
    }
}
