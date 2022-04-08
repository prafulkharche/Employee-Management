//
//  AddNoteViewController.swift
//  QuixoteTest
//
//  Created by Praful Kharche on 06/04/22.
//

import UIKit

protocol DataPassing : AnyObject {
    func dataPassing()
}

class AddNoteViewController: UIViewController, UINavigationControllerDelegate{
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    weak var delegate : DataPassing?
    
    var imagePicker = UIImagePickerController()
    
    //MARK: ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Note"
        imagePicker.delegate = self
        titleText.delegate = self
        descriptionTextView.delegate = self
    }
    
    //MARK: Functional Methods
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func presentAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    //MARK: IBAction Methods
    @IBAction func addPhotoButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let image = profileImage.image else {
            return
        }
        
        let modelInfo = Notes(title: titleText.text ?? "", image: image.toPngString() ?? "" , description: descriptionTextView.text ?? "")
        
        let isSave = DatabaseManager.shared.saveData(modelInfo)
        print(isSave)
        delegate?.dataPassing()
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddNoteViewController:UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            profileImage.contentMode = .scaleToFill
            profileImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddNoteViewController: UITextFieldDelegate,UITextViewDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count ?? 0 <= 100  && textField.text?.count ?? 0 >= 5 {
        return true
    }
    else {
       presentAlert(title: "Warning", message: "It should be Min 5 to Max 100 Charcters")
        return false
    }
  }
    //Tried
    /*func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.count < 1000 && textView.text.count > 100{
                    //return true
                }else{
                    presentAlert(title: "Warning", message: "It should be Min 100 to Max 1000 Charcters")
                   // return false
                }
    }*/
   /* func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count

        return numberOfChars < 1000 && numberOfChars > 100    // 1000 Limit Value
    }*/

}
 
