//
//  ViewController.swift
//  NewYearNew
//
//  Created by Ivan Pryadchenko on 03.10.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import UIKit
let reuseIdentifier = "numberBrick"
var numberPic = 1

extension UIImageView{
    func blurImage()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var lableTheme: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayNumber = [Int]()
    
    var arr = (1...150)
    var segue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayNumber += 1...150
        let bgImage = UIImageView();
        bgImage.image = UIImage(named: "1_\(numberPic).jpg");
        bgImage.contentMode = .scaleToFill
        self.collectionView?.backgroundView = bgImage
        lableTheme.text = "Тема: " + arrayOfTheme[segue]

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayNumber.count
    }
    @IBAction func buttonNextClick(_ sender: UIButton) {
        numberPic += 1
        let bgImage = UIImageView();
        bgImage.image = UIImage(named: "1_\(numberPic).jpg");
        bgImage.contentMode = .scaleToFill
        self.collectionView?.backgroundView = bgImage
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier , for: indexPath as IndexPath) as! MyCollectionViewCell
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = cell.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        cell.textLable.text = String(describing: self.arrayNumber[indexPath.item])
        //cell.insertSubview(blurEffectView, belowSubview: collectionView)
        //cell.removeFromSuperview()
        //cell.insertSubview(blurEffectView, at: 3)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0
    }
    
}
