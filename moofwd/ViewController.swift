//
//  ViewController.swift
//  moofwd
//
//  Created by Francisco Barrios Romo on 05-11-17.
//  Copyright © 2017 RentalApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {

    var tableViewDataSource: [data] = []
    var thisName = ""
    var dataTitle = ""
    var dataLink = ""
    var dataAuthor = ""
   
    @IBOutlet var tabla: UITableView!
    
    @IBOutlet var vista: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tabla.dataSource = self
        tabla.delegate = self
        if let path = URL(string: "http://www.telegraph.co.uk/sport/rss.xml"){
            if let parser = XMLParser(contentsOf: path){
                print("works")
                parser.delegate = self
                parser.parse()
            }else {
                print("Doesnt work")
            }
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    vista.addGradientWithColor(color1: UIColor(red:0.09, green:0.10, blue:0.14, alpha:1.0), color2: UIColor(red:0.13, green:0.16, blue:0.22, alpha:1.0))
        
        tabla.reloadData()
        tabla.backgroundColor = UIColor.clear
        
    }
    
    // UITableView Delegates
    func tableView(_ tv:UITableView, numberOfRowsInSection section:Int) -> Int {
        
        return tableViewDataSource.count
    }
    
    func tableView(_ tv:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
      
       tabla.rowHeight = 100.0
        
        let label1 = cell.viewWithTag(12) as! UILabel // 1 is tag of first label;
        label1.text = tableViewDataSource[indexPath.row].title
        
        let label2 = cell.viewWithTag(11) as! UILabel // 1 is tag of first label;
        label2.text = tableViewDataSource[indexPath.row].author
        
        let img1 = cell.viewWithTag(13) as! UIImageView // 1 is tag of first label;
        img1.image = UIImage(named: "Image")!
        
        /* LOAD IMAGEN PROBLEM WITH THE WEIGH WE NEED THUMBNAILS
         
         let img1 = cell.viewWithTag(13) as! UIImageView // 1 is tag of first label;
         let url = URL(string: tableViewDataSource[indexPath.row].link)
         let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
         img1.image = UIImage(data: data!)
 
         */
        
        
        cell.backgroundColor = UIColor.clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    
    // XML delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
       thisName = elementName
        if elementName == "enclosure" {
            let attrsUrl = attributeDict as [String: NSString]
            dataLink = attrsUrl["url"]! as String
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if data.count != 0
        {
            switch thisName {
            case "title": dataTitle = data
            case "dc:creator": dataAuthor = data
                
            default:
                break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"
        {
            let myData = data()
            myData.title = dataTitle
            myData.link = dataLink
            myData.author = dataAuthor
            print("title: ",myData.title)
            print("link: ",myData.link)
            print("author: ",myData.author)
            tableViewDataSource.append(myData)
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            
            
            if let indexPath = self.tabla.indexPathForSelectedRow {
                let controller = segue.destination as! DetalleViewController
            
                controller.titleData = tableViewDataSource[indexPath.row].title
                controller.authorData = tableViewDataSource[indexPath.row].author
                controller.urlImage = tableViewDataSource[indexPath.row].link
            }
        }
        
    }

}
extension UIView {
    func addGradientWithColor(color1: UIColor, color2: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
