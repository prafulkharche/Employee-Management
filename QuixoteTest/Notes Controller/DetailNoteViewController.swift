//
//  DetailNoteViewController.swift
//  QuixoteTest
//
//  Created by Praful Kharche on 06/04/22.
//

import UIKit

class DetailNoteViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var titleHeading : String?
    var desc : String?
    var image : String?
    
    //MARK: ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail Notes"
        
        titleLabel.text = titleHeading
        descriptionLabel.text = desc
        profileImage.image = image?.toImage()
    }
    
}
