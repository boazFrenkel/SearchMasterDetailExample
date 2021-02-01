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
    var tableData: [PhotoItem] { return photosViewModel?.loadedFeed ?? [] }
    var photosViewModel: PhotosViewModel?
    var selectedPhoto: ((PhotoItem) -> Void)?
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.photosListTitle.capitalized
        setupNavigationItem()
        setupSearchBar()
        setupTable()
        bind()
    }
    
    //MARK: Private
    private func setupNavigationItem() {
        let backItem = UIBarButtonItem()
        backItem.title = Constants.back.capitalized
        navigationItem.backBarButtonItem = backItem
    }
    
    private func setupTable() {
        photosTable.alpha = 0
        photosTable.delegate = self
        photosTable.dataSource = self
        photosTable.reloadData()
    }
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = .prominent
        searchBar.searchTextField.backgroundColor = .white
        searchBar.barTintColor = .systemGray3
        searchBar.delegate = self
    }
    
    private func bind() {
        photosViewModel?.onLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.loadingIndicator.startAnimating()
            } else {
                self.loadingIndicator.stopAnimating()
            }
        }
        
        photosViewModel?.onPhotosLoaded = {[weak self] photos in
            guard let self = self else { return }
            self.photosTable.reloadData()
            self.photosTable.alpha = 0
            UIView.animate(withDuration: 0.6) {
                self.photosTable.alpha = 1.0
            }
        }
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
        cell.thumbnailImage.sd_imageTransition = .fade
        cell.thumbnailImage.sd_setImage(with: model.thumbnailURL)
        return cell
    }
}

extension PhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = tableData[indexPath.row]
        selectedPhoto?(model)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PhotosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = self.searchBar.text else { return }
        searchBar.resignFirstResponder()
        photosViewModel?.search(searchTerm)
    }
    
}
