//
//  inciarSesionViewController.swift
//  ChillIn
//
//  Created by Paul Pacheco on 5/16/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailtextField.text!, password: passwordTextField.text!, completion: {(user,error)in
            
            if(error != nil){
                print("Tenemos el siguiente error: \(error)")
                Auth.auth().createUser(withEmail: self.emailtextField.text!, password: self.passwordTextField.text!, completion: {(user,error) in
                    print("intentamos crear un usuario")
                    if error != nil{
                        print("tenemos el siguiente error\(error)")
                    }else{
                        print("El usuario fue creado exitosamente")
                        self.performSegue(withIdentifier: "iniciarSesionSegue", sender: nil)
                        
                        let currentUser = Auth.auth().currentUser
                        Database.database().reference().child("usuarios").child((currentUser?.uid)!).child("email").setValue(currentUser?.email)
                    }
                })
            }else{
                print("Incio de Sesión exitoso")
                self.performSegue(withIdentifier: "iniciarSesionSegue", sender: nil)
            }
        })
        
    }
    
}

