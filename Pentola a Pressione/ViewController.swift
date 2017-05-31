//
//  ViewController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 24/05/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    private let tableItemController = TableItemController.shared
    private var data = [String : [TableItem]]()

    // MARK: - UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        data = tableItemController.getData("")
    }

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableItemController.getSections().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = tableItemController.getSections()[section]
        return data[sectionName]!.count
    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableItemController.getSections()[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }

        let sectionName = tableItemController.getSections()[indexPath.section]
        let rows = data[sectionName]

        if let row = rows?[indexPath.row] {
            cell.textLabel?.text = row.title
            if let detailTextLabel = cell.detailTextLabel {
                if let maxTime = row.maxTime {
                    detailTextLabel.text = "\(row.minTime) - \(maxTime)"
                } else {
                    detailTextLabel.text = "\(row.minTime)"
                }
                detailTextLabel.text = "\((detailTextLabel.text)!) minuti"
            }
        }
        return cell
    }

    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data = tableItemController.getData(searchText)
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        data = tableItemController.getData("")
        tableView.reloadData()
    }
    
}
