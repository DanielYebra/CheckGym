//
//  ViewController.swift
//  CheckGym
//
//  Created by Daniel Yebra on 12/8/17.
//  Copyright © 2017 RoninRise. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var pickerKind: UIPickerView!
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var buttonABS: UIButton!
    @IBOutlet weak var buttonCardio: UIButton!
    @IBOutlet weak var buttonSPA: UIButton!
    
    var switchButtonDict: Dictionary<String,Bool> = ["cardio": true,"ABS":true,"SPA":false]
    let dataPickerKind = ["Pecho","Piernas","Espalda","Brazos","Libre"]
 
      @IBAction func checkButtonPress(_ sender: Any) {
        //Si el dia de hoy no esta checkeado,, si está checkeada, poner popup para confirmar el descheck.
        //Si no esta checkeado, recopilar los datos y guardar en coreData.
        //Descheckar, es borrar del core data.
        self.saveCheckDay()
    }
    
    
    @IBAction func buttonSwitch(_ sender: Any) {
        switchButton(button: sender as! UIButton)
    }
    
  
    @IBAction func pruebaCoreData(_ sender: Any) {
        self.isCheckedToday()
    }
    
    
    // MARK: - lifeCicle class
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        initialViews()
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    //MARK: - relation coredata func
    
    func saveCheckDay(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let trainingChecked = Training_Checked(context: managedContext)
        trainingChecked.dateTraining = pickerDate.date as NSDate
        trainingChecked.kindTraining = dataPickerKind[pickerKind.selectedRow(inComponent: 0)]
        trainingChecked.absTraining = switchButtonDict["ABS"]!
        trainingChecked.cardioTraining = switchButtonDict["cardio"]!
        trainingChecked.spaTraining = switchButtonDict["SPA"]!
        
        print("Se guardará \(trainingChecked)")
        
        appDelegate.saveContext()
    }
    
    func isCheckedToday() -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        var data = [Training_Checked]()
        
        do{
            data = try managedContext.fetch(Training_Checked.fetchRequest())
            for each in data{
                print(each.dateTraining!)
                print(each.kindTraining!)
            }
            
        }catch{
            //handel error
        }
        
        
        
        
        return true
    }
   
    
    // MARK: - view select func
    
    func initialViews(){
        self.pickerDate.backgroundColor = UIColor.init(red: 0.388, green: 0.835, blue:0.866, alpha: 0.85)
        self.pickerKind.dataSource = self
        self.pickerKind.delegate = self
        
        
        buttonCardio.setImage(UIImage(named: "CARDIOSelect.png"), for: .normal)
        buttonABS.setImage(UIImage(named: "ABSSelect.png"), for: .normal)
        buttonSPA.setImage(UIImage(named: "SPA.png"), for: .normal)
        
        let currentahora = NSDate()
        print (currentahora)
        
        //comprobar el estado del día actual, si no está chequeado, cambiar el boton de check a disponible si está dispponible dejarlo sin chequear.
    }
    
    func switchButton(button:UIButton){
        
        let idButtonSwitch : String = button.accessibilityIdentifier!
        switch idButtonSwitch {
        case "cardio":
            if (switchButtonDict["cardio"] == true){
                switchButtonDict["cardio"] = false
                buttonCardio.setImage(UIImage(named: "CARDIO.png"), for: .normal)
            }
            else{
                switchButtonDict["cardio"] = true
                buttonCardio.setImage(UIImage(named: "CARDIOSelect.png"), for: .normal)
            }
        case "ABS":
            if (switchButtonDict["ABS"] == true){
                switchButtonDict["ABS"] = false
                buttonABS.setImage(UIImage(named: "ABS.png"), for: .normal)
            }
            else{
                switchButtonDict["ABS"] = true
                buttonABS.setImage(UIImage(named: "ABSSelect.png"), for: .normal)
            }
        case "SPA":
            if (switchButtonDict["SPA"] == true){
                switchButtonDict["SPA"] = false
                buttonSPA.setImage(UIImage(named: "SPA.png"), for: .normal)
            }
            else{
                switchButtonDict["SPA"] = true
                buttonSPA.setImage(UIImage(named: "SPASelect.png"), for: .normal)
            }
        default: break
            
        }
    }
    

 
    // MARK: - UIPickerView Delegates
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataPickerKind.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataPickerKind[row]
    }
 
    

    

}

