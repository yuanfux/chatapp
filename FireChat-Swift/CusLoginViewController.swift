//
//  CusLoginViewController.swift
//  
//
//  Created by Yuan Fu on 1/16/16.
//
//

import UIKit

class CusLoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate{

    
    var loginVC : PFLogInViewController = PFLogInViewController()
    var signUpVC: PFSignUpViewController = PFSignUpViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(PFUser.currentUser() != nil){
            
            PFUser.logOut()
            
        }
        
        self.loginVC.delegate = self
        
        self.signUpVC.delegate = self
        
        self.loginVC.signUpController = signUpVC

        let logo1 = UILabel()
        logo1.text = "Chat Test"
        
        let logo2 = UILabel()
        logo2.text = "Chat Test"
        
        self.loginVC.logInView!.logo = logo1
        self.signUpVC.signUpView!.logo = logo2
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(PFUser.currentUser() == nil){
            
            self.loginVC.fields = [PFLogInFields.UsernameAndPassword, PFLogInFields.LogInButton, PFLogInFields.SignUpButton,PFLogInFields.PasswordForgotten, PFLogInFields.DismissButton]
            
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //login delegate methods
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if(!username.isEmpty || !password.isEmpty ){
            return true
        }
        else{
            return false
        }
        
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("The user has been loged in")
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Login failed")
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        print("User dismissed Login")
    }
    
    //signup delegate method s
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [String : String]) -> Bool {
        
        let username: String = info["username"]!
        let password: String = info["password"]!
        if(!username.isEmpty && !password.isEmpty ){
            return true
        }
            
        else{
            return false
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("Signup failed")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("User dismissed Signup")
    }
    
    @IBAction func pressAction(sender: UIButton) {
        
        self.presentViewController(self.loginVC, animated: true, completion: nil)
        
    }
    
    @IBAction func toChatRoom(sender: AnyObject) {
        
        if(PFUser.currentUser() != nil){
            
            self.performSegueWithIdentifier("segue1", sender: self)
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "segue1"){
            //print("assign value of sender")
            //print("value: \(PFUser.currentUser()?.username)")
             let JSQvc = segue.destinationViewController as! JSQViewController
             JSQvc.passValue = (PFUser.currentUser()?.username)!
            
            //print("JSQvc.sender: \(JSQvc.sender)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
