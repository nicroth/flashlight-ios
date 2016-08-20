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
    }
    
    @IBAction func tapToggleButton() {
        if captureDevice != nil && captureDevice.torchMode == AVCaptureTorchMode.Off {
            turnTorchOn()
        } else {
            turnTorchOff()
        }
    }
    
    func turnTorchOn() {
        if captureDevice != nil && captureDevice.hasTorch {
            do {
                try captureDevice.lockForConfiguration()
                captureDevice.torchMode = AVCaptureTorchMode.On
                try captureDevice.setTorchModeOnWithLevel(AVCaptureMaxAvailableTorchLevel)
                captureDevice.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        toggleButton.setBackgroundImage(UIImage(named: "button_on"), forState: UIControlState.Normal)
    }
    
    func turnTorchOff() {
        if captureDevice != nil && captureDevice.hasTorch {
            do {
                try captureDevice.lockForConfiguration()
                captureDevice.torchMode = AVCaptureTorchMode.Off
                captureDevice.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        toggleButton.setBackgroundImage(UIImage(named: "button_off"), forState: UIControlState.Normal)
    }
}

