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

class FontsViewController: UITableViewController {

    var fonts = ["DRIPICONS", "EMOJI", "FONT-AWESOME-REGULAR", "ICO FONT", "IONICONS", "LINEARICONS", "MAP-ICONS", "MATERIAL ICONS", "OPEN ICONIC", "STATE FACE", "WEATHER ICONS", "TYPICONS"]
    var fontBackgroundColors = ["e74c3c", "e67e22", "f1c40f", "2ecc71", "1abc9c", "3498db", "9b59b6", "e4Accf", "95a5a6", "34495e", "6c6998", "00695C"]

    var authors = ["AMIT JAKHU", "JOHN SLEGERS", "DAVE GANDY", "SHAPEBOOTSTRAP", "IONIC", "PERXIS", "SCOTT DE JONGE", "GOOGLE", "ICONIC", "PROPUBLICA", "ERIK FLOWERS", "Stephen Hutchings"]
    var ownersBackgroundColors = ["c0392b", "d35400", "f39c12", "27ae60", "16a085", "2980b9", "8e44ad", "B68AA5", "7f8c8d", "2c3e50", "555283", "004D40"]
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "justlogo")
        navigationItem.titleView = imageView
        
        let font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        let black: UIColor = .black
        let attributes = [NSAttributedString.Key.font : font!, NSAttributedString.Key.foregroundColor: black]
        navigationController?.navigationBar.titleTextAttributes = attributes

        tableView.separatorColor = .clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fonts.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontCell", for: indexPath) as! FontTableViewCell

        // Configure the cell...
        cell.fontName.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        cell.author.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)

        cell.fontName.text = fonts[indexPath.row]
        cell.fontName.backgroundColor = UIColor.init(hex: fontBackgroundColors[indexPath.row])
        
        cell.author.text = authors[indexPath.row]
        cell.author.backgroundColor = UIColor.init(hex: ownersBackgroundColors[indexPath.row])
        
        cell.selectionStyle = .none

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "fontSelectionSegue") {
            let viewController = segue.destination as! IconsViewController            
            viewController.index = tableView.indexPathForSelectedRow!.row
        }
    }
}
