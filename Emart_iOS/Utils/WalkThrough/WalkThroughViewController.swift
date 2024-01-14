//
//  WalkThroughViewController.swift
//  Luxury
//
//  Created by Sheikh Yousaf on 24/12/2018.
//  Copyright © 2018 Sheikh Yousaf. All rights reserved.
//

import UIKit

class WalkThroughViewController: UIViewController,UIScrollViewDelegate {

    let walthroughImages=[#imageLiteral(resourceName: "Datingtable"),#imageLiteral(resourceName: "Pizza"),#imageLiteral(resourceName: "deliveryBoy")]
    var Title  = ["Find  a Restaurant or Shop","Pick The Food","Get Fastest Delivery"]
    let walkthroughText = ["Fastest operation to provide food by the fence","Fastest operation to provide food by the fence","Fastest operation to provide food by the fence"]

    
    var pager=UIPageControl()
    var pageNO=Float()
    var totalPages=Float()
    
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var nextBtn:UIButton!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var getStartedButton:UIButton!
    @IBOutlet weak var dotImageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        getStartedButton.isHidden = true
        backBtn.isHidden = true
        
        totalPages=Float(walkthroughText.count - 1 )
        
        
        scrollView.isPagingEnabled=true
        scrollView.contentSize=CGSize(width:self.view.bounds.width * CGFloat(walkthroughText.count) ,height:self.scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.delegate=self
        
        
        loadFeature()
        pager.numberOfPages=walkthroughText.count
        pager.currentPage=0
        pager.frame.origin.x=self.view.frame.width / 2
        pager.frame.origin.y=view.frame.height - 40
        pager.layer.borderWidth=3
        pager.layer.borderColor=UIColor.black.cgColor
        pager.pageIndicatorTintColor=UIColor.lightGray
        pager.currentPageIndicatorTintColor=UIColor.orange
        pager.isUserInteractionEnabled=true
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func loadFeature(){
        for (index,feature) in walthroughImages.enumerated(){
            if let slider=Bundle.main.loadNibNamed("Slider", owner: self, options: nil)?.first as? Slider{
                slider.Imageview.image=feature
                slider.titleLable.text = walkthroughText[index]
                scrollView.addSubview(slider)
                slider.frame.size.width=self.scrollView.frame.width
                slider.frame.size.height=scrollView.frame.height
                slider.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page=scrollView.contentOffset.x/scrollView.frame.size.width

        
        pager.currentPage=Int(page)
        pageNO=Float(page)

        if pageNO == 2.0 || pageNO > 2.0 || pageNO > 1.5 {
            nextBtn.isHidden = true
            backBtn.isHidden=true
            dotImageView.isHidden=true
            getStartedButton.isHidden=false
        }

        else {
            
            if pageNO == 1.0 || pageNO > 0.5 {
                backBtn.isHidden = false
                dotImageView.image = UIImage(named: "dot2")
            }
            else {
                dotImageView.image = UIImage(named: "dot1")
                backBtn.isHidden = true
            }
            
            nextBtn.isHidden = false
            dotImageView.isHidden=false
            getStartedButton.isHidden=true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
