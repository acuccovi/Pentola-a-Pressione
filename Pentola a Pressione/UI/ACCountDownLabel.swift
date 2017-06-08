//
//  ACCountDownLabel.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 04/06/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

protocol ACCountDownLabelDelegate {
    func ACCountDownFinished()
}

class ACCountDownLabel: UILabel {

    private var timer = Timer()
    private var timeCount = TimeInterval()
    private var startTime = TimeInterval()
    var delegate: ACCountDownLabelDelegate?

    func start() {
        if !timer.isValid {
            startTime = NSDate.timeIntervalSinceReferenceDate
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
                let currentTime = NSDate.timeIntervalSinceReferenceDate
                var elapsedTime = currentTime - self.startTime
                if elapsedTime >= self.timeCount {
                    elapsedTime = self.timeCount
                    self.stop()
                    self.delegate?.ACCountDownFinished()
                }
                self.text = self.timeString(time: self.timeCount - elapsedTime)
            })
        }
    }

    func stop() {
        if timer.isValid {
            timer.invalidate()
        }
    }

    func setTimeLabel(seconds: Int) {
        timeCount = TimeInterval(seconds)
        text = timeString(time: timeCount)
    }

    func setTimeLabel(minutes: Int) {
        setTimeLabel(seconds: minutes * 60)
    }

    private func timeString(time: TimeInterval) -> String {
        var elapsedTime = time
        //calculate the minutes in elapsed time.
        let minutes = UIntMax(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        //calculate the seconds in elapsed time.
        let seconds = UIntMax(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        //find out the fraction of milliseconds to be displayed.
        let fraction = UIntMax(elapsedTime * 100)

        return String(format:"%02i:%02i.%02i", minutes, seconds, fraction)
    }
}
