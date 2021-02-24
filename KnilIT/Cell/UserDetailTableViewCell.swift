//
//  MusicDetailTableViewCell.swift
//  Sample
//
//  Created by Manickam T on 07/11/20.
//

import UIKit

class MusicDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var detailBGView: UIView!
    @IBOutlet weak var detailLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
