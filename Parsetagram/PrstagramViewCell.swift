//
//  PrstagramViewCell.swift
//  Parsetagram
//
//  Created by Jedidiah Akano on 6/21/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit
import ParseUI

class PrstagramViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pictureView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        var instagramPost: PFObject! {
            didSet {
                self.pictureView.file = instagramPost["image"] as? PFFile
                self.pictureView.loadInBackground()
            }
        }
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
