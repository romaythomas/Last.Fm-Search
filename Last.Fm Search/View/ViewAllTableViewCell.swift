//
//  ViewAllTableViewCell.swift
//  Last.Fm Search
//
//  Created by Owner on 07/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit

class ViewAllTableViewCell: UITableViewCell {

    @IBOutlet weak var viewAllTracksButton: UIButton!
    @IBOutlet weak var viewAllAlbumsButton: UIButton!
    @IBOutlet weak var viewAllArtistButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
