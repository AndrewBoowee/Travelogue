//
//  NewViewController.swift
//  Travelogue
//
//  Created by Drew Boowee on 7/26/19.
//  Copyright © 2019 Drew Boowee. All rights reserved.
//

import Foundation
import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var entryDatePicker: UIDatePicker!
    
    var entry: Entry?
    var trip: Trip?
    var image: UIImage?
    var date: Date?
    
    let imagePickerController = UIImagePickerController()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imageSelect.delegate = self
        
    }
    
    func takePhotoWithCamera()
    {
        if (!UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            Alert(title: "No Camera", message: "This device has no camera")
        }
        else
        {
            imageSelect.allowsEditing = false
            imageSelect.sourceType = .camera
            present(imageSelect, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
        }
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            else
        {
            Alert(title: "Error Message", message: "Could not load Photos")
            return
        }
        
        imageSelect.allowsEditing = false
        imageSelect.sourceType = .photoLibrary
        
        present(imageSelect, animated: true, completion: nil)
}

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {
            action, index in
            self.deleteEntry(at: indexPath)
        }
        
        return [delete]
        //deleting entry
}
