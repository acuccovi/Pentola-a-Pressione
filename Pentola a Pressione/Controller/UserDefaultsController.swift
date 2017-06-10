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
        return userDefaults.url(forKey: "audioFile") ?? AudioPlayerController.shared.getAudioFiles().first!
    }

}
