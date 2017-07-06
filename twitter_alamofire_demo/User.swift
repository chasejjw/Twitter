import Foundation

class User {
    
    var dictionary: [String: Any]?
    var name: String = ""
    var screenName: String = ""
    var profileBannerURL: String = ""
    var profileImageURL: String = ""
    var description: String = ""
    private static var _current: User?
    
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String ?? ""
        screenName = dictionary["screen_name"] as? String ?? ""
        profileBannerURL = dictionary["profile_banner_url"] as? String ?? ""
        profileImageURL = dictionary["profile_image_url_https"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
    }
}
