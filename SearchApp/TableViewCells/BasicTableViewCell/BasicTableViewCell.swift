//
//  BasicTableViewCell.swift
//  SearchApp
//
//  Created by Mehmet Baturay Yasar on 04/06/2022.
//

import UIKit

protocol BasicTableViewCellDelegate {
    func didSelectButton(code:String)
}

class BasicTableViewCell: UITableViewCell {

    @IBOutlet weak var labelOutlet: UILabel!
    var delegate:BasicTableViewCellDelegate?
    
    var country: Country?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        delegate?.didSelectButton(code: country?.currency?.symbol ?? "")
    }
}
