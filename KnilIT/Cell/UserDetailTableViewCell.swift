//
//  UserDetailTableViewCell.swift
//  KnilIT
//
//  Created by Manickam T on 24/02/21.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

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
