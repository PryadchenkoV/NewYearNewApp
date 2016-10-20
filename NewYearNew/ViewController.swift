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
    
    @IBOutlet weak var lableTeamTwoPoints: UILabel!
    @IBOutlet weak var lableTeamTwo: UILabel!
    @IBOutlet weak var lableTeamOnePoints: UILabel!
    @IBOutlet weak var lableTeamOne: UILabel!
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
    let pinchRec = UIPinchGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinchRec.addTarget(self, action: "pinchedView:")

        lableTeamOne.text = teamOneName
        lableTeamTwo.text = teamTwoName
        randomPlayer()
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
        collectionView.reloadData()
        
    }
    
    func randomPlayer() {
        let randomForBegin = drand48()
        lableTeamOne.textColor = UIColor.black
        lableTeamOne.font = lableTeamOne.font.withSize(20)
        lableTeamTwo.textColor = UIColor.black
        lableTeamTwo.font = lableTeamOne.font.withSize(20)
        lableTeamTwo.alpha = 0.5
        lableTeamTwoPoints.alpha = 0.5
        lableTeamOne.alpha = 0.5
        lableTeamOnePoints.alpha = 0.5
        if randomForBegin >= 0.5 {
            lableTeamOne.alpha = 1
            lableTeamOnePoints.alpha = 1
            lableTeamTwo.alpha = 0.5
            lableTeamTwoPoints.alpha = 0.5
            lableTeamOne.textColor = UIColor.red
            lableTeamOne.font = lableTeamOne.font.withSize(25)
            lableTeamOnePoints.font = lableTeamOnePoints.font.withSize(25)
        } else {
            lableTeamOne.alpha = 0.5
            lableTeamOnePoints.alpha = 0.5
            lableTeamTwo.alpha = 1
            lableTeamTwoPoints.alpha = 1
            lableTeamTwo.textColor = UIColor.red
            lableTeamTwo.font = lableTeamTwo.font.withSize(25)
            lableTeamTwoPoints.font = lableTeamTwoPoints.font.withSize(25)

        }
    }
    
    func pinchedView(sender:UIPinchGestureRecognizer){
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        print(sender.scale)
    }
    
    func showAlertSize(){
        let alertController = UIAlertController(title: "Сложность", message: "Выберите количество блоков на поле", preferredStyle: .alert)
        let oneAction = UIAlertAction(title: "5x5", style: .default) { (_) in self.arrayNumber = []
            self.arrayNumber += 1...25
            self.changeSize(caseChoose: 1)
            self.collectionView.reloadData()
            
        }
        let twoAction = UIAlertAction(title: "10x10", style: .default) { (_) in self.arrayNumber = []
            self.arrayNumber += 1...100
            self.changeSize(caseChoose: 2)
            self.collectionView.reloadData()}
        let threeAction = UIAlertAction(title: "10x15", style: .default) { (_) in self.arrayNumber = []
            self.arrayNumber += 1...150
            self.changeSize(caseChoose: 3)
            self.collectionView.reloadData()}
        alertController.addAction(oneAction)
        alertController.addAction(twoAction)
        alertController.addAction(threeAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayNumber.count
    }
    @IBAction func buttonNextClick(_ sender: UIBarButtonItem) {
        //collectionView.deleteItems(at: collectionView.indexPathsForSelectedItems!)
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
            randomPlayer()
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
        lableNumber.text = String(segue + 1) + String(numberPic)
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
        
        let image: UIImage = UIImage(named: "plitka.jpg")!
        cell.imageView = UIImageView(image: image)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0
    }
    
}
