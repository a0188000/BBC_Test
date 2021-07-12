//
//  MusicListControllerSpec.swift
//  EBC_TestTests
//
//  Created by 沈維庭 on 2021/7/12.
//

import XCTest
@testable import EBC_Test

class MusicListControllerSpec: XCTestCase {

    var controller: MusicListController!
    var viewModel: MusicListViewModel!
    var mockItunesService: MockItunesService!
    
    override func setUp() {
        viewModel = MusicListViewModel()
        mockItunesService = MockItunesService()
        controller = .init(viewModel: viewModel, itunesService: mockItunesService)
    }
    
    
    func testSearchWithCorrectMusicSuccessPresentedToTrue() {
        mockItunesService.searchResult = .success(Itunes(totalCount: 1, musics: [Music(artworkUrl100: "success.jpg", longDescription: "success")]))
        controller.searchMusic(musicName: "json")
        XCTAssertTrue(!viewModel.listViewModels.isEmpty)
        XCTAssertFalse(viewModel.listViewModels.isEmpty)
    }
    
    func testSearchWithCorrectMusicSuccessButNotFind() {
        mockItunesService.searchResult = .success(Itunes(totalCount: 1, musics: []))
        controller.searchMusic(musicName: "json")
        XCTAssertTrue(viewModel.listViewModels.isEmpty)
        XCTAssertFalse(!viewModel.listViewModels.isEmpty)
    }
    
    func testSearchMusicWithErrorSetsError() {
        mockItunesService.searchResult = .failure(NSError(domain: "", code: -1, userInfo: nil))
        controller.searchMusic(musicName: "")
        XCTAssertNotNil(viewModel.error)
    }

}
