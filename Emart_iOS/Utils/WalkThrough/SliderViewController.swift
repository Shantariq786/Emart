//
//  SliderViewController.swift
//  SideMenu
//
//  Created by Sheikh Yousaf on 01/03/2018.
//  Copyright © 2018 Sheikh Yousaf. All rights reserved.
//
//
import UIKit
//
class SliderViewController: UIViewController,UIScrollViewDelegate {
    
    
    let walthroughImages=[#imageLiteral(resourceName: "Datingtable"),#imageLiteral(resourceName: "Pizza"),#imageLiteral(resourceName: "deliveryBoy")]
    var Title  = ["Find  a Restaurant or Shop","Pick The Food","Get Fastest Delivery"]
    let walkthroughText = ["Fastest operation to provide food by the fence","Fastest operation to provide food by the fence","Fastest operation to provide food by the fence"]

    
//    let arrayOfSlider=[#imageLiteral(resourceName: "one"),#imageLiteral(resourceName: "two"),#imageLiteral(resourceName: "three"),#imageLiteral(resourceName: "four"),#imageLiteral(resourceName: "five"),#imageLiteral(resourceName: "six")]
//    let webButton=UIButton()
//    let nextButton=UIButton()
//    var pager=UIPageControl()
    var pageNO=Float()
//    var totalPages=Float()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
//        print(self.view.frame.height)
//        totalPages=Float(arrayOfSlider.count - 1 )
//
//        webButton.frame=CGRect.init(x: 60, y: view.frame.height - 60, width: 40, height: 40)
//        nextButton.frame=CGRect.init(x: self.view.frame.width - 100, y: view.frame.height - 60, width: 40, height: 40)
        
     //   webButton.setTitle("hoola", for: .normal)
        
//        webButton.setImage(#imageLiteral(resourceName: "web"), for: .normal)
//
//        webButton.layer.cornerRadius = 20
//        webButton.clipsToBounds=true
//
//
//        webButton.backgroundColor=UIColor.black.withAlphaComponent(0.5)
//      //  nextButton.setTitle("hoola", for: .normal)
//        nextButton.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
//        nextButton.backgroundColor=UIColor.black.withAlphaComponent(0.5)
//        nextButton.layer.cornerRadius = 20
//        nextButton.clipsToBounds=true

        
        scrollView.isPagingEnabled=true
        scrollView.contentSize=CGSize(width:self.view.bounds.width * CGFloat(walthroughImages.count) ,height:self.scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.delegate=self
        
        
        loadFeature()
        self.scrollView.contentSize.height = 1.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)    }
    
    
    func loadFeature(){
        for (index,feature) in walthroughImages.enumerated(){
            if let slider=Bundle.main.loadNibNamed("Slider", owner: self, options: nil)?.first as? Slider{
                slider.Imageview.image=feature
                slider.titleLable.text = Title[index]
                slider.descriptionLable.text = walkthroughText[index]
                scrollView.addSubview(slider)
                slider.frame.size.width=self.scrollView.frame.width
                slider.frame.size.height=scrollView.frame.height
                slider.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page=scrollView.contentOffset.x/scrollView.frame.size.width
        pageControl.currentPage=Int(page)
    }

    
    
    @IBAction func skipButton(){
        
        let vc = UIStoryboard.home.instantiateViewController(withIdentifier: "WelcomeBackViewController") as! WelcomeBackViewController
        navigationController?.pushViewController(vc , animated: true)
        
    }


    @IBAction func nextPage(sender:UIButton){
        print("pageControl.currentPage ",pageControl.currentPage)
        if pageControl.currentPage < 2 {
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: UIView.KeyframeAnimationOptions.allowUserInteraction, animations: {
                
                self.scrollView.contentOffset.x=CGFloat(self.pageControl.currentPage+1) * self.scrollView.frame.size.width
                let page=self.scrollView.contentOffset.x/self.scrollView.frame.size.width
                self.pageControl.currentPage=Int(page)
            }, completion: nil)
          }
        else{
            let vc = UIStoryboard.home.instantiateViewController(withIdentifier: "WelcomeBackViewController") as! WelcomeBackViewController
            navigationController?.pushViewController(vc , animated: true)
        }
        
        
    }
}
