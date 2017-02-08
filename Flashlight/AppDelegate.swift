//
//  AppDelegate.swift
//  Flashlight
//
//  Created by Nicolas Roth on 8/20/16.
//  Copyright © 2016 Nic Roth. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        turnTorchOn()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        turnTorchOn()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        turnTorchOn()
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
    }
}

