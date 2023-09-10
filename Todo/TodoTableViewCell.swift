//
//  TodoTableViewCell.swift
//  Todo
//
//  Created by 三木　杏夏 on 2023/09/10.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, category: String){
        titleLabel.text = title
        categoryLabel.text = category
    }
    
}
