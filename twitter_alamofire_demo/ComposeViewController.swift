//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Chase Warren on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.af_setImage(withURL: URL(string: (User.current!.profileImageURL))!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "What's happening?" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        if textView.text == "" {
            textView.textColor = UIColor.lightGray
            textView.text = "What's happening?"
        } else {
            textView.textColor = UIColor.black
        }
    }

    
    
    @IBAction func onTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: textView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
