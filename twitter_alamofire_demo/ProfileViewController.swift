//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Chase Warren on 7/7/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet] = []
    
    @IBOutlet weak var grayView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: UIImageView!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var whiteBackgroundView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        APIManager.shared.getProfileTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        whiteBackgroundView.layer.cornerRadius = whiteBackgroundView.frame.size.width / 2
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        grayView.layer.cornerRadius = grayView.frame.size.width / 2
        bannerView.contentMode = .scaleAspectFill


        profileView.af_setImage(withURL: URL(string: (User.current?.profileImageURL)!)!)
        bannerView.af_setImage(withURL: URL(string: (User.current?.profileBannerURL)!)!)
        followersLabel.text = "\(User.current?.numFollowers ?? 0)"
        followingLabel.text = "\(User.current?.numFollowing ?? 0)"
        usernameLabel.text = "@" + (User.current?.screenName)!
        nameLabel.text = User.current?.name
        bioLabel.text = User.current?.description
        


    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        APIManager.shared.getProfileTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error refreshing home timeline: " + error.localizedDescription)
            }
            refreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
