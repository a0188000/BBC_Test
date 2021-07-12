//
//  MockItunesService.swift
//  EBC_TestTests
//
//  Created by 沈維庭 on 2021/7/12.
//

import XCTest
@testable import EBC_Test

final class MockItunesService: ItunesServiceProtocol {
    
    var searchResult: Result<Itunes,Error> = .success(Itunes(totalCount: 1, musics: []))
    
    func searchMusic(musicName: String, completionHandler: @escaping (Result<Itunes, Error>) -> Void) {
        completionHandler(searchResult)
    }
}
