//
//  imageViewController.swift
//  ChillIn
//
//  Created by Paul Pacheco on 5/16/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class imageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var elegirContactoButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        elegirContactoButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        elegirContactoButton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func imageTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoButton.isEnabled=false
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = UIImagePNGRepresentation(imageView.image!)!
        let urlInFB = "\(imagenID).jpg"
        imagenesFolder.child(urlInFB).putData(imagenData, metadata: nil, completion: {(metadata,error) in
            print("intentando subir la imagen")
            if error != nil{
                print("ocurrio un error \(error)")
            }else{
                print("intentando descargar la URL")
                let imagenRoute=imagenesFolder.child(urlInFB)
                imagenRoute.downloadURL(completion: {
                    (url,error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    if url != nil {
                        print(url!.absoluteString)
                        self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: url!.absoluteString)
                    }
                }
                )
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! ElegirUsuarioViewController
        siguienteVC.imagenURL = sender as! String
        siguienteVC.descrip = descriptionTextField.text!
        siguienteVC.imagenID = imagenID
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
