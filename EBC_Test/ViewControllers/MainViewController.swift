//
//  MainViewController.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/9.
//

import UIKit
import SnapKit
import Foundation
import SVProgressHUD

class MainViewController: UIViewController {

    var searchController: UISearchController!
    var collectionView: UICollectionView?

    private var controller = MusicListController()
    private var viewModel: MusicListViewModel {
        self.controller.viewModel
    }
    private var timer: Timer?
    private var searchMusicName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Apple Music itunes"
        view.backgroundColor = .white
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
//        definesPresentationContext = true
        self.setUI()
        self.initBinding()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.controller.searchMusic(musicName: "jason mars")
        }
    }

    private func setUI() {
        self.setCollectionView()
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout {
            $0.scrollDirection = .vertical
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        let collectionView = UICollectionView(layout: layout) {
            $0.backgroundColor = .white
            $0.myRegister(cells: [MusicCell.self])
            $0.delegate = self
            $0.dataSource = self
        }
        self.collectionView = collectionView
        self.view.addSubview(collectionView)
        
        self.collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }
    
    private func initBinding() {
        self.controller.viewModel.$isLoading { [weak self] isLoading in
            if isLoading {
                SVProgressHUD.show(withStatus: "搜尋中...")
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        self.controller.viewModel.$listViewModels { [weak self] _ in
            self?.collectionView?.reloadData()
        }
    }
    
    @objc private func searchMusic() {
        guard let musicName = self.searchMusicName, !musicName.isEmpty else { return }
        self.controller.searchMusic(musicName: musicName)
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.timer?.invalidate()
        self.searchMusicName = searchController.searchBar.text
        self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.searchMusic), userInfo: nil, repeats: false)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.listViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.myDequeueReusableCell(cell: MusicCell.self, forIndexPath: indexPath)
        let music = self.viewModel.listViewModels[indexPath.row]
        cell.setMusic(music)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2.0
    }
}

class MusicListController {
    
    var viewModel: MusicListViewModel
    
    init(viewModel: MusicListViewModel = MusicListViewModel()) {
        self.viewModel = viewModel
    }
    
    func start() {
        self.viewModel.isLoading = true
    }
    
    func searchMusic(musicName: String) {
        self.viewModel.isLoading = true
        APIManager.shared.request(req: ItunesEndPoint.searchMusic(musiceName: musicName)) { (result: Result<Itunes, Error>) in
            self.viewModel.isLoading = false
            switch result {
            case .success(let itunes):
                self.viewModel.listViewModels = itunes.musics
            case .failure(let error):
                print("Search failed: \(error.localizedDescription)")
            }
        }
    }
}

