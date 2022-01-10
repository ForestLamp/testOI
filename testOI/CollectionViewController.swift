//
//  CollectionViewController.swift
//  testOI
//
//  Created by Alex Ch. on 04.01.2022.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    private var photos = [GoogleImageResult]()
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    let countCells = 4
    let offset: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView()
    }
// MARK: - Setup UI elements
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseId)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Test app for Very Interesting"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0.4980392157, blue: 0.4980392157, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
// MARK: - UICollectionViewDataSourse, UICillectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseId, for: indexPath) as! PhotosCell
        let googleImage = photos[indexPath.item]
        cell.googleImage = googleImage
        return cell
    }
}
// MARK: - UISearchBarDelegate
    
    extension CollectionViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print(searchText)
            
            timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (_) in
                self.networkDataFetcher.fetchImages(searhTerm: searchText) {[weak self](searchResults) in
                    guard let fetchedPhotos = searchResults else { return }
                    self?.photos = fetchedPhotos.imageResults
                    self?.collectionView.reloadData()
                }
            })

        }
    }

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offset * 2))
    }
    
}
