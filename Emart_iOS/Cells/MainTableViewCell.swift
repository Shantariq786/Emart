//
//  MainTableViewCell.swift
//  EMart
//
//  Created by Asad Khan on 5/17/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet var mainCollectionView: UICollectionView!
    var resturentRecords:[showRestaurantsRecords]?
    override func awakeFromNib() {
        super.awakeFromNib()
        mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.contentView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 8)
//        self.contentView.dropShadowAllSides()
//        self.layoutIfNeeded()
    }
    
    func setupData(records: [showRestaurantsRecords]?) {
        self.resturentRecords = records
        self.mainCollectionView.reloadData()
    }
}
extension MainTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resturentRecords?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.setupData(record: self.resturentRecords?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.bounds.width - 40, height: mainCollectionView.frame.height)
    }
    
    
}
