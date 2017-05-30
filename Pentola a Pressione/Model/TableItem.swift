//
//  TableItem.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 29/05/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class TableItem: NSObject {
    let title: String
    let minTime: Int
    let maxTime: Int?

    init(withTitle title: String, minTime: Int, maxTime: Int) {
        self.title = title
        self.minTime = minTime
        self.maxTime = maxTime
    }

    init(withTitle title: String, minTime: Int) {
        self.title = title
        self.minTime = minTime
        self.maxTime = nil
    }
}
