import Foundation

class Tweet {
    
    var id: Int64?
    var text: String?
    var favoriteCount: Int = 0
    var favorited: Bool?
    var retweetCount: Int = 0
    var retweeted: Bool?
    var user: User?
    var age: String?
    

    init(dictionary: [String: Any]) {
        id = dictionary["id"] as? Int64
        text = dictionary["text"] as? String ?? ""
        favoriteCount = (dictionary["favorite_count"] as? Int)!
        favorited = dictionary["favorited"] as? Bool
        retweetCount = (dictionary["retweet_count"] as? Int)!
        retweeted = dictionary["retweeted"] as? Bool
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        let createdAt = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        let date = formatter.date(from: createdAt)!
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        age = date.getAge()
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

extension Date {
    
    func getAge() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        if let day = interval.day, day > 6 {
            let formatter = DateFormatter()
            formatter.dateFormat = "E MMM d HH:mm:ss Z y"
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            return formatter.string(from: self)
        } else if let day = interval.day, day > 0 {
            return "\(day)" + "d"
        } else if let hour = interval.hour, hour > 0 {
            return "\(hour)" + "h"
        } else if let minute = interval.minute, minute > 0 {
            return "\(minute)" + "m"
        } else {
            let second = interval.second
            return "\(second ?? 0)" + "s"
        }
        
    }
}

