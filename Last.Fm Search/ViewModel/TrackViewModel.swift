//
//  TrackViewModel.swift
//  Last.Fm Search
//
//  Created by Owner on 07/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation




struct TrackListViewModel {
    var track = [TrackViewModel]()
    var topSearches = [TrackViewModel]()
    
    init(track: [TrackViewModel]) {
        self.track = track
         topSearches = Array (track.prefix(3))
    }
}

struct TrackViewModel {
    

    
    var name: String
    var duration: String?
    var playcount: String?
    var listeners: String
    var mbid: String
    var url: String
    var streamable:String
    var artist: String
  
    var imageURL : String?
  
}

extension TrackViewModel {
    
    init(track: Track) {
        self.name = track.name
        self.duration = track.duration
        self.playcount = track.playcount
        self.listeners = track.listeners
        self.mbid = track.mbid
        self.url = track.url
        self.streamable = track.streamable
        self.artist = track.artist
  
        
        
        let imgList = track.image
        
        for list in imgList  {
            
            if list.size == Size.large {
                
                imageURL = list.text
            }
            
        }
        
    }
}

