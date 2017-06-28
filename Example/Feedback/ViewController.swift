//
//  ViewController.swift
//  Feedback
//
//  Created by Kane Cheshire on 06/27/2017.
//  Copyright (c) 2017 Kane Cheshire. All rights reserved.
//

import UIKit
import AVFoundation
import Feedback




class ViewController: UIViewController {


    
    @IBAction func selectionTapped(_ sender: Any) {
        selection.generateFeedback()
        selection.prepareForUse()
//        custom.generateFeedback()
    }
    
    @IBAction func lightTapped(_ sender: Any) {
        light.generateFeedback()
        light.prepareForUse()
    }
    
    @IBAction func mediumTapped(_ sender: Any) {
        medium.generateFeedback()
        medium.prepareForUse()
    }
    
    @IBAction func heavyTapped(_ sender: Any) {
        heavy.generateFeedback()
        heavy.prepareForUse()
    }
    
    @IBAction func successTapped(_ sender: Any) {
        success.generateFeedback()
        success.prepareForUse()
    }
    
    @IBAction func errorTapped(_ sender: Any) {
        error.generateFeedback()
        error.prepareForUse()
    }
    
    @IBAction func warningTapped(_ sender: Any) {
        warning.generateFeedback()
        warning.prepareForUse()
    }
    
    let selection = Feedback(hapticType: .selection, soundType: .selection)
    let light = Feedback(hapticType: .impact(.light), soundType: .impact(.light))
    let medium = Feedback(hapticType: .impact(.medium), soundType: .impact(.medium))
    let heavy = Feedback(hapticType: .impact(.heavy), soundType: .impact(.heavy))
    let success = Feedback(hapticType: .notification(.success), soundType: .notification(.success))
    let error = Feedback(hapticType: .notification(.error), soundType: .notification(.error))
    let warning = Feedback(hapticType: .notification(.warning), soundType: .notification(.warning))
    let custom = Feedback(hapticType: nil, soundType: .custom(soundName: "custom", extension: "m4a"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selection.prepareForUse()
    }

}

