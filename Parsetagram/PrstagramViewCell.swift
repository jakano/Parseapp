//
//  PrstagramViewCell.swift
//  Parsetagram
//
//  Created by Jedidiah Akano on 6/21/16.
//  Copyright © 2016 Jedidiah Akano. All rights reserved.
//

import UIKit

class PrstagramViewCell: UITableViewCell {
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
