//
//  ViewController.swift
//  NewYearNew
//
//  Created by Ivan Pryadchenko on 03.10.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import UIKit
let reuseIdentifier = "numberBrick"


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
    
    @IBOutlet var pinchGesture: UIPinchGestureRecognizer!
    @IBOutlet weak var lableNumber: UILabel!
    @IBOutlet weak var lableTheme: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayNumber = [Int]()
    
    var sizeChose = 3
    
    var arr = (1...150)
    var arrayNumPic = [Int]()
    var segue = 0
    var numberPic = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showAlertSize()
        arrayNumPic += 1...3
        print(arrayNumPic)
        numberPic = arrayNumPic[Int(arc4random_uniform(UInt32(arrayNumPic.count)))]
        arrayNumPic.remove(at: numberPic - 1)
        print(arrayNumPic)
        arrayNumber += 1...150
        let bgImage = UIImageView();
        bgImage.image = UIImage(named: "\(segue + 1)_\(numberPic).jpg");
        bgImage.contentMode = .scaleToFill
        self.collectionView?.backgroundView = bgImage
        //lableTheme.text = "Тема: " + arrayOfTheme[segue]
        self.title = "Тема: " + arrayOfTheme[segue]
        lableNumber.text = String(segue + 1)+String(numberPic)
        navigationController?.navigationBar.topItem?.title = "Назад"
        
    }
    
    func showAlertSize(){
        let alertController = UIAlertController(title: "Сложность", message: "Выберите количество блоков на поле", preferredStyle: .alert)
        let oneAction = UIAlertAction(title: "5x5", style: .default) { (_) in self.changeSize(caseChoose: 1)}
        let twoAction = UIAlertAction(title: "10x10", style: .default) { (_) in self.changeSize(caseChoose: 2)}
        let threeAction = UIAlertAction(title: "10x15", style: .default) { (_) in self.changeSize(caseChoose: 3)}
        alertController.addAction(oneAction)
        alertController.addAction(twoAction)
        alertController.addAction(threeAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayNumber.count
    }
    @IBAction func buttonNextClick(_ sender: UIBarButtonItem) {
        if arrayNumPic.count != 0 {
            print(arrayNumPic)
            numberPic = arrayNumPic[Int(arc4random_uniform(UInt32(arrayNumPic.count)))]
            var i = 0
            for item in arrayNumPic {
                if item == numberPic{
                    arrayNumPic.remove(at: i)
                }
                i += 1
            }
            print(arrayNumPic)
        } else {
            let alertController = UIAlertController(title: "Все", message:
                "Картинки Закончились", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Выход На Главный Экран", style: UIAlertActionStyle.default,handler: {
                action in self.navigationController?.popViewController(animated: true)
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        let bgImage = UIImageView();
        bgImage.image = UIImage(named: "\(segue + 1)_\(numberPic).jpg");
        bgImage.contentMode = .scaleToFill
        self.collectionView?.backgroundView = bgImage
        lableNumber.text = String(segue + 1)+String(numberPic)
        collectionView.reloadData()
    }

    func changeSize(caseChoose: Int){
        var itemWidth = 0
        var itemHeight = 0
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            switch caseChoose{
            case 1:
                itemWidth = 154
                itemHeight = 186
            case 2:
                itemWidth = 77
                itemHeight = 93
            case 3:
                itemWidth = 77
                itemHeight = 62
            default:
                itemWidth = 77
                itemHeight = 93
            }
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }

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
