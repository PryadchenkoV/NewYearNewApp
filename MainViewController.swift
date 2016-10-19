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

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    var segueString = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

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
