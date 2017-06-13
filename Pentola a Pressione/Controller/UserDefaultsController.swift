//
//  UserDefaultsController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 10/06/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class UserDefaultsController: NSObject {
    private let userDefaults = UserDefaults.standard

    //singleton, we need only one instance of AudioPlayerController
    static let shared: UserDefaultsController = {
        return UserDefaultsController()
    }()

    private override init() {
    }

    public func saveAudioFile(_ audioFile: URL) {
        userDefaults.set(audioFile, forKey: "audioFile")
    }

    public func getAudioFile() -> URL {
        let audioFile: URL
        if let audioFile1 = userDefaults.url(forKey: "audioFile") {
            audioFile = audioFile1
        } else {
            audioFile = AudioPlayerController.shared.getAudioFiles().first!
        }
        return audioFile
    }

}
