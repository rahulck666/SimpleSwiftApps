//
//  EDFileTableViewCell.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/7/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

class EDFileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fileImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configure(image:UIImage,title:String)  {
        self.titleLabel.text = title
        self.fileImageView.image = image
        
    }
    
}
