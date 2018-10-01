//
//  HackerNewsTableViewCell.swift
//  HackerNews
//
//  Created by Abhinav Tirath on 3/6/18.
//  Copyright © 2018 LearningSwift. All rights reserved.
//

import UIKit

class HackerNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var articleVote: UILabel!
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var articleTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var articleCommentButton: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
