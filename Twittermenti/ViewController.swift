//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let swifter = Swifter(consumerKey: "UrYwdEoYSm33RbPXEYeI5p0Ph", consumerSecret: "dzVl9dcm3sSwjXDa6Z9881d0eglqz4jeG4fp502dumnYItLSLT")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@China") { result, searchMetadata in
            print(result)
        } failure: { error in
            print("There was an error with the Twitter API request, \(error)")
        }

    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

