//
//  AlbumViewModel.swift
//  Last.Fm Search
//
//  Created by Owner on 07/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation




struct AlbumsListViewModel {
    var albums = [AlbumsViewModel]()
    var topSearches = [AlbumsViewModel]()
    
    init(albums: [AlbumsViewModel]) {
        self.albums = albums
        topSearches = Array (albums.prefix(3))
        
    }
}

struct AlbumsViewModel {
 
    var name : String
    var artist: String
    var url: String
    var streamable: String?
    var mbid: String
    var imageURL : String?
}

extension AlbumsViewModel {
    
    init(album: Album) {
        self.name = album.name
        self.artist = album.artist
        self.mbid = album.mbid
        self.url = album.url
        self.streamable = album.streamable
      
        
        
        let imgList = album.image
        
        for list in imgList ?? [] {
            
            if list.size == Size.large {
                
                imageURL = list.text
            }
            
        }
        
    }
}


