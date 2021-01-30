//
//  PhotosViewController.swift
//  SearchViewTest
//
//  Created by Boaz Frenkel on 30/01/2021.
//

import UIKit

class PhotosViewController: UITableViewController {
    var resultSearchController = UISearchController()
    let tableData = ["One"]//,"Two","Three","Twenty-One"]
    var filteredTableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home Assignment"
        setupSearchBar()
        tableView.reloadData()
    }
    
    private func setupSearchBar() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            tableView.tableHeaderView = controller.searchBar
            controller.automaticallyShowsCancelButton = false
            controller.automaticallyShowsSearchResultsController = false
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.searchBarStyle = .prominent
            controller.searchBar.searchTextField.backgroundColor = .white
            
            tableView.tableHeaderView?.backgroundColor = .white
            controller.searchBar.isOpaque = false
            controller.searchBar.isTranslucent = false
            controller.searchBar.barTintColor = .lightGray
            return controller
        })()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return tableData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchImageCell", for: indexPath)
        return cell
        
    }
}

extension PhotosViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
