//
//  SliderTableViewCell.swift
//  EMart
//
//  Created by Asad Khan on 5/10/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {

    var counter = 0
    var timer = Timer()
    @IBOutlet var SliderCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    var sliderRecords:[showSliderRecords]?
    override func awakeFromNib() {
        super.awakeFromNib()
        SliderCollectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCollectionViewCell")
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupData(records: [showSliderRecords]?) {
        self.sliderRecords = records
        pageControl.numberOfPages = self.sliderRecords?.count ?? 0
        self.SliderCollectionView.reloadData()
    }
}
extension SliderTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sliderRecords?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        cell.setupData(record: self.sliderRecords?[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:SliderCollectionView.frame.width  , height: SliderCollectionView.frame.height  )
    }
}

extension SliderTableViewCell {
    
    @objc func changeImage() {
        if counter < sliderRecords?.count ?? 0 {
            let index = IndexPath.init(item: counter, section: 0)
            self.SliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.SliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
            counter = 1
        }
        
    }
}
