//
//  NotesTableViewController.swift
//  QuixoteTest
//
//  Created by Praful Kharche on 06/04/22.
//

import UIKit
import FMDB

class NotesTableViewController: UIViewController,DataPassing {
    
    func dataPassing() {
        notesArray = DatabaseManager.shared.getAllData()
        notesTableView.reloadData()
    }
    
    
    @IBOutlet weak var notesTableView: UITableView!
    
    var notesArray = [Notes]()
    
    //MARK: ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home Screen"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(add))
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.register(UINib(nibName: "CustomNoteTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        notesArray = DatabaseManager.shared.getAllData()
    }
    
    //MARK: Functional Methods
    @objc func add(){
        print("Add clicked")
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier:"AddNoteViewController")as? AddNoteViewController else {
            return
        }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: TableView Delegate and Datasource Methods
extension NotesTableViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomNoteTableViewCell
        cell.titleLabel.text = notesArray[indexPath.row].title
        cell.descriptionLabel.text = notesArray[indexPath.row].description
        cell.imageData.image = notesArray[indexPath.row].image.toImage()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier:"DetailNoteViewController") as? DetailNoteViewController else {
            return
        }
        vc.titleHeading = notesArray[indexPath.row].title
        vc.desc = notesArray[indexPath.row].description
        vc.image = notesArray[indexPath.row].image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
