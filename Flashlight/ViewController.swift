//
//  ViewController.swift
//  Flashlight
//
//  Created by Nicolas Roth on 8/20/16.
//  Copyright © 2016 Nic Roth. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var toggleButton: UIButton!
    var captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

    override func viewDidLoad() {
        super.viewDidLoad()
        turnTorchOn()
    }
    
    @IBAction func tapToggleButton() {
        if captureDevice != nil && captureDevice?.torchMode == AVCaptureTorchMode.off {
            turnTorchOn()
        } else {
            turnTorchOff()
        }
    }
    
    func turnTorchOn() {
        if captureDevice != nil && (captureDevice?.hasTorch)! {
            do {
                try captureDevice?.lockForConfiguration()
                captureDevice?.torchMode = AVCaptureTorchMode.on
                try captureDevice?.setTorchModeOnWithLevel(AVCaptureMaxAvailableTorchLevel)
                captureDevice?.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        toggleButton.setBackgroundImage(UIImage(named: "button_on"), for: UIControlState())
    }
    
    func turnTorchOff() {
        if captureDevice != nil && (captureDevice?.hasTorch)! {
            do {
                try captureDevice?.lockForConfiguration()
                captureDevice?.torchMode = AVCaptureTorchMode.off
                captureDevice?.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        toggleButton.setBackgroundImage(UIImage(named: "button_off"), for: UIControlState())
    }
}

