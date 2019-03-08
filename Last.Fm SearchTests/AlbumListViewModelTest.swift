//
//  AlbumListViewModelTest.swift
//  Last.Fm SearchTests
//
//  Created by Owner on 08/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//
import XCTest
@testable import Last_Fm_Search

class AlbumListViewModelTest: XCTestCase {
    
    var sut: ArtistViewModel!
    
    override func setUp() {
        sut = ArtistViewModel(artist: getMockAtist())
    }
    
    override func tearDown() {
        sut = nil
    }
    
    private func getMockAtist() -> Artist {
        
        // https://www.last.fm/music/Imagine+Dragons/_/Believer
        return Artist (name: "Json Drulo", playcount: "1200", listeners: "1222223", mbid: "", url: "https://www.last.fm/music/Cher/_/Believe", streamable: "", image: [])
    }
    
    func testInitialiser() {
        let mockArtist = getMockAtist()
        XCTAssertEqual(sut.name, mockArtist.name)
        XCTAssertEqual(sut.mbid, mockArtist.mbid)
        XCTAssertEqual(sut.playcount, mockArtist.playcount)
        XCTAssertEqual(sut.streamable, mockArtist.streamable)
        // XCTAssertEqual(sut.imageURL, mockArtist.ima)
    }
}

