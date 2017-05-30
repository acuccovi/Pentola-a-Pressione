//
//  ViewController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 24/05/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private let tableItemController = TableItemController.shared

    // MARK: - UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableItemController.getSections().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = tableItemController.getSections()[section]
        return tableItemController.getData()[sectionName]!.count;
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableItemController.getSections()[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return tableView.dequeueReusableCell(withIdentifier: "searchCell")!
        }

        let sectionName = tableItemController.getSections()[indexPath.section]
        let rows = tableItemController.getData()[sectionName]

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
}
