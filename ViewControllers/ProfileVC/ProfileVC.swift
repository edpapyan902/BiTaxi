//
//  ProfileVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/31/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileVC: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var profile: Profile!

    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var nameTxtField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTxtField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var confirmPassTxtField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var newPassTxtField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var oldPassTxtField: SkyFloatingLabelTextFieldWithIcon!
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.makeRounded()
        picker.delegate = self
        self.hanleTxtFields()
        self.changePasswordView.isHidden = true

    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
       

        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        //picker.popoverPresentationController?.delegate = self.view as! UIPopoverPresentationControllerDelegate
        //picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func hanleTxtFields(){
        self.nameTxtField.text = AuthManger.instance.userName
        self.emailTxtField.text = AuthManger.instance.userEmail
    }
    @IBAction func changePassBtnPressed(_ sender: Any) {
        self.changePasswordView.isHidden = false
    }
    
    @IBAction func saveNewPassBtnPressed(_ sender: Any) {
        self.handleNewPass()
       
    }
    
    @IBAction func saveInfoBtnPressed(_ sender: Any) {
        self.handleUpdateProfile()
        
    }
    
    func handleUpdateProfile(){
        guard nameTxtField.isEditing || emailTxtField.isEditing else{return}
        let newName = self.nameTxtField.text!
        let newMobile = self.emailTxtField.text!
        AuthManger.instance.updateProfile(name: newName, mobile: newMobile, image: "") { (response, errorr) in
            if errorr == nil{
                self.nameTxtField.text = " "
                let res = response.result.value!
                self.profile = res.user!
                AuthManger.instance.userName = self.profile.full_name!
                self.nameTxtField.text = self.profile.full_name
                self.emailTxtField.text = self.profile.email
                
                print("-------------- profile Updated ----------------")
            }
            else{
                showMassage(massageTitle: "خطأ", massageBody: "يجب ادخال البيانات بشكل صحيح" , place: 3, layout: .centeredView)
                  print("-------------- problem with profile Updated ----------------")
            }
            
        }
    }
    
    func handleNewPass(){
        guard self.newPassTxtField.text == self.confirmPassTxtField.text else {
             showMassage(massageTitle: "خطأ", massageBody: "يجب ادخال البيانات بشكل صحيح" , place: 3, layout: .centeredView)
            return
        }
        let password = newPassTxtField.text!
        AuthManger.instance.updatePassword(password: password) { (success) in
            if success{
                print("----------password changed -------------")
                 self.changePasswordView.isHidden = true
            }
            else{
                print("----------problem in change password----------")
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.changePasswordView.isHidden = true
    }
    
    //MARK: - Delegates

    public func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        let chosenImage = info[.originalImage] as! UIImage
        profileImage.contentMode = .scaleAspectFit
        profileImage.image = chosenImage
        profileImage.contentMode = .scaleToFill
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)

    }
}
