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

    func configureCell(title: String, imgName: String = "") {
        filmTitle.text = title
        let imgNm = (imgName == "" ? title : imgName).lowercased()
        let img = UIImage(named: imgNm)
        self.imageBackground.setImageWithAlphaGradiant(image: img!)
    }

}
