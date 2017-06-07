//
//  DetailsViewController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 04/06/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var label: ACCountDownLabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var startStop: UIButton!

    private var model: TableItem?
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

    @IBAction func startStopTapped(_ sender: UIButton, forEvent event: UIEvent) {
        stop()
    }

    // MARK: - Utility
    func setModel(_ model: TableItem) {
        self.model = model
    }

    private func setLabelValue() {
        label.setTimeLabel(seconds: Int(slider.value) * 60)
    }

    fileprivate func stop() {
        var buttonTitle: String
        if timerStarted {
            buttonTitle = "Start"
            label.stop()
        } else {
            buttonTitle = "Stop"
            label.start()
        }
        startStop.setTitle(buttonTitle, for: .normal)
        slider.isEnabled = timerStarted ? shouldEnableSlider : timerStarted
        timerStarted = !timerStarted
    }

}

extension DetailsViewController: ACCountDownLabelDelegate {

    func ACCountDownFinished() {
        stop()
        let alert = UIAlertController(title: "È pronto!", message: "Spegni il fuoco sotto la\nPentola a Pressione!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay! 😋", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
