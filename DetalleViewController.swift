//
//  DetalleViewController.swift
//  moofwd
//
//  Created by Francisco Barrios Romo on 05-11-17.
//  Copyright © 2017 RentalApps. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {

    var urlImage = ""
    var titleData = ""
    var authorData = ""
    
    @IBOutlet var vistaDetalle: UIView!
    
    @IBOutlet var cardTitle: UILabel!
    @IBOutlet var vistaCard: UIView!
    @IBOutlet var cardDetail: UILabel!
    
    @IBOutlet var imageTop: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        vistaDetalle.addGradientWithColor(color1: UIColor(red:0.09, green:0.10, blue:0.14, alpha:1.0), color2: UIColor(red:0.13, green:0.16, blue:0.22, alpha:1.0))
        
        vistaCard.layer.cornerRadius = 8
        
        cardTitle.text = authorData
        cardDetail.text = titleData
        
        let url = URL(string: urlImage)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        imageTop.image = UIImage(data: data!)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
