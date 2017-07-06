//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            profileImage.af_setImage(withURL: URL(string: (tweet.user?.profileImageURL)!)!)
            nameLabel.text = tweet.user?.name
            screenNameLabel.text = "@" + (tweet.user?.screenName)!
            ageLabel.text = tweet.age
            let favorites = tweet.favoriteCount
            favoritesLabel.text = shortenCount(count: favorites)
            let retweets = tweet.retweetCount
            retweetsLabel.text = shortenCount(count: retweets)
            if tweet.favorited! {
                favoriteButton.setImage(#imageLiteral(resourceName: "favorited"), for: .normal)
                favoritesLabel.textColor = UIColor(hex: "cf3c61")
            } else {
                favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
                favoritesLabel.textColor = UIColor(hex: "6B7B87")

            }
            if tweet.retweeted! {
                retweetButton.setImage(#imageLiteral(resourceName: "retweeted"), for: .normal)
                retweetsLabel.textColor = UIColor(hex: "59ba6d")
            } else {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet"), for: .normal)
                retweetsLabel.textColor = UIColor(hex: "6B7B87")

            }
        }
    }
    
    func shortenCount(count: Int) -> String {
        if count < 0{
            return "0"
        }
        if count > 9999 {
            let shortened = Double(count)/1000.00
            let rounded = round(10.0 * shortened) / 10.0
            let shortened_string = "\(rounded)"
            if shortened_string.range(of:".0") != nil {
                let one_less = String(shortened_string.characters.dropLast())
                let two_less = String(one_less.characters.dropLast())
                return two_less + "K"
            }
            return "\(rounded)" + "K"
        }
        if count > 999 {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            return numberFormatter.string(from: NSNumber(value: count))!
        }
        return "\(count)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func onFavorite(_ sender: Any) {
        if self.tweet.favorited! == true {
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let _ = tweet {
                    self.tweet.favorited = false
                    self.tweet.favoriteCount -= 1
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
                    self.favoritesLabel.textColor = UIColor(hex: "6B7B87")
                    self.favoritesLabel.text = self.shortenCount(count: self.tweet.favoriteCount)
                    print("Successfully unfavorited the following Tweet: \n\(String(describing: self.tweet.text))")
                }
            }
        } else {
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let _ = tweet {
                    self.tweet.favorited = true
                    self.tweet.favoriteCount += 1
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "favorited"), for: .normal)
                    self.favoritesLabel.textColor = UIColor(hex: "cf3c61")
                    self.favoritesLabel.text = self.shortenCount(count: self.tweet.favoriteCount)
                    print("Successfully favorited the following Tweet: \n\(String(describing: self.tweet.text))")
                }
            }
        }
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        if self.tweet.retweeted! == true {
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let _ = tweet {
                    self.tweet.retweeted = false
                    self.tweet.retweetCount -= 1
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet"), for: .normal)
                    self.retweetsLabel.textColor = UIColor(hex: "6B7B87")
                    self.retweetsLabel.text = self.shortenCount(count: self.tweet.retweetCount)
                    print("Successfully unretweeted the following Tweet: \n\(String(describing: self.tweet.text))")
                }
            }

        } else {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let _ = tweet {
                    self.tweet.retweeted = true
                    self.tweet.retweetCount += 1
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweeted"), for: .normal)
                    self.retweetsLabel.textColor = UIColor(hex: "59ba6d")
                    self.retweetsLabel.text = self.shortenCount(count: self.tweet.retweetCount)
                    print("Successfully retweeted the following Tweet: \n\(String(describing: self.tweet.text))")
                }
            }
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
