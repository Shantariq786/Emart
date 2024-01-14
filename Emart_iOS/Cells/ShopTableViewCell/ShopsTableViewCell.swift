import UIKit
import Kingfisher

protocol ShopCellProtocol{
    func shopCellTapped(indexPath:IndexPath)
}

class ShopCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var imageview:UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setData(category:CategoriesName){
        titleLabel.text = category.name
        
        let fullSrtUrl = "\(BASEURL.imageUrl)\(category.image_name ?? "")"
        let url = URL(string: fullSrtUrl)!
        let resource = ImageResource(
            downloadURL: url,
            cacheKey: category.id)

        imageview.kf.setImage(
            with: resource,
            placeholder: UIImage(named: "delivero_logo")!,
            options: nil,
            completionHandler: nil)
        
    }
    
}





class ShopsTableViewCell:UITableViewCell{
    
    var shopCellProtocol:ShopCellProtocol!
    
    @IBOutlet weak var shopsCollectionVIew:UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var mainCategories:[CategoriesName]?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shopsCollectionVIew.delegate = self
        shopsCollectionVIew.dataSource = self
    }
    
    
}



//MARK: -               COLLECTIONVIEW
extension ShopsTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopCell", for: indexPath) as! ShopCollectionViewCell
        cell.setData(category: mainCategories![indexPath.row])
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: screenWidth/5, height: screenWidth/5 + 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        shopCellProtocol.shopCellTapped(indexPath: indexPath)

        
    }
    
    
}




