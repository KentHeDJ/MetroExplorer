//
//  LandmarkTableViewCell.swift
//  metroexplorer
//
//  Created by Dejian He on 12/9/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit

class LandmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var landmarkNameLabel: UILabel!
    @IBOutlet weak var landmarkImage: UIImageView!
    @IBOutlet weak var landmarkAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
