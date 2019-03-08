//
//  TrackListViewModelTest.swift
//  Last.Fm SearchTests
//
//  Created by Owner on 08/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation

import XCTest
@testable import Last_Fm_Search

class TrackListViewModelTest: XCTestCase {
    
    var sut: TrackViewModel!
    
    override func setUp() {
        sut = TrackViewModel(track: getMockTrack())
    }
    
    override func tearDown() {
        sut = nil
    }
    
    private func getMockTrack() -> Track {
        
        // https://www.last.fm/music/Imagine+Dragons/_/Believer
        return Track(name: "Json Drulo", duration: "90", playcount: "120202", listeners: "353533", mbid: "0", url: "https://www.last.fm/music/Cher/_/Believe", streamable: "0", artist: "Json Drulo", image: [])
       
    }
    
    func testInitialiser() {
        let mokeTrack = getMockTrack()
        XCTAssertEqual(sut.name, mokeTrack.name)
        XCTAssertEqual(sut.mbid, mokeTrack.mbid)
        XCTAssertEqual(sut.playcount, mokeTrack.playcount)
        XCTAssertEqual(sut.streamable, mokeTrack.streamable)
        XCTAssertEqual(sut.duration, mokeTrack.duration)
        XCTAssertEqual(sut.url, mokeTrack.url)
        XCTAssertEqual(sut.artist, mokeTrack.artist)

        
        // XCTAssertEqual(sut.imageURL, mockArtist.ima)
    }
}
