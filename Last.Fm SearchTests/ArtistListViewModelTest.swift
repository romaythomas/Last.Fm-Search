//
//  ArtistListViewModelTest.swift
//  Last.Fm SearchTests
//
//  Created by Owner on 08/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import XCTest
@testable import Last_Fm_Search

class ArtistListViewModelTest: XCTestCase {
    
    var sut: AlbumsViewModel!
    
    override func setUp() {
        sut = AlbumsViewModel(album: getMockAlbum())
    }
    
    override func tearDown() {
        sut = nil
    }
    
    private func getMockAlbum() -> Album {
 
     
        return Album(name: "Test", artist: "Json Drulo", mbid: "32ca187e-ee25-4f18-b7d0-3b6713f24635", url: "https://www.last.fm/music/Cher/_/Believe", streamable: "0", image: [])
        
    }
    
    func testInitialiser() {
        let mockAlbum = getMockAlbum()
        XCTAssertEqual(sut.name, mockAlbum.name)
        XCTAssertEqual(sut.artist, mockAlbum.artist)
        XCTAssertEqual(sut.mbid, mockAlbum.mbid)
        XCTAssertEqual(sut.url, mockAlbum.url)
        XCTAssertEqual(sut.streamable, mockAlbum.streamable)
      
    }
}
