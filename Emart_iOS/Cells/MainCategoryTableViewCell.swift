//
//  MainCategoryTableViewCell.swift
//  EMart
//
//  Created by Asad Khan on 5/17/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class MainCategoryTableViewCell: UITableViewCell {

    @IBOutlet var mainCategoryCollectionView: UICollectionView!
    var mainCategoryRecords:[showMainCategoryRecords]?
    override func awakeFromNib() {
        super.awakeFromNib()
        mainCategoryCollectionView.register(UINib(nibName: "ShowMainCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShowMainCategoryCollectionViewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 8)
        self.contentView.dropShadowAllSides()
        self.layoutIfNeeded()
    }
    func setupData(records: [showMainCategoryRecords]?) {
        self.mainCategoryRecords = records
        self.mainCategoryCollectionView.reloadData()
    }
    
}
extension MainCategoryTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainCategoryRecords?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowMainCategoryCollectionViewCell", for: indexPath) as! ShowMainCategoryCollectionViewCell
        cell.setupData(records: self.mainCategoryRecords?[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("asdfg")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let yourWidth = collectionView.bounds.width/3.0
          // let yourHeight = yourWidth

           return CGSize(width: 150, height: 54)
//        let bounds = UIScreen.main.bounds
//        let width = bounds.size.width
//        return CGSize(width: width/3-36, height: 180)
       // return CGSize(width: width/3-22.5, height: 180)
        //return CGSize(width: self.contentView.bounds.width - 40, height: mainCategoryCollectionView.frame.height)
    }
    
}
    
    

