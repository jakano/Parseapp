//
//  DetailedViewController.swift
//  Parsetagram
//
//  Created by Jedidiah Akano on 6/23/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class DetailedViewController: UIViewController {
    @IBOutlet weak var detailPictureView: PFImageView!
    @IBOutlet weak var detailCaptionLabel: UILabel!
    @IBOutlet weak var detailTimeStampLabel: UILabel!
    var post: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let caption = post!["caption"] as! String
        let createdAt = post!["creationTime"] as! NSDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle

        //dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let timeStamp = dateFormatter.stringFromDate(createdAt)
        self.detailTimeStampLabel.text = timeStamp
        self.detailPictureView.file = post!["media"] as? PFFile
        self.detailPictureView.loadInBackground()
        self.detailCaptionLabel.text = caption
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
