//
//  MusicCell.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/9.
//

import UIKit
import Kingfisher

class MusicCell: UICollectionViewCell {
    
    private var coverImageView = UIImageView {
        $0.contentMode = .scaleAspectFit
    }
    
    private var longDescription = UILabel {
        $0.numberOfLines = 0
    }
    
    private var spaceLineView = UIView {
        $0.backgroundColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        self.setConstrints()
    }
    
    private func setUI() {
        self.contentView.addSubview(coverImageView)
        self.contentView.addSubview(longDescription)
        self.contentView.addSubview(spaceLineView)
    }
    
    private func setConstrints() {
        self.coverImageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(4)
            $0.height.equalTo(100)
        }
        
        self.longDescription.snp.makeConstraints {
            $0.left.equalTo(8)
            $0.right.equalTo(-8)
            $0.top.equalTo(coverImageView.snp.bottom).offset(8)
            $0.bottom.equalTo(-8)
        }
        
        self.spaceLineView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    func setMusic(_ music: Music) {
        if let url = URL(string: music.artworkUrl100) {
            self.coverImageView.kf.setImage(with: url)
        } else {
            self.coverImageView.image = nil
        }
        self.longDescription.text = music.longDescription
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        longDescription.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
