//
//  ServiceAPI.swift
//  Last.Fm Search
//
//  Created by Owner on 06/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation


enum Methods : String {
    case albums = "album.search"
    case artist = "artist.search"
    case tracks = "track.search"
    case artistChart = "chart.gettopartists"
    case trackChart = "chart.gettoptracks"
}



struct ServiceAPI {

    static let baseURL = "https://ws.audioscrobbler.com/2.0/"
    static let aPikey = "885f6d530330cf0230b2ea2b5959ad6c"
    
    
    static func albumURL(albumName : String) -> URL?  {
    guard var  urlComponents = URLComponents(string: baseURL) else {return nil}
        urlComponents.queryItems = [
            URLQueryItem(name: "method", value: Methods.albums.rawValue),
             URLQueryItem(name: "album", value: albumName),
            URLQueryItem(name: "api_key", value: aPikey),
            URLQueryItem(name: "format", value: "json")
        ]
       
        return urlComponents.url
    }
    
    static func tracksURL(trackName : String) -> URL?  {
        guard var  urlComponents = URLComponents(string: baseURL) else {return nil}
        urlComponents.queryItems = [
            URLQueryItem(name: "method", value: Methods.tracks.rawValue),
            URLQueryItem(name: "track", value: trackName),
            URLQueryItem(name: "api_key", value: aPikey),
            URLQueryItem(name: "format", value: "json")
        ]
        
        return urlComponents.url
    }
    
    static func artistURL(artistName: String) -> URL?  {
        
       guard var  urlComponents = URLComponents(string: baseURL) else {return nil}
        urlComponents.queryItems = [
            URLQueryItem(name: "method", value: Methods.artist.rawValue),
            URLQueryItem(name: "artist", value: artistName),
            URLQueryItem(name: "api_key", value: aPikey),
            URLQueryItem(name: "format", value: "json")
        ]
        
        return urlComponents.url
    }
    static func ArtistChartURL() -> URL?  {
        guard var  urlComponents = URLComponents(string: baseURL) else {return nil}
        
        urlComponents.queryItems = [
            URLQueryItem(name: "method", value: Methods.artistChart.rawValue),
            URLQueryItem(name: "api_key", value: aPikey),
            URLQueryItem(name: "format", value: "json")
        ]
      
        
        return urlComponents.url
        
    }
    static func trackChartURL() -> URL?  {
        guard var  urlComponents = URLComponents(string: baseURL) else {return nil}
        
        urlComponents.queryItems = [
            URLQueryItem(name: "method", value: Methods.trackChart.rawValue),
            URLQueryItem(name: "api_key", value: aPikey),
            URLQueryItem(name: "format", value: "json")
        ]
        
        return urlComponents.url
    }
 
    
    
}


class LastFMAPIService {
    

    
    func fetchAlbumsWith(searchItems: String, completion: @escaping ([Album]) -> ()) -> URLSessionDataTask? {
    
        guard let url = ServiceAPI.albumURL(albumName: searchItems) else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(APISearchResponse.self, from: data)
                guard let album = response.results.albummatches?.album else { return }
                DispatchQueue.main.async {
                    completion(album)
                }
            } catch let err {
                print("Err - album details web service", err)
                completion([])
            }
        }
        task.resume()
        return task
    }
    func fetchArtistWith(searchItems: String, completion: @escaping ([Artist]) -> ()) -> URLSessionDataTask? {
        
        guard let url = ServiceAPI.artistURL(artistName: searchItems) else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(APISearchResponse.self, from: data)
                guard let artist = response.results.artistmatches?.artist  else { return }
                DispatchQueue.main.async {
                    completion(artist)
                }
            } catch let err {
                print("Err - artist details web service", err)
                completion([])
            }
        }
        task.resume()
        return task
    }
    
    func fetchTracksWith(searchItems: String, completion: @escaping ([Track]) -> ()) -> URLSessionDataTask? {
        
        guard let url = ServiceAPI.tracksURL(trackName: searchItems) else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(APISearchResponse.self, from: data)
                guard let track = response.results.trackmatches?.track else { return }
                DispatchQueue.main.async {
                    completion(track)
                }
            } catch let err {
                print("Err - track details web service", err)
                completion([])
            }
        }
        task.resume()
        return task
    }
    
    func fetchTopArtistChart(completion: @escaping ([Artist]) -> ()) -> URLSessionDataTask? {
        
        guard let url = ServiceAPI.ArtistChartURL()else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ArtistChart.self, from: data)
               let artist = response.artists.artist
                DispatchQueue.main.async {
                    completion(artist)
                }
            } catch let err {
                print("Err - track details web service", err)
                completion([])
            }
        }
        task.resume()
        return task
    }
    
    
}


