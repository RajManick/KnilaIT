//
//  MusicListCell.swift
//  Sample
//
//  Created by Manickam T on 07/11/20.
//

import UIKit

class MusicListCell: UITableViewCell {
    @IBOutlet weak var trackimgView: UIImageView!
    @IBOutlet weak var trackPrice: UILabel!
    @IBOutlet weak var trackNameLbl: UILabel!
    @IBOutlet weak var BgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
