//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TweetSentimentClassifier_model()
    
    let swifter = Swifter(consumerKey: "UrYwdEoYSm33RbPXEYeI5p0Ph", consumerSecret: "dzVl9dcm3sSwjXDa6Z9881d0eglqz4jeG4fp502dumnYItLSLT")

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func predictPressed(_ sender: Any) {
        
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang:"en", count: 100, tweetMode: .extended) { result, searchMetadata in
                
                var tweets = [TweetSentimentClassifier_modelInput]()
                
                for tweet in result.array! {
                    let tweetInput = TweetSentimentClassifier_modelInput(text: tweet["full_text"].string!)
                    tweets.append(tweetInput)
                }
                
                do {
                    let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                    
                    var sentimentScore = 0
                    
                    for pred in predictions {
                        let sentiment = pred.label
                        
                        if sentiment == "Pos" {
                            sentimentScore += 1
                        } else if sentiment == "Neg" {
                            sentimentScore -= 1
                        }
                    }
                    
                    if sentimentScore > 30 {
                        self.sentimentLabel.text = "😍"
                    } else if sentimentScore > 15 {
                        self.sentimentLabel.text = "☺️"
                    } else if -15 < sentimentScore {
                        self.sentimentLabel.text = "😌"
                    } else if sentimentScore < -30 {
                        self.sentimentLabel.text = "😫"
                    } else {
                        self.sentimentLabel.text = "😠"
                    }
                    
                } catch {
                    print("There is an error when making a predictio, \(error)")
                }
                
                
            } failure: { error in
                print("An error happened when using Twitter API, \(error)")
            }
        }
    
    }
    
}

