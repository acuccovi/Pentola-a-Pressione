//
//  AudioFileTableItemController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 10/06/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class AudioFileTableItemController: NSObject {
    //holds all the AudioFile
    private(set) var audioFiles = [AudioFileTableItem]()

    //singleton, we need only one instance of TableItemController
    static let shared: AudioFileTableItemController = {
        return AudioFileTableItemController()
    }()

    private override init() {
        for url in AudioPlayerController.shared.getAudioFiles() {
            let title = url.deletingPathExtension().lastPathComponent
            audioFiles.append(AudioFileTableItem(withTitle: title, path: url))
        }
    }
    
}
