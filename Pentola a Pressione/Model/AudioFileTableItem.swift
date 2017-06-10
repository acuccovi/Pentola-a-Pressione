//
//  AudioFileTableItem.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 10/06/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class AudioFileTableItem: NSObject {
    let title: String
    let path: URL

    init(withTitle title: String, path: URL) {
        self.title = title
        self.path = path
    }
    
}
