//
//  VideoCell.swift
//  VideoTube
//
//  Created by Mehmet Tezcan on 6.06.2023.
//
import UIKit
import SDWebImage
import Firebase

class VideoCell: UITableViewCell {
    
        let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
   
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0 // Birden fazla satır için
        label.lineBreakMode = .byWordWrapping // Kelime bazında kırma
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.systemFont(ofSize: 13) //
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.systemFont(ofSize: 13)  //
        return label
    }()
                           
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(authorLabel)
        
        // thumbnailImageView için constraintler
        // thumbnailImageView için constraintler
       NSLayoutConstraint.activate([
                   thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                   thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                   thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                   thumbnailImageView.widthAnchor.constraint(equalToConstant: 220), // Genişlik değeri 220
                   thumbnailImageView.heightAnchor.constraint(equalToConstant: 150)
       ])
        
        // titleLabel için constraintler
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -65),
        ])
        
        // dateLabel için constraintler
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
        ])
        
        // authorLabel için constraintler
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            authorLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

        required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with video: YItem) {
            titleLabel.text = video.title
            dateLabel.text = video.pubDate
            authorLabel.text = video.author
            // SDWebImage kütüphanesiyle resmi indirip gösterme
        if let url = URL(string: video.thumbnail!) {
            thumbnailImageView.sd_setImage(with: url, completed: nil)
            }
        }
}
