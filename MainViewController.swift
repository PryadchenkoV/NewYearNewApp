//
//  MainViewController.swift
//  NewYearNew
//
//  Created by Ivan Pryadchenko on 19.10.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import UIKit

public let arrayOfTheme = ["Советские Фильмы","Известные Картины",""]
public let kSegueFromMainToCollection = "segueMainToView"
let kLableOfTableViewCellForMainScreen = "themeCell"
var teamOneName = ""
var teamTwoName = ""

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
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
            teamOneName = "Команда1"}
            let okAction = UIAlertAction(title: "Подтвердить", style:  .default, handler: { (_) in
                let firstTextField = alertView.textFields![0] as UITextField
                let secondTextField = alertView.textFields![1] as UITextField
                teamOneName = firstTextField.text!
                teamTwoName = secondTextField.text!
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
}
