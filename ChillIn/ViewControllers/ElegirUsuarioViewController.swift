//
//  ElegirUsuarioViewController.swift
//  ChillIn
//
//  Created by Paul Pacheco on 5/16/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ElegirUsuarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var usuarios:[Usuario]=[]
    var imagenURL = ""
    var descrip = ""
    var imagenID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {
            (snapshot) in
            print("imprimir lista de usuarios",snapshot)
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = usuarios[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email,"descripcion":descrip,"imagenURL":imagenURL,"imagenID":imagenID]
        Database.database().reference().child("usuarios").child(usuario.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }

}
