//
//  ViewController.swift
//  DojoMaps
//
//  Created by Fiaz Sami on 11/6/16.
//  Copyright © 2016 codingdojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var searchResultsTable: UITableView!
    var searchController: UISearchController!

    var searchResults = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.setupSearch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.searchResultsTable.frame = self.view.viewWithTag(10)!.frame
    }

    private func setupTableView() {
        self.searchResultsTable = UITableView()
        self.searchResultsTable.register(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        self.searchResultsTable.showsVerticalScrollIndicator = false
        self.searchResultsTable.isHidden = !self.searchResultsTable.isHidden
        self.searchResultsTable.delegate = self
        self.searchResultsTable.dataSource = self

        self.view.addSubview(self.searchResultsTable)
    }


    private func setupSearch() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true

        self.navigationItem.titleView = self.searchController.searchBar
    }

}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        cell.textLabel?.text = self.searchResults[indexPath.row]

        return cell
    }
}

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if searchText.characters.count > 0 {
                self.searchResults.append(searchText)
            }
        } else {
            self.searchResults.removeAll()
        }

        self.searchResultsTable.reloadData()
    }
}

extension ViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        self.searchResultsTable.isHidden = false
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        self.searchResultsTable.isHidden = true
        self.searchResults.removeAll()
    }
}
