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

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UITabBarDelegate {
    
    @IBOutlet weak var barButtonDifficulty: UIBarButtonItem!
    @IBOutlet weak var barButtonNextPic: UIBarButtonItem!
    @IBOutlet weak var imageViewUnderCollection: UIImageView!
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
    
    var arrayIndex = [IndexPath]()
    var points = 0
    var arr = (1...150)
    var arrayNumPic = [Int]()
    var segue = 0
    var chose = 0
    var numberPic = 1
    let pinchRec = UIPinchGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let bgImage = UIImageView()
        let imageBackground = UIImage(named: "\(segue + 1)_\(numberPic).jpg")
        bgImage.image = imageBackground
        bgImage.contentMode = .scaleToFill
        self.collectionView?.backgroundView = bgImage
        self.imageViewUnderCollection.image = imageBackground
        //lableTheme.text = "Тема: " + arrayOfTheme[segue]
        self.title = "Тема: " + arrayOfTheme[segue]
        lableNumber.text = String(segue + 1)+String(numberPic)
        collectionView.reloadData()
        
    }
    
    
    @IBAction func buttonDifficultPushed(_ sender: UIBarButtonItem) {
        showAlertSize()
    }
    
    func makeTeamTextDiffer( whosTurn: UILabel,whosTurnPoints: UILabel, whoWait: UILabel, whoWaitPoints: UILabel) {
        whosTurn.textColor = UIColor.black
        whosTurn.font = whosTurn.font.withSize(20)
        whoWait.textColor = UIColor.black
        whoWait.font = whoWait.font.withSize(20)
        whoWait.alpha = 0.5
        whoWaitPoints.alpha = 0.5
        whosTurn.alpha = 0.5
        whosTurnPoints.alpha = 0.5
        whosTurn.alpha = 1
        whosTurnPoints.alpha = 1
        whoWait.alpha = 0.5
        whoWaitPoints.alpha = 0.5
        whosTurn.textColor = UIColor.red
        whosTurn.font = whosTurn.font.withSize(25)
        whosTurnPoints.font = whosTurnPoints.font.withSize(25)
    }
    
    
    func randomPlayer() {
        let randomForBegin = drand48()
        if randomForBegin >= 0.5 {
            makeTeamTextDiffer(whosTurn: lableTeamOne, whosTurnPoints: lableTeamOnePoints, whoWait: lableTeamTwo, whoWaitPoints: lableTeamTwoPoints)
        } else {
            makeTeamTextDiffer(whosTurn: lableTeamTwo, whosTurnPoints: lableTeamTwoPoints, whoWait: lableTeamOne, whoWaitPoints: lableTeamOnePoints)
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
            self.points = 25
            self.chose = 1
            self.collectionView.reloadData()
        }
        let twoAction = UIAlertAction(title: "10x10", style: .default) { (_) in self.arrayNumber = []
            self.arrayNumber += 1...100
            self.changeSize(caseChoose: 2)
            self.points = 100
            self.chose = 2
            self.collectionView.reloadData()}
        let threeAction = UIAlertAction(title: "10x15", style: .default) { (_) in self.arrayNumber = []
            self.arrayNumber += 1...150
            self.changeSize(caseChoose: 3)
            self.points = 150
            self.chose = 3
            self.collectionView.reloadData()}
        alertController.addAction(oneAction)
        alertController.addAction(twoAction)
        alertController.addAction(threeAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWhoWinRound() {
        let alertController = UIAlertController(title: "Победитель Раунда", message: "Выберите команду, которая угадала картинку", preferredStyle: .alert)
        let firstTeam = UIAlertAction(title: teamOneName, style: .default, handler: {(_) in
            teamOnePoints += self.points
            self.lableTeamOnePoints.text = String(teamOnePoints)
            switch self.chose {
            case 1: self.points = 25
            case 2: self.points = 100
            case 3: self.points = 150
            default: break
            }
        })
        let secondTeam = UIAlertAction(title: teamTwoName, style: .default, handler: { (_) in
            teamTwoPoints += self.points
            self.lableTeamTwoPoints.text = String(teamTwoPoints)
            switch self.chose {
            case 1: self.points = 25
            case 2: self.points = 100
            case 3: self.points = 150
            default: break
            }
            
        })
        alertController.addAction(firstTeam)
        alertController.addAction(secondTeam)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertWinner() {
        var winnerTeam = ""
        if Int(lableTeamTwoPoints.text!)! > Int(lableTeamOnePoints.text!)! {
            winnerTeam = lableTeamTwo.text!
        } else if Int(lableTeamTwoPoints.text!)! < Int(lableTeamOnePoints.text!)! {
            winnerTeam = lableTeamOne.text!
        } else {
            winnerTeam = "Дружба:)"
        }
        let alertController = UIAlertController(title: "Победитель: " + winnerTeam, message:
            "Ура!!!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Выход На Главный Экран", style: UIAlertActionStyle.default,handler: {(_) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alertController, animated: false, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayNumber.count
    }
    
    @IBAction func buttonNextClick(_ sender: UIBarButtonItem) {
        //collectionView.deleteItems(at: collectionView.indexPathsForSelectedItems!)
        
        

        if collectionView.alpha == 1 {
            collectionView.alpha = 0
        } else {
            barButtonDifficulty.isEnabled = true
            if arrayNumPic.count != 0 {
                showAlertWhoWinRound()
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
                let alertController = UIAlertController(title: "Победитель Раунда", message: "Выберите команду, которая угадала картинку", preferredStyle: .alert)
                let firstTeam = UIAlertAction(title: teamOneName, style: .default, handler: {(_) in
                    teamOnePoints += self.points
                    self.lableTeamOnePoints.text = String(teamOnePoints)
                    self.alertWinner()
                })
                let secondTeam = UIAlertAction(title: teamTwoName, style: .default, handler: { (_) in
                    teamTwoPoints += self.points
                    self.lableTeamTwoPoints.text = String(teamTwoPoints)
                    self.alertWinner()
                })
                alertController.addAction(firstTeam)
                alertController.addAction(secondTeam)
                self.present(alertController, animated: true, completion: nil)
            }
            let bgImage = UIImageView();
            bgImage.image = UIImage(named: "\(segue + 1)_\(numberPic).jpg");
            bgImage.contentMode = .scaleToFill
            self.collectionView?.backgroundView = bgImage
            self.imageViewUnderCollection.image = bgImage.image
            lableNumber.text = String(segue + 1) + String(numberPic)
            collectionView.alpha = 1
            collectionView.reloadData()
            guard arrayIndex.count == 0 else {
                collectionView.reloadItems(at: arrayIndex)
                arrayIndex.removeAll()
                return
            }
            
        }
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
        barButtonDifficulty.isEnabled = false
        points -= 1
        print(points)
        collectionView.cellForItem(at: indexPath)?.alpha = 0
        if indexPath == [0,45] && arrayNumber.count == 100 {
            arrayIndex.append(indexPath)
        }
        else if indexPath == [0,82] && arrayNumber.count == 150 {
            arrayIndex.append(indexPath)
        }
        if lableTeamOne.alpha == 1 {
            makeTeamTextDiffer(whosTurn: lableTeamTwo, whosTurnPoints: lableTeamTwoPoints, whoWait: lableTeamOne, whoWaitPoints: lableTeamOnePoints)
        } else {
            makeTeamTextDiffer(whosTurn: lableTeamOne, whosTurnPoints: lableTeamOnePoints, whoWait: lableTeamTwo , whoWaitPoints: lableTeamTwoPoints)
        }

    }
    
}
