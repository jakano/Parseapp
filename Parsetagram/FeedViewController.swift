//
//  FeedViewController.swift
//  Parsetagram
//
//  Created by Jedidiah Akano on 6/20/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var feedTable: FeedTableView!
    var posts: [PFObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTable.dataSource = self
        feedTable.delegate = self
        fetchPosts()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = feedTable.dequeueReusableCellWithIdentifier("prstagramCell", forIndexPath: indexPath) as! PrstagramViewCell
        return cell

    }
    func fetchPosts() {
        var query = PFQuery(className: "Post", predicate: nil)
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.posts = posts
                
            } else {
                print(error?.localizedDescription)
            }
        }
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
