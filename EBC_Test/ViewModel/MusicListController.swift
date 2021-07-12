//
//  MusicListController.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/11.
//

import Foundation

class MusicListController {
    
    var itunesService: ItunesServiceProtocol
    var viewModel: MusicListViewModel
    
    init(viewModel: MusicListViewModel = MusicListViewModel(),
         itunesService: ItunesServiceProtocol = ItunesService()) {
        self.viewModel = viewModel
        self.itunesService = itunesService
    }
    
    func start() {
        self.viewModel.isLoading = true
    }
    
    func searchMusic(musicName: String) {
        self.viewModel.isLoading = true
        self.itunesService.searchMusic(musicName: musicName) { (result) in
            self.viewModel.isLoading = false
            switch result {
            case .success(let itunes):
                self.viewModel.listViewModels = itunes.musics
            case .failure(let error):
                self.viewModel.error = error
            }
        }
    }
}
