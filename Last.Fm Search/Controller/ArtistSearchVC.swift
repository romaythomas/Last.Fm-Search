//
//  ArtistSearchVC.swift
//  Last.Fm Search
//
//  Created by Owner on 07/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArtistSearchVC: UIViewController {
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    var artistViewModel =  ArtistListViewModel(artist: []) {
        didSet {
        }
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
      
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
          self.tableView.reloadData()
      
        
    }
    
}
// MARK: - TableViewDelegate , TableViewDataSource
extension ArtistSearchVC : UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            
   return self.artistViewModel.artist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
            
            
            let artist = artistViewModel.artist[indexPath.row]
           guard let imageURL = artist.imageURL else {return cell}
            
        
            cell.detailTextLabel?.text = artist.url
            cell.textLabel?.text = artist.name
        
        cell.imageView?.image = nil
        
        ImageManger.shared.fetchImage(imageURL) { (image) in
            DispatchQueue.main.async {
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
            
        }
        
        
            cell.textLabel?.font = UIFont(name: "Chalkboard SE", size: 16)
            cell.detailTextLabel?.font = UIFont(name: "Chalkboard SE", size: 17)
            cell.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
            
            // Clear the ImageView incase we reuse it
       
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
       
 return "Artist"

        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let artist = artistViewModel.artist[indexPath.row]
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "ArtistDetailVC") as! ArtistDetailVC
        
        destination.artistName = artist.name
        guard let imageURL = artist.imageURL else {return}
        destination.imageURL = imageURL
        
        if let listeners = artist.listeners{
            destination.listnerCount = listeners }
        
        destination.navigationItem.title = "Artist Detail"
        navigationController?.pushViewController(destination, animated: true)
     
    }
}
