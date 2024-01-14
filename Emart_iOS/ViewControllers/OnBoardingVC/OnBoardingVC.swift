//
//  OnBoardingVC.swift
//  EMart
//
//  Created by Asad Khan on 6/8/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class OnBoardingVC: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
   
    var slides = [#imageLiteral(resourceName: "Datingtable"),#imageLiteral(resourceName: "Pizza"),#imageLiteral(resourceName: "deliveryBoy")]
    var Title  = ["Find  a Restaurant or Shop","Pick The Food","Get Fastest Delivery"]
    var Description = ["Fastest operation to provide food by the fence","Fastest operation to provide food by the fence","Fastest operation to provide food by the fence"]
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderCollectionView.isPagingEnabled = true
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
    }
    
    @IBAction func nextClicked(_ sender: UIButton){
        if currentPage == slides.count  {
            print("Go to next")
        }
        else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
//    @IBAction func skipClicked(_ sender: UIButton){
//
//    }
}
extension OnBoardingVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoardCollectionViewCell", for: indexPath) as! onBoardCollectionViewCell
         // UIScreen.main.bounds.width
        cell.sliderImageView.image = slides[indexPath.row]
        cell.descriptionLabel.text = Description[indexPath.row]
        cell.titleLabel.text = Title[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat =  UIScreen.main.bounds.width
        return CGSize(width: cellWidth-32, height: 483)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}
