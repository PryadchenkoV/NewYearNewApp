//
//  MainViewController.swift
//  NewYearNew
//
//  Created by Ivan Pryadchenko on 19.10.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import UIKit

public let arrayOfTheme = ["Советские Фильмы","Герои Советских Мультфильмов"]
public let kSegueFromMainToCollection = "segueMainToView"
let kLableOfTableViewCellForMainScreen = "themeCell"
var teamOneName = ""
var teamOnePoints = 0
var teamTwoName = ""
var teamTwoPoints = 0

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var barButtonRefreshScore: UIBarButtonItem!
    @IBOutlet weak var lableTeamOneName: UILabel!

    @IBOutlet weak var lableTeamOnePoint: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lableTeamTwoPoints: UILabel!
    @IBOutlet weak var lableTeamTwoName: UILabel!
    
    var segueString = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.title = "Главный экран"
        if teamOneName == "" {
            let alertView = UIAlertController(title: "Название команд", message:  "Введите название команд", preferredStyle: .alert)
            alertView.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Название первой команды"
                textField.autocapitalizationType = .words
            })
            alertView.addTextField(configurationHandler: {(textField) in
                textField.placeholder = "Название второй команды"
                textField.autocapitalizationType = .words
            })
            let cancelAction = UIAlertAction(title: "По умолчанию", style: .cancel) { (_) in teamTwoName = "Команда2"
                teamOneName = "Команда1"
                self.lableTeamOneName.text = teamOneName
                self.lableTeamTwoName.text = teamTwoName
                self.lableTeamOnePoint.text = "0"
                self.lableTeamTwoPoints.text = "0"
            }
            let okAction = UIAlertAction(title: "Подтвердить", style:  .default, handler: { (_) in
                let firstTextField = alertView.textFields![0] as UITextField
                let secondTextField = alertView.textFields![1] as UITextField
                teamOneName = firstTextField.text!
                teamTwoName = secondTextField.text!
                self.lableTeamOneName.text = teamOneName
                self.lableTeamTwoName.text = teamTwoName
                self.lableTeamOnePoint.text = "0"
                self.lableTeamTwoPoints.text = "0"
                print(teamOneName)
                print(teamTwoName)
            })
            alertView.addAction(okAction)
            alertView.addAction(cancelAction)
            self.present(alertView, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTheme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLableOfTableViewCellForMainScreen) as! MainViewTableViewCell
        cell.lableTableCell.text = arrayOfTheme[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueString = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: kSegueFromMainToCollection, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let collectionViewController = segue.destination as! ViewController
        collectionViewController.segue = segueString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lableTeamOneName.textColor = UIColor.black
        lableTeamOneName.font = lableTeamOneName.font.withSize(25)
        lableTeamOnePoint.textColor = UIColor.black
        lableTeamOnePoint.font = lableTeamOneName.font.withSize(25)
        lableTeamTwoName.textColor = UIColor.black
        lableTeamTwoName.font = lableTeamOneName.font.withSize(25)
        lableTeamTwoPoints.textColor = UIColor.black
        lableTeamTwoPoints.font = lableTeamOneName.font.withSize(25)
        self.lableTeamOnePoint.text = String(teamOnePoints)
        self.lableTeamTwoPoints.text = String(teamTwoPoints)
        if teamOnePoints > teamTwoPoints {
            lableTeamOneName.textColor = UIColor.red
            lableTeamOneName.font = lableTeamOneName.font.withSize(30)
            lableTeamOnePoint.textColor = UIColor.red
            lableTeamOnePoint.font = lableTeamOneName.font.withSize(30)
        } else if teamOnePoints < teamTwoPoints {
            lableTeamTwoName.textColor = UIColor.red
            lableTeamTwoName.font = lableTeamOneName.font.withSize(30)
            lableTeamTwoPoints.textColor = UIColor.red
            lableTeamTwoPoints.font = lableTeamOneName.font.withSize(30)
        }
        if teamTwoPoints != 0 || teamOnePoints != 0 {
            barButtonRefreshScore.isEnabled = true
        } else {
            barButtonRefreshScore.isEnabled = false
        }
        
    }
    @IBAction func barButtonRefreshScorePushed(_ sender: AnyObject) {
        teamOnePoints = 0
        teamTwoPoints = 0
        self.lableTeamOnePoint.text = String(teamOnePoints)
        self.lableTeamTwoPoints.text = String(teamTwoPoints)
        barButtonRefreshScore.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.lableTeamOnePoint.text = String(teamOnePoints)
//        self.lableTeamTwoPoints.text = String(teamTwoPoints)

    }
}
