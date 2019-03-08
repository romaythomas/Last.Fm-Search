//
//  HomeVC.swift
//  Last.Fm Search
//
//  Created by Owner on 06/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeVC: UIViewController {
    
    // MARK: - Properties
    // MARK: - Outlets
    // MARK: - Life Cycle
    // MARK: - Methods
    // MARK: - Properties
    
    var task: URLSessionDataTask?
    let disposeBag = DisposeBag()
    var artistViewModel = ArtistListViewModel(artist: []) {
        didSet {
            DispatchQueue.main.async
                {
                    self.tableView.reloadData()
            }
            
        }
    }
    var artistChartViewModel = ArtistChartListViewModel(artist: []) {
        didSet {
            DispatchQueue.main.async
                {
                    self.tableView.reloadData()
            }
            
        }
    }
    var albumViewModel = AlbumsListViewModel(albums: [] ){
        didSet {
            DispatchQueue.main.async
                {
                    self.tableView.reloadData()
                    
            }
            
        }
    }
    var trackViewModel = TrackListViewModel(track:[]) {
        didSet {
            DispatchQueue.main.async
                {
                    self.tableView.reloadData()
                    
            }
            
        }
    }
    
    // MARK: - Outlet

    @IBOutlet weak var searchItemsBar: UISearchBar!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchTabBar()
        searchItems()
        setupTableView()
        
    }
    
    
     // MARK: - Methods
    
    func searchItems() {
        searchItemsBar
            .rx.text // Observable property
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value
                self.searchItemsBar.showsCancelButton = true
                if query != ""{
                    self.findAlbumWith(searchItems: query)
                    self.findTrackWith(searchItems: query)
                    self.findArtistWith(searchItems: query)
                    
                }
   
                self.tableView.reloadData() // And reload table view data.
            })
            .disposed(by: disposeBag)
    }
    
    func loadTopArtistChart() {
   
        self.task = LastFMAPIService().fetchTopArtistChart(completion: { [weak self ](artist) in
            if artist.count == 0 {
                self?.showErrorMessage()
                return
            }
            let artistChartViewModel = artist.map({ ArtistViewModel(artist: $0) })
            self?.artistChartViewModel = ArtistChartListViewModel(artist: artistChartViewModel)
            
        })
        
    }
    func findArtistWith(searchItems : String) {
        
        
        _ = LastFMAPIService().fetchArtistWith(searchItems: searchItems, completion: { [weak self ](artists) in
            if artists.count == 0 {
                self?.showErrorMessage()
                return
            }
            let artistViewModel = artists.map({ ArtistViewModel(artist: $0) })
            self?.artistViewModel = ArtistListViewModel(artist: artistViewModel)
            
        })
        
        
        
        
    }
    func findAlbumWith(searchItems : String) {
        
        
        _ = LastFMAPIService().fetchAlbumsWith(searchItems: searchItems, completion: { [weak self ](albums) in
            if albums.count == 0 {
                self?.showErrorMessage()
                return
            }
            let albumViewModel = albums.map({ AlbumsViewModel(album: $0) })
            self?.albumViewModel = AlbumsListViewModel(albums: albumViewModel)
            
            
        })
        
        
        
        
    }
    func findTrackWith(searchItems : String) {
        
        
        _ = LastFMAPIService().fetchTracksWith(searchItems: searchItems, completion: { [weak self ](tracks) in
            if tracks.count == 0 {
                self?.showErrorMessage()
                return
            }
            let tracksViewModel = tracks.map({ TrackViewModel(track: $0) })
            self?.trackViewModel = TrackListViewModel(track: tracksViewModel)
            
            
        })
        
        
        
        
    }
    
    
    private func showErrorMessage() {
        let alert = UIAlertController(title: "Error", message: "There was an error while loading the request. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func setupTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.tableHeaderView = UIView()
        tableView.layer.masksToBounds = true
        tableView.layer.borderWidth = 3.0
        tableView.layer.cornerRadius = 10
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Articles"
        navigationController?.navigationBar.backgroundColor = .yellow
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 50, g: 199, b: 242)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    func configureSearchTabBar() {
        
        searchItemsBar.showsCancelButton = true
        searchItemsBar.placeholder = "Search for album , song or artist"
        searchItemsBar.delegate = self
        definesPresentationContext = true
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchItemsBar.text = ""
        searchItemsBar.showsCancelButton = false
    }

    @objc func viewAllArtistButtonClicked(sender:UIButton) {
        
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "ArtistSearchVC") as! ArtistSearchVC
        //destination.artistViewModel.artist.removeAll()
        destination.artistViewModel = self.artistViewModel
        destination.navigationItem.title = "Arist Search"
        navigationController?.pushViewController(destination, animated: true)
        
    }
    @objc func viewAllAlbumsButtonClicked(sender:UIButton) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "AlbumSearchVC") as! AlbumSearchVC
        destination.albumViewModel = self.albumViewModel
        destination.navigationItem.title = "Album Search"
        navigationController?.pushViewController(destination, animated: true)
        
    }
    @objc func viewAllTracksButtonClicked(sender:UIButton) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "TrackSearchVC") as! TrackSearchVC
        destination.trackViewModel = self.trackViewModel
        destination.navigationItem.title = "Track Search"
        navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
    
    
}

// MARK: - TableViewDelegate , TableViewDataSource
extension HomeVC : UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        // For artist search result , return the count of the array
        case 0: return self.artistViewModel.topSearches.count
        case 1: return self.albumViewModel.topSearches.count
        case 2: return self.trackViewModel.topSearches.count
        case 3: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // For the section displying
        switch indexPath.section {
        case 0:
            
            // Dequeue the cell to display data
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
            
            
            let artist = artistViewModel.artist[indexPath.row]
            guard let imageURL = artist.imageURL else {return cell}
            
           
            cell.detailTextLabel?.text = "Artist"
            cell.textLabel?.text = artist.name
            cell.textLabel?.font = UIFont(name: "Chalkboard SE", size: 16)
            cell.detailTextLabel?.font = UIFont(name: "Chalkboard SE", size: 17)
            cell.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
            
            // Clear the ImageView incase we reuse it
            cell.imageView?.image = nil
            
            
            ImageManger.shared.fetchImage(imageURL) { (image) in
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                    cell.setNeedsLayout()
                }
                
            }
            
            
            return cell
            

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellid1", for: indexPath)
            
            let album = albumViewModel.topSearches[indexPath.row]
            guard let imageURL = album.imageURL else {return cell}
            cell.textLabel?.text = album.name
            cell.detailTextLabel?.text = album.artist
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
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellid2", for: indexPath)
            
            let track = trackViewModel.topSearches[indexPath.row]
            guard let imageURL = track.imageURL else {return cell}
            cell.textLabel?.text = track.name
            cell.detailTextLabel?.text = track.artist
         
            
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
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellid3", for: indexPath)
                as! ViewAllTableViewCell
            
            cell.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
            
            
            cell.viewAllArtistButton.addTarget(self, action: #selector( self.viewAllArtistButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
            
            cell.viewAllAlbumsButton.addTarget(self, action: #selector( self.viewAllAlbumsButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
            cell.viewAllTracksButton.addTarget(self, action: #selector( self.viewAllTracksButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
            
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return "Artist"
        case 1: return "Album"
        case 2: return "Tracks"
        case 3: return "See All Result"
        default: return nil
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            let artist = artistViewModel.artist[indexPath.row]
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "ArtistDetailVC") as! ArtistDetailVC
            
            destination.artistName = artist.name
            guard let imageURL = artist.imageURL else {return}
            destination.imageURL = imageURL
            
            if let listeners = artist.listeners{
                destination.listnerCount = listeners }
            
            destination.navigationItem.title = "Artist Detail"
            navigationController?.pushViewController(destination, animated: true)
            
        case 1:
            
            let album = albumViewModel.topSearches[indexPath.row]
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "AlbumDetailVC") as! AlbumDetailVC
            guard let imageURL = album.imageURL else {return}
            destination.albumName = album.name
            destination.artistName = album.artist
            destination.imageURL = imageURL
            
            
            
            destination.navigationItem.title = "Album Detail"
            navigationController?.pushViewController(destination, animated: true)
        case 2:
            
            let track = trackViewModel.topSearches[indexPath.row]
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "TrackDetailVC") as! TrackDetailVC
            guard let imageURL = track.imageURL else {return}
            destination.trackName = track.name
            destination.imageURL = imageURL
            destination.artistName = track.artist
            
            
            
            destination.listners = track.listeners
            
            destination.navigationItem.title = "Track Detail"
            navigationController?.pushViewController(destination, animated: true)
            
        default: break
            
        }
        
        
 
    }
}
extension HomeVC :UISearchBarDelegate {
    
}
// MARK: - Extensions
extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


