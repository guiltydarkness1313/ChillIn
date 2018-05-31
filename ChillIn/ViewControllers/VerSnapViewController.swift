//
//  VerSnapViewController.swift
//  ChillIn
//
//  Created by Paul Pacheco on 5/30/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
class VerSnapViewController: UIViewController {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    var snap=Snap()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(snap.descrip)
        titulo.text?=snap.descrip
        imagen.sd_setImage(with: URL(string: snap.imagenURL))
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("usuarios").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.id).removeValue()
        Storage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete(completion: {(error) in
            print("Se elimino la imagen correctamente")
        })
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
