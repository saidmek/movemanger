//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by sid almekhlfi on 13/012/2019.
//  Copyright © 2019 saeed almekhlfi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        TMDBClient.getRequestToken(completion: handleReqestTokenRespone(success:Error:))

    }
    
    @IBAction func loginViaWebsiteTapped() {
       
        TMDBClient.getRequestToken { (success, error) in
            if success {
               
                     UIApplication.shared.open(TMDBClient.Endpoints.webAthu.url, options: [:], completionHandler: nil)
              
               
            }
        }
        
        
        
    }
    
    func handleReqestTokenRespone (success : Bool , Error: Error? ){
        if success {
     print(TMDBClient.Auth.requestToken)
     
                                TMDBClient.login(username:
                                               self.emailTextField.text ?? "", password:
                                               self.passwordTextField.text ?? "" , completion:
                                               self.handleLogingResonse(success:error:))
            
       
        }
    }
    
    
    func handleLogingResonse(success: Bool, error: Error?) {
       
      print(TMDBClient.Auth.requestToken)
     
        if success {
            TMDBClient.CreateSession(completion: handleSessionResponse(success:Error:))
        }
    }
    
    func handleSessionResponse (success : Bool , Error: Error? ){
        if success {
           
                self.performSegue(withIdentifier:"completeLogin", sender: nil)
            
          
        }
    }
}
 
