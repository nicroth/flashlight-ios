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
    var captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

    override func viewDidLoad() {
        super.viewDidLoad()
        turnTorchOn()
        updateButtonUIState()
    }
    
    @IBAction func tapToggleButton() {
        if captureDevice != nil && captureDevice.torchActive {
            turnTorchOn()
        } else {
            turnTorchOff()
        }
        updateButtonUIState()
    }
    
    func updateButtonUIState() {
        if captureDevice != nil && captureDevice.torchActive {
            toggleButton.setTitle("Turn Off", forState:UIControlState.Normal)
            toggleButton.setBackgroundImage(UIImage(named: "button_on"), forState: UIControlState.Normal)
        } else {
            toggleButton.setTitle("Turn On", forState:UIControlState.Normal)
            toggleButton.setBackgroundImage(UIImage(named: "button_off"), forState: UIControlState.Normal)
        }
    }
    
    func turnTorchOn() {
        if captureDevice != nil && captureDevice.hasTorch {
            do {
                try captureDevice.lockForConfiguration()
                try captureDevice.setTorchModeOnWithLevel(1)
                captureDevice.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    func turnTorchOff() {
        if captureDevice != nil && captureDevice.hasTorch {
            do {
                try captureDevice.lockForConfiguration()
                try captureDevice.setTorchModeOnWithLevel(0)
                captureDevice.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
}

