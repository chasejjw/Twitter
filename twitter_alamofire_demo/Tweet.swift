import Foundation

class Tweet {
    
    var id: Int64?
    var text: String?
    var favoriteCount: Int?
    var favorited: Bool?
    var retweetCount: Int?
    var retweeted: Bool?
    var user: User?
    var createdAtString: String
    

    init(dictionary: [String: Any]) {
        id = dictionary["id"] as? Int64
        text = dictionary["text"] as? String ?? ""
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as? Int
        retweeted = dictionary["retweeted"] as? Bool
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        let date = formatter.date(from: createdAtOriginalString)!
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        createdAtString = formatter.string(from: date)
    }
    
    
    static func tweets(with array: [[String: Any]]) -> [Tweet] {
        var tweets: [Tweet] = []
        for tweetDictionary in array {
            let tweet = Tweet(dictionary: tweetDictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
}

