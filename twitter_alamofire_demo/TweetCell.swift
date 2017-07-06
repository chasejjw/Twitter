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
            }
            if tweet.retweeted! {
                retweetButton.setImage(#imageLiteral(resourceName: "retweeted"), for: .normal)
            }
        }
    }
    
    func shortenCount(count: Int) -> String {
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
        tweet.favorited = true
        tweet.favoriteCount += 1
        self.favoriteButton.setImage(#imageLiteral(resourceName: "favorited"), for: .normal)
        self.favoritesLabel.text = "\(tweet.favoriteCount)"
        
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(String(describing: tweet.text))")
            }
        }
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        tweet.retweeted = true
        tweet.retweetCount += 1
        self.retweetButton.setImage(#imageLiteral(resourceName: "retweeted"), for: .normal)
        self.retweetsLabel.text = "\(tweet.retweetCount)"

        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(String(describing: tweet.text))")
            }
        }
    }
}
