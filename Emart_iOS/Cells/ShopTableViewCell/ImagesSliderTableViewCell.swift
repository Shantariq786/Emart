
import UIKit
import Kingfisher

class imageCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var imageview:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageview.image = UIImage(named: "delivero_logo")!
    }
    
    func setImage(sliderImage:SliderImages){
        let fullSrtUrl = "\(BASEURL.imageUrl)\(sliderImage.image!)"
        let url = URL(string: fullSrtUrl)!

        imageview.kf.setImage(with:url)
    }
    
}


class ImagesSliderTableViewCell:UITableViewCell{
    @IBOutlet weak var pageControll:UIPageControl!
    @IBOutlet weak var sliderCollectionView:UICollectionView!
    var timer = Timer()
    var counter = 0
    var imageUrlArray:[SliderImages]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        fetchSliderImages()
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
    func fetchSliderImages(){
        APIService.sharedInstance.fetchSliderImages(parameters: [:]) { model in
            if model.error == false{
                self.imageUrlArray = model.records
                self.pageControll.numberOfPages  = self.imageUrlArray!.count
                self.sliderCollectionView.reloadData()
            }
        } failure: { (error) -> (Void) in

        }
    }
    @objc func changeImage(){
        guard let imageUrlCount = imageUrlArray?.count else {return}
        if counter<imageUrlCount{
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControll.currentPage = counter
            counter += 1
        }else{
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControll.currentPage = counter
        }
        
    }
    
}

extension ImagesSliderTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageUrlArray?.count ?? 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCollectionViewCell
        cell.setImage(sliderImage: imageUrlArray![indexPath.row])
        return cell
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: screenWidth, height: 200)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let indepath = getIndexPath(){
            pageControll.currentPage = indepath.item
        }
    }
    
    func getIndexPath()->IndexPath?{
        var visibleRect = CGRect()
        visibleRect.origin = sliderCollectionView.contentOffset
        visibleRect.size = sliderCollectionView.bounds.size
        let visiblePoint = CGPoint(x: CGFloat(visibleRect.midX), y: CGFloat(visibleRect.midY))
        let visibleIndexPath: IndexPath? = sliderCollectionView.indexPathForItem(at: visiblePoint)
        return visibleIndexPath
    }
    
    
    
}



