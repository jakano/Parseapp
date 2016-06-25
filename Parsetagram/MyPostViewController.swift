//
//  MyPostViewController.swift
//  Parsetagram
//
//  Created by Jedidiah Akano on 6/23/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//


import UIKit
import Parse
import ParseUI
import MBProgressHUD

class MyPostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var feedTable: FeedTableView!
    var checked: Int = 0
    var posts: [PFObject]?
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTable.dataSource = self
        feedTable.delegate = self
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        feedTable.insertSubview(refreshControl, atIndex: 0)
        let frame = CGRectMake(0, feedTable.contentSize.height, feedTable.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        feedTable.addSubview(loadingMoreView!)
        
        var insets = feedTable.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        feedTable.contentInset = insets
        
        sortFeed()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = feedTable.dequeueReusableCellWithIdentifier("prstagramCell", forIndexPath: indexPath) as! PrstagramViewCell
        let post = posts![indexPath.row]
        
        let caption = post["caption"] as! String
        
        cell.pictureView.file = post["media"] as? PFFile
        cell.pictureView.loadInBackground()
        cell.captionLabel.text = caption
        return cell
        
    }
    func sortFeed() {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        
        query.whereKey("author", equalTo: PFUser.currentUser()!)
        query.limit = 20 + checked
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.posts = posts
                self.isMoreDataLoading = false
                self.loadingMoreView!.stopAnimating()
                self.feedTable.reloadData()
                
                
                // do something with the data fetched
            } else {
                print(error?.localizedDescription)
                // handle error
            }
        }
        
        
    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        sortFeed()
        feedTable.reloadData()
        refreshControl.endRefreshing()
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = feedTable.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - feedTable.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && feedTable.dragging) {
                
                isMoreDataLoading = true
                let frame = CGRectMake(0, feedTable.contentSize.height, feedTable.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                
                // Code to load more results
                self.checked += 20
                sortFeed()
            }
        }
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = feedTable.indexPathForCell(cell)
        let post = posts![indexPath!.row]
        let detailViewController = segue.destinationViewController as! DetailedViewController
        detailViewController.post = post
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
