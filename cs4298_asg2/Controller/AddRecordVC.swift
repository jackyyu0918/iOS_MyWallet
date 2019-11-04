//
//  AddRecordVC.swift
//  cs4298_asg2
//
//  Created by YU Ka Kit on 1/11/2019.
//  Copyright © 2019 YU Ka Kit. All rights reserved.
//

import UIKit
import CoreData

class AddRecordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var remarkTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    //Type section

    var NatureOfMoney: String = ""
    @IBOutlet weak var outcomeButton: UIButton!
    @IBOutlet weak var incomeButton: UIButton!
    
    var typeName: String?
    @IBOutlet weak var typeNameLabel: UILabel!
    
    
    @IBAction func ChoosingNature(_ sender: UIButton) {
        if sender.tag == 1{
            NatureOfMoney = "Outcome"
            outcomeButton.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1), for: .normal)
            incomeButton.setTitleColor(.gray, for: .normal)
            typeNameLabel.text = ""
            updateUI()
        } else if sender.tag == 2{
            NatureOfMoney = "Income"
            incomeButton.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1), for: .normal)
            outcomeButton.setTitleColor(.gray, for: .normal)
            typeNameLabel.text = ""
            updateUI()
        }
    }
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
    @IBAction func typeButtonOnClick(_ sender: UIButton) {
        print(sender.tag)
        print(NatureOfMoney)
        switch sender.tag {
        case 1:
            if NatureOfMoney == "Income"{
                typeName = "Salary"
            } else {
                typeName = "Food"
            }
        case 2:
            if NatureOfMoney == "Income"{
                typeName = "Investment"
            } else {
                typeName = "Shopping"
            }
        case 3:
            if NatureOfMoney == "Income"{
                typeName = "Rent"
            } else {
                typeName = "Traffic"
            }
        case 4:
            if NatureOfMoney == "Income"{
                typeName = "Prize"
            } else {
                typeName = "Bill"
            }
        case 5:
            if NatureOfMoney == "Income"{
                typeName = "Coupon"
            } else {
                typeName = "Entertainment"
            }
        case 6:
            if NatureOfMoney == "Income"{
                typeName = "Lottery"
            } else {
                typeName = "Pet"
            }
        case 7:
            if NatureOfMoney == "Income"{
                typeName = "Refund"
            } else {
                typeName = "Health Care"
            }
        case 8:
            if NatureOfMoney == "Income"{
                typeName = "Other"
            } else {
                typeName = "Other"
            }
        default:
            break
        }
        typeNameLabel.text = typeName

    }
    
    //select of camera, album
    var imagePicker: ImagePicker!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBAction func imagePickerButtonTouched(_ sender: UIButton) {
        //extended to ImagePickerDelegate
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.imagePicker.present(from: sender)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func createData(){
        if NatureOfMoney == nil || typeName == nil || (Double)(valueTextField.text!) == nil {
            
            let controller = UIAlertController(title: "Failed!", message: "You must fill in the details, type and value must be filled.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
            
           
        } else {
            let controller = UIAlertController(title: "Success!", message: "New record has been added.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
            
            //real business
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let recordEntity = NSEntityDescription.entity(forEntityName: "Record", in: managedContext)
            
            let record = NSManagedObject(entity: recordEntity!, insertInto: managedContext)
            /*
             record.setValue("Food", forKeyPath: "type")
             record.setValue("Food", forKeyPath: "date")
             record.setValue("Food", forKeyPath: "remark")
             record.setValue("Food", forKeyPath: "photo")
             record.setValue("Food", forKeyPath: "value")
             */
            record.setValue(NatureOfMoney, forKeyPath: "nature")
            record.setValue(typeName, forKeyPath: "type")
            record.setValue(datePicker.date, forKeyPath: "date")
            record.setValue(remarkTextField.text, forKeyPath: "remark")
            record.setValue(imageView.image?.pngData(), forKeyPath: "photo")
            record.setValue((Double)(valueTextField.text!), forKeyPath: "value")
            
            //that's the way you tran from NSDATA to image
            /*
             let binaryImage = imageView.image?.pngData()
             testImageView.image = UIImage(data: <#T##Data#>)
             */
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    //from github
    //https://github.com/AnkurVekariya/CoreDataSwiftDemo/blob/master/CoreDataCRUD/ViewController.swift
    func retrieveData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "nature") as! String)
                print(data.value(forKey: "type") as! String)
                print(data.value(forKey: "date") as! Date)
                print(data.value(forKey: "value") as! Double)
                print(data.value(forKey: "remark") as? String)
                //get Binaryform of an image
                print(data.value(forKey: "photo") as? NSData)
                print("\n")
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    /*func updateData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Record")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur1")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue("newName", forKey: "username")
            objectUpdate.setValue("newmail", forKey: "email")
            objectUpdate.setValue("newpassword", forKey: "password")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
    }*/
    
    /*func deleteData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }*/
    
    func deleteAllData(entity: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    
    
    // 3 action
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var retrieveButto: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func addRecord(_ sender: Any) {
        createData()
    }
    
        
    @IBAction func retrieveRecord(_ sender: Any) {
        retrieveData()
    }
    
    @IBAction func deleteRecord(_ sender: Any) {
        deleteAllData(entity: "Record")
    }
    
    @IBAction func debuggerVariable(_ sender: Any) {
        print("imageView.image:  \(imageView.image)")
        print("imageView.image?.pngData(): \(imageView.image?.pngData())")
        print("datePicker.date:  \(datePicker.date)")
        print("remarkTextField.text:  \(remarkTextField.text)")
        print("(Double)(valueTextField.text!):  \((Double)(valueTextField.text!))")
    }
    
    func updateUI(){
        //to solve blue button, change to custom button
        if NatureOfMoney == "Outcome" {
            button1.setImage(UIImage(named: "Food"), for: .normal)
            button2.setImage(UIImage(named: "Shopping"), for: .normal)
            button3.setImage(UIImage(named: "Traffic"), for: .normal)
            button4.setImage(UIImage(named: "Bill"), for: .normal)
            button5.setImage(UIImage(named: "Entertainment"), for: .normal)
            button6.setImage(UIImage(named: "Pet"), for: .normal)
            button7.setImage(UIImage(named: "HealthCare"), for: .normal)
            button8.setImage(UIImage(named: "Others"), for: .normal)
        } else if NatureOfMoney == "Income"{
            button1.setImage(UIImage(named: "Salary"), for: .normal)
            button2.setImage(UIImage(named: "Investment"), for: .normal)
            button3.setImage(UIImage(named: "Rent"), for: .normal)
            button4.setImage(UIImage(named: "Prize"), for: .normal)
            button5.setImage(UIImage(named: "Coupon"), for: .normal)
            button6.setImage(UIImage(named: "Lottery"), for: .normal)
            button7.setImage(UIImage(named: "Refund"), for: .normal)
            button8.setImage(UIImage(named: "Others"), for: .normal)
        }
    }
}

//make the view contoller also a imagePicker
extension AddRecordVC: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        guard let image = image else {
            return
        }
        self.imageView.image = image
    }
}
