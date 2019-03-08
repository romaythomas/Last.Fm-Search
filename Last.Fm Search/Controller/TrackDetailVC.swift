//
//  TrackDetailVC.swift
//  Last.Fm Search
//
//  Created by Owner on 07/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit

class TrackDetailVC: UIViewController {

   var imageURL : String = ""
   var trackName : String = ""
    var artistName : String = ""
    var listners : String = ""
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var trackNameTextField: UILabel!
    
    @IBOutlet weak var artisNameTextField: UILabel!
    
    @IBOutlet weak var listnerCountTextField: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadImageWith(imageURL: imageURL)
        trackNameTextField.text = trackName
        artisNameTextField.text = artistName
        listnerCountTextField.text = listners
  
        
        // Do any additional setup after loading the view.
    }
    func loadImageWith( imageURL: String)  {
        ImageManger.shared.fetchImage(imageURL) { (image) in
            DispatchQueue.main.async {
                self.imageView?.image = image
                
            }
            
        }
    }


}
