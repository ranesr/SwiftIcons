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

class AboutViewController: UIViewController {

    @IBOutlet var githubBtn: UIButton!
    @IBOutlet var madeWith: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "justlogo")
        navigationItem.titleView = imageView

        let font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        let black: UIColor = .black
        let attributes = [NSAttributedStringKey.font : font!, NSAttributedStringKey.foregroundColor: black]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.hidesBackButton = true

        githubBtn.setIcon(prefixText: "Learn more:  ", icon: .fontAwesome(.github), iconColor: UIColor.init(hex: "3498db"), postfixText: "", forState: .normal, textSize: 16, iconSize: 30)
        
        madeWith.setIcon(prefixText: "Made with ", icon: .fontAwesome(.heart), iconColor: UIColor.init(hex: "e74c3c"), postfixText: " in Dallas, Texas", size: 20, iconSize: 20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToGithub(_ sender: Any) {
        if let requestUrl = NSURL(string: "https://github.com/ranesr/SwiftIcons") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(requestUrl as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(requestUrl as URL)
            }
        }
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
