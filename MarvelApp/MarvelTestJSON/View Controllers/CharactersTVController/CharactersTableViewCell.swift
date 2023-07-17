//
//  CharactersTableViewCell.swift
//  MarvelTestJSON
//
//  Created by Andrii Stetsenko on 19.09.2022.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var stickerView: UIView!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    func configure(url: String) {
        pictureImage.loadImageFrom(urlString: url)
    }

    /*
    func configure(url: String) {
        pictureImage.download(from: url)
    }
    */
}
