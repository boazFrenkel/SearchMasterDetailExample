//
//  PhotosViewController.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 30/01/2021.
//

import UIKit
import SDWebImage

class PhotosViewController: UIViewController {
    @IBOutlet weak var photosTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    lazy var tableData = photosViewModel?.loadedFeed ?? []
    var photosViewModel: PhotosViewModel?
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.photosListTitle
        setupSearchBar()
        photosTable.delegate = self
        photosTable.dataSource = self
        photosTable.reloadData()
        bind()
    }
    
    //MARK: Private
    private func bind() {
        photosViewModel?.onLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.loadingIndicator.startAnimating()
            } else {
                self.loadingIndicator.stopAnimating()
            }
        }
        
        photosViewModel?.onPhotosLoaded = { photos in
            //self.photosTable.reloadData()
            //photosTable.alpha = 0
           // UIView.animate(withDuration: 0.6) {
            //    photosTable.alpha = 1.0
            //        }

            //guard let self = self else { return }
            //TODO: handle data
        }
    }
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = .prominent
        searchBar.searchTextField.backgroundColor = .white
        searchBar.barTintColor = .systemGray3
    }
    
}

extension PhotosViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        let model = tableData[indexPath.row]
        cell.descriptionLabel.text = model.description
        cell.thumbnailImage.sd_setImage(with: model.thumbnailURL)
        return cell
        
    }
}

extension PhotosViewController: UITableViewDelegate {
    
}

extension PhotosViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked() {
        guard let searchTerm = self.searchBar.text else { return }
        photosViewModel?.search(searchTerm)
    }
}
