//
//  PhotosViewController.swift
//  instagram-client
//
//  Created by Norman Yu on 4/9/15.
//  Copyright (c) 2015 Norman Yu. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var photos: NSArray = []
    @IBOutlet weak var tableView: UITableView!
    var refresher:UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        refresh()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 320
        
        self.tableView.insertSubview(refresher, atIndex: 0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        refresher.beginRefreshing()
        
        var clientId = "523bc00593e94db78700ec5358c5a17b"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.photos = responseDictionary["data"] as NSArray
            self.tableView.reloadData()
            
            self.refresher.endRefreshing()
        }
        
        NSLog("in refresher")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath:indexPath) as PhotoCell
        
        //var imagesDict = photos[indexPath.row]["images"] as NSDictionary
        //NSLog("%@", imagesDict)
        var url = photos[indexPath.row].valueForKeyPath("images.thumbnail.url") as? String
        println(url)
        cell.posterView.setImageWithURL(NSURL(string: url!)!)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
        var userPhoto = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 30))
        
        var userName = UILabel(frame: CGRect(x: 50, y: 5, width: 200, height: 30))
        
        userName.text = photos[section].valueForKeyPath("user.username") as? String
        
        var url = photos[section].valueForKeyPath("user.profile_picture") as? String
        userPhoto.setImageWithURL(NSURL(string:url!)!)
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        headerView.addSubview(userPhoto)
        headerView.addSubview(userName)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var vc = segue.destinationViewController as PhotoDetailsViewController
        
        var indexPath = tableView.indexPathForCell(sender as UITableViewCell)!
        vc.photo = photos[indexPath.row] as NSDictionary
    }
    

}
