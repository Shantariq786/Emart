//
//  promotionsViewController.swift
//  Alamofire
//
//  Created by Apple on 31/01/2020.
//

import UIKit
import Alamofire
import SVProgressHUD


class promotionsViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    let reuseIdentifier = "cell"
    var dictionary: [String: String] = [:]
    var sliderDataa = [SliderImages]()
    @IBOutlet weak var promotioncollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSliderImages()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        promotioncollection.setCollectionViewLayout(layout, animated: true)
        // Do any additional setup after loading the view.
    }
    
    
    func fetchSliderImages(){
        APIService.sharedInstance.fetchSliderImages(parameters: [:]) { model in
            if model.error == false{
                self.sliderDataa = model.records!
                self.promotioncollection.reloadData()
            }
        } failure: { (error) -> (Void) in
            print("error while getting promotions ",error)
        }
    }
    
    
    @IBAction func PopNavigationController(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderDataa.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:promotionsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath ) as! promotionsCollectionViewCell
        cell.setImage(sliderImage: sliderDataa[indexPath.row])
        cell.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.shadowOpacity = 0.4
        
        // set image
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = promotioncollection.frame
        let height = collectionViewSize.height
        let width = collectionViewSize.width
        return CGSize(width: width - 10, height: ((width / 2) - 14))
    }
}


