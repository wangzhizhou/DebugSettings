//
//  ViewController.swift
//  Demo
//
//  Created by joker on 2022/11/22.
//

import UIKit
import DebugSettings

class ViewController: UIViewController {

    @IBAction func showDebugTools(_ sender: UIBarButtonItem) {
        
        DebugSettingsDemo.mainPage().pushOnTopViewController()
    }
}

