//
//  MusicListViewModel.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/10.
//

import Foundation

class MusicListViewModel {
    
    @Observable(queue: .main)
    var isLoading = false
    
    @Observable(queue: .main)
    var listViewModels = [Music]()
    
    @Observable(queue: .main)
    var error: Error? = nil
}
