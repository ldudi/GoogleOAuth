//
//  LogInViewController.swift
//  SimpleSignIn
//
//  Created by Labhesh Dudi on 13/03/22.
//

import UIKit
import GoogleSignIn

class LogInViewController: UIViewController {

    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var greetUser: UILabel!
    
    var userName = ""
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        greetUser.text! += userName
        retriveProfilePic()
        print(imageUrl)
    }
    
    func retriveProfilePic() {
        guard imageUrl != "" else { return }
        let url = URL(string: imageUrl)
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url!) else { return }
            DispatchQueue.main.async {
                self.userIcon.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func signOutButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "sign out", message: "Are you sure to log out from this device", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Sure", style: .default, handler: signOutHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func signOutHandler(alert: UIAlertAction!) {
        GIDSignIn.sharedInstance.signOut()
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
