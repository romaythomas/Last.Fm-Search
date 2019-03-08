//
//  TrackSearchVC.swift
//  Last.Fm Search
//
//  Created by Owner on 07/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit

class TrackSearchVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    var trackViewModel = TrackListViewModel(track:[]) {
        didSet {
    
        }
    }
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
extension TrackSearchVC : UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.trackViewModel.track.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let track = trackViewModel.track[indexPath.row]
        guard let imageURL = track.imageURL else {return cell}
        cell.textLabel?.text = track.name
        cell.detailTextLabel?.text = track.artist
        
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
   
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return "Albums"
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        let track = trackViewModel.topSearches[indexPath.row]
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "TrackDetailVC") as! TrackDetailVC
        guard let imageURL = track.imageURL else {return}
        destination.trackName = track.name
        destination.imageURL = imageURL
        
        
        
        destination.listners = track.listeners
        
        destination.navigationItem.title = "Track Detail"
        navigationController?.pushViewController(destination, animated: true)
    }
}
