//
//  PropsNavigationCell.swift
//  StarWarsPojectGuide
//
//  Created by RICHARD MONSON-HAEFEL on 11/9/17.
//  Copyright © 2017 RICHARD MONSON-HAEFEL. All rights reserved.
//

import UIKit

internal class PropsNavigationCell: UITableViewCell {

    static let identifier: String = "PropsNavigationCell"

    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
