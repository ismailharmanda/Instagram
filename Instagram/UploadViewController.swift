//
//  UploadViewController.swift
//  Instagram
//
//  Created by ismail harmanda on 8.11.2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onPressImage))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func onPressImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            imageView.image = info[.originalImage] as? UIImage
            self.saveButton.isEnabled = true
            self.dismiss(animated: true)
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        
        let confirmButton = UIAlertAction(title: "OK", style: .default) { action in
            
        }
        alert.addAction(confirmButton)
        self.present(alert,animated:true)
    }

    @IBAction func onPressSave(_ sender: UIButton) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data) { metaData, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                } else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference?
                            
                            let firestorePost:[String:Any] = ["imageUrl": imageUrl!, "postedBy":Auth.auth().currentUser?.email, "postComment": self.textView.text, "date":FieldValue.serverTimestamp(), "likes":0]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                                } else{
                                    self.imageView.image = UIImage(systemName: "plus.viewfinder")
                                    self.textView.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }       else{
                            print(error)
                        }             }
                }
            }
        }
    }
}
