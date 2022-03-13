//
//  ViewController.swift
//  SimpleSignIn
//
//  Created by Labhesh Dudi on 13/03/22.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    var googleSignIn = GIDSignIn.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        self.googleAuthLogin()
    }
    
    func googleAuthLogin() {
        let googleConfig = GIDConfiguration(clientID: "348605957755-eddse2ej29qilbkpnc3fpgjg0tdr1g6d.apps.googleusercontent.com")
        guard googleSignIn.currentUser == nil else {
            goToNextViewController()
            return
        }
        self.googleSignIn.signIn(with: googleConfig, presenting: self) { user, error in
            if error == nil {
                guard let user = user else {
                    print("uh Oh! user cancelled the login")
                    return
                }
                let userId = user.userID ?? ""
                print("user ID: \(userId)")
                self.goToNextViewController()
            }
        }
    }
    
    func goToNextViewController() {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "logInViewController") as? LogInViewController else {
            return
        }
        viewController.userName = googleSignIn.currentUser?.profile?.name ?? ""
        viewController.imageUrl = googleSignIn.currentUser?.profile?.imageURL(withDimension: 110)?.absoluteString ?? ""
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    


}

