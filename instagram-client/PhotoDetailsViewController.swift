//
//  PhotoDetailsViewController.swift
//  instagram-client
//
//  Created by Norman Yu on 4/9/15.
//  Copyright (c) 2015 Norman Yu. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var photo: NSDictionary!
    var comments :NSDictionary!
    
    @IBOutlet weak var posterView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        comments = photo["comments"] as NSDictionary
        // Do any additional setup after loading the view.
        
        var url = photo.valueForKeyPath("images.thumbnail.url") as? String
        posterView.setImageWithURL(NSURL(string: url!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photo.valueForKeyPath("comments.count") as NSInteger
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //if indexPath.row == 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath:indexPath) as CommentCell
        
            var url = photo.valueForKeyPath("images.thumbnail.url") as? String
            cell.posterView.setImageWithURL(NSURL(string: url!)!)
            return cell
        //}
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
