//
//  CommentCell.swift
//  instagram-client
//
//  Created by Norman Yu on 4/9/15.
//  Copyright (c) 2015 Norman Yu. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
