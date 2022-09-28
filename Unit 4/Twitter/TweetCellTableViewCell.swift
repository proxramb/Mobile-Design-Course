//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Olivia Razzo on 9/20/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    var favorited:Bool = false
    var tweetId:Int = -1
    
    
    @IBAction func favTweet(_ sender: Any) {
        
        let toBeFavorited = !favorited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId,
                                                   success: { self.setFavorite(isFavorited: true)},
                                                   failure: { (error) in print("Favorite did not succeed: \(error)")}
            )
            
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {self.setFavorite(isFavorited: false)},
                                                     failure: { (error) in print("Unfavorite did not succeed: \(error)")})
        }
        
    }
    
    
    func setRetweeted(  isRetweeted:Bool){
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    
    @IBAction func retweetAction(_ sender: Any) {
        
        TwitterAPICaller.client?.retweet(tweetId: tweetId,
                                         success: {self.setRetweeted(isRetweeted: true)},
                                         failure: { (error) in print("Error is retweeting: \(error)")})
        
    }
    
    
    func setFavorite(  isFavorited:Bool) {
        favorited = isFavorited
        if(favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
