//
//  AlbumSearchVC.swift
//  Last.Fm Search
//
//  Created by Owner on 07/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit

class AlbumSearchVC: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
 
    var albumViewModel = AlbumsListViewModel(albums: [] )
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
// MARK: - TableViewDelegate , TableViewDataSource
extension AlbumSearchVC : UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.albumViewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
    
        let album = albumViewModel.albums[indexPath.row]
        
        guard let imageURL = album.imageURL else {return cell}
       
        
        cell.textLabel?.text = album.name
        cell.imageView?.image = nil
        
        ImageManger.shared.fetchImage(imageURL) { (image) in
            DispatchQueue.main.async {
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
            
        }
        
        cell.textLabel?.font = UIFont(name: "Chalkboard SE", size: 16)
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return "Albums"
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let album = albumViewModel.topSearches[indexPath.row]
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "AlbumDetailVC") as! AlbumDetailVC
        guard let imageURL = album.imageURL else {return}
        destination.albumName = album.name
        destination.artistName = album.artist
        destination.imageURL = imageURL
        
        
        
        destination.navigationItem.title = "Album Detail"
        navigationController?.pushViewController(destination, animated: true)
    }
}
