//
//  ViewController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 24/05/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    fileprivate let productTableItemController = ProductTableItemController.shared
    fileprivate var data = [String : [ProductTableItem]]()
    fileprivate var selectedItem: ProductTableItem?

    // MARK: - UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        data = productTableItemController.getData("")
        tableView.reloadData()
        hideSearchBar(false)
    }

    override func viewDidAppear(_ animated: Bool) {
        selectedItem = nil
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var result = true
        if identifier == "timerSegue" {
            result = selectedItem != nil
        }
        return result
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            destination.setModel(selectedItem!)
        }
    }

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return productTableItemController.getSections().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = productTableItemController.getSections()[section]
        return data[sectionName]!.count
    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return productTableItemController.getSections()[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }

        if let row = getItem(indexPath){
            cell.textLabel?.text = row.title
            if let detailTextLabel = cell.detailTextLabel {
                detailTextLabel.text = row.toString()
            }
        }
        return cell
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = getItem(indexPath)
        performSegue(withIdentifier: "timerSegue", sender: nil)
    }

    // MARK: - Utility
    fileprivate func hideSearchBar(_ animated: Bool) {
        tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: UITableViewScrollPosition.top, animated: animated)
    }

    fileprivate func getItem(_ indexPath: IndexPath) -> ProductTableItem? {
        let sectionName = productTableItemController.getSections()[indexPath.section]
        let rows = data[sectionName]
        return rows?[indexPath.row]
    }

}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data = productTableItemController.getData(searchText)
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchBar(searchBar, textDidChange: "")
        hideSearchBar(true)
    }
    
}
