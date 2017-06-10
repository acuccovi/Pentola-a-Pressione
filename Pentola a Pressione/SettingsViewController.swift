//
//  SettingsViewController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 10/06/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillDisappear(_ animated: Bool) {
        AudioPlayerController.shared.stop()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AudioFileTableItemController.shared.audioFiles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = AudioFileTableItemController.shared.audioFiles[indexPath.row].title

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audioFile = AudioFileTableItemController.shared.audioFiles[indexPath.row].path
        AudioPlayerController.shared.setAudioUrl(audioFile)
        AudioPlayerController.shared.play()
        UserDefaultsController.shared.saveAudioFile(audioFile)
    }

}
