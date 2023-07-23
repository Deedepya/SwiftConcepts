//
//  ViewController.swift
//  BackgroundTaskApp
//
//  Created by dedeepya reddy salla on 22/07/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var state: DownloadState = .cancel
        print(state)  //err: state + "value"
       let test = String(describing:state)
        print(test + "valeu")
        let swiftUIViewController = UIHostingController(rootView: DownloadQueueView())
        self.navigationController?.pushViewController(swiftUIViewController, animated: true)
         print(self.navigationController?.viewControllers)
        // Do any additional setup after loading the view.
    }


}

