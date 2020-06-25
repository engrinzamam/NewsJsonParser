//
//  NewsCell.swift
//  NewsJsonParser
//
//  Created by engrInzamamulhaq on 25/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsHeadline: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var new: News! {
        didSet {
            self.newsHeadline.text = self.new.title != "" ? self.new.title : "No headline"
            self.newsDescription.text = self.new.descriptionField != "" ? self.new.descriptionField : "No Description"
            DispatchQueue.main.async {
                self.newsImage.downloadImage(from: self.new.imageHref!) { imageNewsDownloaded in
                    DispatchQueue.main.async {
                        self.newsImage.layer.cornerRadius = 12
                        self.newsImage.clipsToBounds = true
                        self.newsImage.image = imageNewsDownloaded
                    }
                }
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
