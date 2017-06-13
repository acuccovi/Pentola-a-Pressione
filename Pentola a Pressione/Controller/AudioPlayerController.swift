//
//  AudioPlayerController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 09/06/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class AudioPlayerController: NSObject {

    private var avPlayer = AVPlayer()

    //singleton, we need only one instance of AudioPlayerController
    static let shared: AudioPlayerController = {
        return AudioPlayerController()
    }()

    private override init() {
    }

    // MARK: - utilities
    private func isAudio(_ file: URL) -> Bool {
        var result: Bool = false
        do {
            let resourceValues = try file.resourceValues(forKeys: [URLResourceKey.isRegularFileKey, URLResourceKey.typeIdentifierKey])
            if resourceValues.isRegularFile! && UTTypeConformsTo(resourceValues.typeIdentifier! as CFString, "public.audio" as CFString) {
                result = true
            }
        } catch _ {
        }
        return result
    }


    // MARK: - public func
    public func setAudioUrl(_ audioUrl: URL) {
        avPlayer = AVPlayer(url: audioUrl)
    }

    public func getAudioFiles() -> [URL] {
        var files = [URL]()
        FileManager.default.enumerator(at: Bundle.main.resourceURL!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) { (url, error) -> Bool in
            return true
        }?.forEach({ (url) in
            if let url = url as? URL, isAudio(url) {
                files.append(url)
            }
        })
        return files
    }

    public func play() {
        avPlayer.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem, queue: nil, using: { _ in
            self.avPlayer.seek(to: kCMTimeZero)
            self.avPlayer.play()
        })

    }

    public func stop() {
        avPlayer.pause()
        avPlayer.seek(to: kCMTimeZero)
    }
}
