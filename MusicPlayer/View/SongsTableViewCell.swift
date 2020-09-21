//
//  SongsTableViewCell.swift
//  MusicPlayer
//
//  Created by tantsunsin on 2020/8/18.
//  Copyright © 2020 tantsunsin. All rights reserved.
//

import UIKit

class SongsTableViewCell: UITableViewCell {

//    @IBOutlet weak var IndexLabel: UILabel!
//    @IBOutlet weak var NameLabel: UILabel!
    
    
    let IndexLabel = UILabel(frame: CGRect(x: 10, y: 15, width: 30, height: 20))
    let NameLabel = UILabel(frame: CGRect(x: 50, y: 15, width: 400, height: 20))
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(IndexLabel)
        self.contentView.addSubview(NameLabel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
