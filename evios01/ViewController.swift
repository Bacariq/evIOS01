//
//  ViewController.swift
//  evios01
//
//  Created by Student01 on 30/06/2023.
//

import UIKit

class ViewController: UIViewController {
    let thread1 = DispatchQueue(label: "thread1")
    @IBOutlet weak var txtLogIn: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var Btn_Psw: UIButton!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myLogoUser: UIImageView!
    
    @IBOutlet weak var imgBtn: UIImageView!
    @IBOutlet weak var myLoadingContaint: UIView!
    @IBOutlet weak var myLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let myView = UIView(frame: view.bounds)
        let backGroundImage = UIImage(named: "background_image")
        myView.backgroundColor = UIColor(patternImage: backGroundImage!)
        view.insertSubview(myView, at: 0)
        
        let tapOnView = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tapOnView)
        txtLogIn.placeholder = "Login"
        txtLogIn.keyboardType = .emailAddress
        txtPassword.placeholder = "Password"
        txtPassword.isSecureTextEntry = true
        myLogoUser.layer.cornerRadius = 90
        myLoadingContaint.isHidden = true
        let backgroundImage = UIImage(named: "eye_on_icon")
        Btn_Psw.setBackgroundImage(backgroundImage, for: .normal)
    }
    
    
    @IBAction func txtPassword(_ sender: Any) {
       
    }
    
    @IBAction func Btc_PswTodo(_ sender: Any) {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        if(txtPassword.isSecureTextEntry == true){
            imgBtn.image = UIImage(named: "eye_on_icon")
        }else {
            imgBtn.image = UIImage(named: "eye_off_icon")
        }
    }
    
    
    @IBAction func myLogin(_ sender: Any) {
        myLoadingContaint.isHidden = false
        myLoading.startAnimating()
        Btn_Psw.isEnabled = false
        thread1.async{
            sleep(3)
            DispatchQueue.main.async {
                self.ShowResultat()
            }
        }
    }
    
    
    func ShowResultat(){
        
        Btn_Psw.isEnabled = true
        myLoadingContaint.isHidden = true
        myLoading.stopAnimating()
        
        var isError : String = ""
        
        if(txtLogIn.text?.isEmpty == true) {
            isError += "Le LogIn est vide! "
        } else {
            if(txtLogIn.text!.contains("@") == false){
                isError += "Le LogIn n'est pas valide! "
            }
        }
        if(txtPassword.text?.isEmpty == true) {
            isError += "Le mot de passe est vide! "
        } else  {
            if(txtPassword.text!.count < 4) {
                isError += "Le mot de passe ne possède pas 4 caractères! "
            }
        }
        
        if(isError.count == 0){
            let alertOk = UIAlertController(title: "Bonjour " + txtLogIn.text!,
                                            message: (mySwitch.isOn ? "Vous vous êtes inscrit à la newsletter." : "Vous ne vous êtes pas inscrit à la newsletter."), preferredStyle: .alert)
            
            alertOk.addAction(UIAlertAction(title:"Merci !", style: .default, handler: {action in print("TOUCH OK")}))
            
            present(alertOk,animated: true,completion: nil)
            
        } else {
            let alertNok = UIAlertController(title: "ERROR ",
                                            message: isError, preferredStyle: .alert)
            
            alertNok.addAction(UIAlertAction(title:"Merci !", style: .default, handler: {action in print("TOUCH OK")}))
            
            present(alertNok,animated: true,completion: nil)
        }
    }
    
}

