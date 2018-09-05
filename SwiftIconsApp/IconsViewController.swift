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

private let reuseIdentifier = "fontIcons"

class IconsViewController: UICollectionViewController {
    
    var index: Int!
    var iconColors = ["e74c3c", "e67e22", "f1c40f", "2ecc71", "1abc9c", "3498db", "9b59b6", "e4Accf", "95a5a6", "34495e", "6c6998", "00695C"]
    var fonts = ["DRIPICONS", "EMOJI", "FONT-AWESOME-REGULAR", "ICO FONT", "IONICONS", "LINEARICONS", "MAP-ICONS", "MATERIAL ICONS", "OPEN ICONIC", "STATE FACE", "WEATHER ICONS", "TYPICONS"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        let color = UIColor.init(hex: iconColors[index])
        let font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        let attributes = [NSAttributedStringKey.font : font!, NSAttributedStringKey.foregroundColor: color]

        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.title = fonts[index]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(goBack(sender:)))
        navigationItem.leftBarButtonItem?.setIcon(icon: .fontAwesomeSolid(.longArrowAltLeft), iconSize: 30, color: color)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        var spacing: CGFloat
        if screenWidth == 320 {
            spacing = 70/6
        } else if screenWidth == 375 {
            spacing = 75/7
        } else if screenWidth == 414 {
            spacing = 114/8
        } else {
            spacing = 5
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        collectionView!.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    @objc func goBack(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        var count = 0
        switch index! {
        case 0:
            count = DripiconType.count
        case 1:
            count = EmojiType.count
        case 2:
            count = FARegularType.count
        case 3:
            count = IcofontType.count
        case 4:
            count = IoniconsType.count
        case 5:
            count = LinearIconType.count
        case 6:
            count = MapiconsType.count
        case 7:
            count = GoogleMaterialDesignType.count
        case 8:
            count = OpenIconicType.count
        case 9:
            count = StatefaceType.count
        case 10:
            count = WeatherType.count
        case 11:
            count = TypIconsType.count
        default:
            break
        }
        
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        let imgView = cell.viewWithTag(1) as! UIImageView
        let color = UIColor.init(hex: iconColors[index!])
        
        switch index! {
        case 0:
            let icon: DripiconType = DripiconType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .dripicon(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 1:
            let icon: EmojiType = EmojiType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .emoji(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 2:
            let icon: FARegularType = FARegularType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .fontAwesomeRegular(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 3:
            let icon: IcofontType = IcofontType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .icofont(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 4:
            let icon: IoniconsType = IoniconsType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .ionicons(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 5:
            let icon: LinearIconType = LinearIconType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .linearIcons(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 6:
            let icon: MapiconsType = MapiconsType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .mapicons(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 7:
            let icon: GoogleMaterialDesignType = GoogleMaterialDesignType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .googleMaterialDesign(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 8:
            let icon: OpenIconicType = OpenIconicType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .openIconic(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 9:
            let icon: StatefaceType = StatefaceType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .state(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 10:
            let icon: WeatherType = WeatherType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .weather(icon), textColor: color, backgroundColor: .clear, size: nil)
        case 11:
            let icon: TypIconsType = TypIconsType(rawValue: indexPath.row)!
            imgView.setIcon(icon: .typIcons(icon), textColor: color, backgroundColor: .clear, size: nil)
        default:
            break
        }
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "iconSelectionSegue") {
            let indexPath = (collectionView?.indexPathsForSelectedItems?[0])! as IndexPath

            let viewController = segue.destination as! IconDetailViewController
            viewController.index = index
            viewController.indexPath = indexPath
            
            switch index! {
            case 0:
                let icon: DripiconType = DripiconType(rawValue: indexPath.row)!
                viewController.icon = .dripicon(icon)
            case 1:
                let icon: EmojiType = EmojiType(rawValue: indexPath.row)!
                viewController.icon = .emoji(icon)
            case 2:
                let icon: FARegularType = FARegularType(rawValue: indexPath.row)!
                viewController.icon = .fontAwesomeRegular(icon)
            case 3:
                let icon: IcofontType = IcofontType(rawValue: indexPath.row)!
                viewController.icon = .icofont(icon)
            case 4:
                let icon: IoniconsType = IoniconsType(rawValue: indexPath.row)!
                viewController.icon = .ionicons(icon)
            case 5:
                let icon: LinearIconType = LinearIconType(rawValue: indexPath.row)!
                viewController.icon = .linearIcons(icon)
            case 6:
                let icon: MapiconsType = MapiconsType(rawValue: indexPath.row)!
                viewController.icon = .mapicons(icon)
            case 7:
                let icon: GoogleMaterialDesignType = GoogleMaterialDesignType(rawValue: indexPath.row)!
                viewController.icon = .googleMaterialDesign(icon)
            case 8:
                let icon: OpenIconicType = OpenIconicType(rawValue: indexPath.row)!
                viewController.icon = .openIconic(icon)
            case 9:
                let icon: StatefaceType = StatefaceType(rawValue: indexPath.row)!
                viewController.icon = .state(icon)
            case 10:
                let icon: WeatherType = WeatherType(rawValue: indexPath.row)!
                viewController.icon = .weather(icon)
            case 11:
                let icon: TypIconsType = TypIconsType(rawValue: indexPath.row)!
                viewController.icon = .typIcons(icon)
            default:
                break
            }            
        }
    }
}
