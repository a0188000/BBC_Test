//
//  ItunesService.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/11.
//

import Foundation

protocol ItunesServiceProtocol {
    func searchMusic(musicName: String, completionHandler: @escaping (Result<Itunes, Error>) -> Void)
}

class ItunesService: ItunesServiceProtocol {
    
    func searchMusic(musicName: String, completionHandler: @escaping (Result<Itunes, Error>) -> Void) {
        APIManager.shared.request(req: ItunesEndPoint.searchMusic(musiceName: musicName), completionHandler: completionHandler)
    }
}
