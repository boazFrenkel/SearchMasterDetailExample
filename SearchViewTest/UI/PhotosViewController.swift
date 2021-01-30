//
//  PhotosViewController.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 30/01/2021.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet weak var photosTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let tableData = ["One","Two","Three","Twenty-One"]
    var filteredTableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home Assignment"
        photosTable.delegate = self
        photosTable.dataSource = self
        let spinner = UIRefreshControl()
        photosTable.addSubview(spinner)
        setupSearchBar()
        photosTable.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchImageCell", for: indexPath)
        return cell
        
    }
}

extension PhotosViewController: UITableViewDelegate {
    
}

extension PhotosViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
