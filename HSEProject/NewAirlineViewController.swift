//
//  NewAirlineViewController.swift
//  HSEProject
//
//  Created by Sergey Pronin on 3/27/15.
//  Copyright (c) 2015 Sergey Pronin. All rights reserved.
//

import UIKit

protocol NewAirlineViewControllerDelegate: NSObjectProtocol {
    func airlineController(controller: NewAirlineViewController, didCreateAirline airline: Airline)
    func airlineControllerDidCancel(controller: NewAirlineViewController)
}

class NewAirlineViewController: UIViewController {
    
    @IBOutlet weak var textFieldCode: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textFieldName: UITextField!
    
    weak var delegate: NewAirlineViewControllerDelegate?
    
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldCode.delegate = self
        textFieldName.delegate = self
    }
    
    
    @IBAction func clickCancel(sender: AnyObject) {
        //используем паттерн делегата для оповещения о событии
        self.delegate?.airlineControllerDidCancel(self)
    }

    @IBAction func clickDone(sender: AnyObject) {
        //используем паттерн делегата для оповещения о событии
        
        //убираем пробелы и переносы с обеих сторон
        let code = textFieldCode.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let name = textFieldName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if countElements(code) == 0 || countElements(name) == 0 {
            return
        }
        
        let airline = Airline()
        airline.code = code.uppercaseString
        airline.name = name
        
        CoreDataHelper.instance.save()
        
        self.delegate?.airlineController(self, didCreateAirline: airline)
    }
    
    
    @IBAction func textFieldCodeChanged(sender: AnyObject) {
        //выходим, если не 2 символа
        if countElements(textFieldCode.text) != 2 {
            return
        }
        
        //!! запускаем анимацию индикатора
        activityIndicator.startAnimating()
        
        //делаем запрос
        let code = textFieldCode.text
        let URL = NSURL(string: "http://aita-amadeus-hack.appspot.com/api/1/airline?code=\(code)")
        let task = session.dataTaskWithURL(URL!) { data, response, error in
            
            if error != nil {
                println("error -> \(error.localizedDescription)")
                if let response = response as? NSHTTPURLResponse {
                    //response: NSHTTPURLResponse
                    println("status code: \(response.statusCode)")
                }
            } else {
                let name = NSString(data: data, encoding: NSUTF8StringEncoding)  // == String
                //обращение к UI элементу через главную очередь
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.textFieldName.text = name
                })
                
                println("got name -> \(name)")
            }
            
            //!! останавливаем анимацию индикатора
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
}

extension NewAirlineViewController: UITextFieldDelegate {
    
    //срабатывает при нажатии на Enter (перенос строки)
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case textFieldCode:
            textFieldName.becomeFirstResponder()    //получить фокус ввода
        case textFieldName:
            textFieldName.resignFirstResponder()    //убрать фокус ввода (и клавиатуру заодно)
        default:
            break
        }
        
        return false
    }
}
