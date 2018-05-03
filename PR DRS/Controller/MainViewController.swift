//
//  MainViewController.swift
//  PR DRS
//
//  Created by xr on 5/2/18.
//  Copyright © 2018 Dusan. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI

protocol MainViewControllerDelegate {
    func onTakePhoto(photo: UIImage)
}

class MainViewController: UIViewController {

    @IBOutlet weak var m_txtView: UILabel!
    @IBOutlet weak var m_propertyIDTxtField: UITextField!
    @IBOutlet weak var m_collectionView: UICollectionView!
    @IBOutlet weak var m_addPhotoBarItem: UIBarButtonItem!
    
    var m_collectionDataSource = [PropertyItem]()
    
    var cell_width: CGFloat = 0.0
    var cell_height: CGFloat = 0.0
    var cell_interface: CGFloat = 4.0
    
    let locManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global().async {
            print("Location Manager")
            
            self.locManager.delegate = self
            self.locManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.cell_width = self.m_collectionView.frame.width / 2 - cell_interface
        self.cell_height = self.cell_width * 1.3
    }
    
    @IBAction func onAddPhotos(_ sender: Any) {
    
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePhoto = UIAlertAction(title: "Take a Photo", style: .default) { (takPhoto) in
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            homeVC.delegate = self
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        
        let selectPhoto = UIAlertAction(title: "Select From Photos", style: .default) { (selectPhoto) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true, completion: nil)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(takePhoto)
        alertController.addAction(selectPhoto)
        alertController.addAction(cancel)
        
        if let popPresenter = alertController.popoverPresentationController {
            popPresenter.barButtonItem = self.m_addPhotoBarItem
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func onEmailBarItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Email Address", message: "Please enter email Address", preferredStyle: .alert)
        let send = UIAlertAction(title: "Send", style: .default) { (send) in
            
            let textfield = alertController.textFields?.first
            if TextUtils.isEmpty(textfield?.text) || TextUtils.isEmpty(self.m_propertyIDTxtField.text) {
                UIManager.showAlertViewController(targetVC: self, title: "Error", description: "Must enter office email or PropertyID")
            }
            else {
                let email = textfield?.text
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                mailComposer.setToRecipients([email!])
                mailComposer.setSubject("Email with Properties")
                mailComposer.setMessageBody("Location: \(self.m_txtView.text!)", isHTML: true)
                for one in self.m_collectionDataSource {
                    if let data = UIImagePNGRepresentation(one.image!) {
                        let filename = SharedManager.getDocumentsDirectory().appendingPathComponent("\(one.timestamp).png")
                        try? data.write(to: filename)
                        mailComposer.addAttachmentData(data, mimeType: "application/png", fileName: "\(one.timestamp).png")
                    }
                }
                self.present(mailComposer, animated: true, completion: nil)
            }
        }
        
        alertController.addTextField { (textField) in
            textField.delegate = self
            textField.placeholder = "Email"
            textField.text = "will.do14@hotmail.com"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(send)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        var image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        if image == nil {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.onTakePhoto(photo: image!)
        }
        

        picker.dismiss(animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.m_collectionDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyCollectionViewCell", for: indexPath) as! PropertyCollectionViewCell
        
        cell.initializeCell(propertyItem: self.m_collectionDataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.cell_interface
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.cell_interface
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cell_width, height: self.cell_height)
    }
}

extension MainViewController: MainViewControllerDelegate {
    func onTakePhoto(photo: UIImage) {
        let item = PropertyItem()
        item.image = photo
        
        self.m_collectionDataSource.append(item)
        self.m_collectionView.reloadData()
    }
}

extension MainViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("56.356356356")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var currentLocation = CLLocation()
        if status == .authorizedWhenInUse {
            if (self.locManager.location != nil) {
                currentLocation = self.locManager.location!
            }
            
            CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, error) in
                if (error != nil) {
                    print(error?.localizedDescription ?? "")
                }
                else if (placemarks?.count)! > 0 {
                    var placeMark: CLPlacemark!
                    placeMark = placemarks?[0]
                    
                    print(placeMark.addressDictionary as Any)
                    var address = ""
//                    if let street = placeMark.addressDictionary!["Thoroughfare"] as? String {
//                        address = street
//                    }
//
//                    if let city = placeMark.addressDictionary!["City"] as? String {
//                        address = address + " \(city)"
//                    }
//                    if let zip = placeMark.addressDictionary!["ZIP"] as? String {
//                        address = address + " \(zip)"
//                    }
//                    if let country = placeMark.addressDictionary!["Country"] as? String {
//                        print(country)
//                    }
                    
                    if (placeMark.addressDictionary!["FormattedAddressLines"] as? NSArray) != nil {
                        let tt = placeMark.addressDictionary!["FormattedAddressLines"] as? NSArray
                        for one in tt! {
                            address = address + (one as? String)! + " "
                        }
                    }
                    
//                    let m_latitude = Float(currentLocation.coordinate.latitude)
//                    let m_longitude = Float(currentLocation.coordinate.longitude)
                    
                    address = address + String(currentLocation.coordinate.latitude) + " " + String(currentLocation.coordinate.longitude)
                    
                    self.m_txtView.text = address
                    print("LocationManager:  Success")
                }
                else {
                    print("Problems with the data received from geocoder.")
                }
            })
        }
        else {
            print("Location Manger Denied")
            print("LocationManager Group Leave")
        }
    }
}

extension MainViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            break
            
        case .failed:
            UIManager.showAlertViewController(targetVC: self, title: "Failed", description: "Fail to send email")
            break
            
        case .saved:
            UIManager.showAlertViewController(targetVC: self, title: "Info", description: "Saved email to Draft")
            break
            
        case .sent:
            UIManager.showAlertViewController(targetVC: self, title: "Success", description: "Sent email successfully")
            break
            
        default:
            print("Dekld")
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
}
