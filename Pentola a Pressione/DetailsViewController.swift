//
//  DetailsViewController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 04/06/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit
import AVFoundation

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var label: ACCountDownLabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var startStopButton: UIButton!

    private var model: ProductTableItem?
    private var timerStarted = false
    private var shouldEnableSlider = true

    // MARK: - UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let model = model {
            titleLabel.text = model.toString()
            let time = model.maxTime != nil ? model.maxTime! - ((model.maxTime! - model.minTime) / 2) : model.minTime
            slider.minimumValue = Float(model.minTime)
            slider.maximumValue = model.maxTime != nil ? Float(model.maxTime!) : Float(model.minTime)
            slider.value = Float(time)
            if slider.minimumValue == slider.maximumValue {
                slider.minimumValue -= 1
                slider.maximumValue += 1
                shouldEnableSlider = false
            }
            setLabelValue()
            label.delegate = self
            slider.isEnabled = shouldEnableSlider
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        label.stop()
    }

    // MARK: - IBAction
    @IBAction func sliderValueChanged(_ sender: UISlider, forEvent event: UIEvent) {
        sender.value = Float(Int(sender.value))
        setLabelValue()
    }

    @IBAction func startStopButtonTapped(_ sender: UIButton, forEvent event: UIEvent) {
        startStop()
    }

    // MARK: - Utility
    func setModel(_ model: ProductTableItem) {
        self.model = model
    }

    fileprivate func setLabelValue() {
        label.setTimeLabel(seconds: Int(slider.value) * 60)
    }

    fileprivate func startStop() {
        var buttonTitle: String
        if timerStarted {
            buttonTitle = "Start"
            label.stop()
        } else {
            buttonTitle = "Stop"
            label.start()
        }
        startStopButton.setTitle(buttonTitle, for: .normal)
        slider.isEnabled = timerStarted ? shouldEnableSlider : timerStarted
        timerStarted = !timerStarted
    }

}

extension DetailsViewController: ACCountDownLabelDelegate {

    func ACCountDownFinished() {
        startStop()
        if NotificationsController.shared.notifiedLocally {
            NotificationsController.shared.removeLocalNotification()
            self.navigationController?.popViewController(animated: true)
        } else {
            NotificationsController.shared.notifyWithAlert(usingViewController: self)
        }
    }
}
