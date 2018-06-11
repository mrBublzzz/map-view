//
//  ViewController.swift
//  kek
//
//  Created by mrBublzzz on 02.06.2018.
//  Copyright © 2018 mrBublzzz. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import MapKit
import CoreLocation
//import os.log

class ViewController: UIViewController,CLLocationManagerDelegate {
    @IBAction func slider(_ sender: UISlider) {
//        label.text = String (slider11.value)
//        rabota.sliderPosit = rabota.sliderPosit +  String(slider11.value)
//        textfield1.text = rabota.sliderPosit
        progress.progress = slider11.value
//        AudioServicesPlaySystemSound(SystemSoundID(4095))
    }
    
    var kek = CLLocationManager()
    var placemark1: String = " "
    var placemark: String = " "
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var slider11: UISlider!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textfield1: UITextView!
    @IBOutlet weak var text: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         map.showsUserLocation = true
    }
    
    override func viewDidAppear(_ animated:Bool){
        super.viewDidAppear(animated)
       
        
        let location1 = CLLocationCoordinate2DMake (55.805769, 37.725850)
//        var boy = MKUserLocation()
//        var userTrackingMode = MKUserTrackingMode(rawValue: 0)
//        let span = MKCoordinateSpanMake(0.002, 0.002)
//        var region = MKCoordinateRegion (center: location, span:span)
//        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location1
        map.addAnnotation(annotation)
        
        self.kek.requestAlwaysAuthorization()
        self.kek.desiredAccuracy = 0.1
        self.kek.delegate = self
        self.kek.startUpdatingLocation()
        self.map.showsUserLocation = true
        
       placemark1 += placemark
        textfield1.text = placemark1
        text.text = placemark1
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
//        self.map.showsUserLocation = true
//        self.kek.startUpdatingLocation()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:
            locations[0].coordinate.latitude, longitude:
            locations[0].coordinate.longitude),span:
            MKCoordinateSpanMake(0.002, 0.002))
        self.map.setRegion(region, animated: true) // по идее надо только в первый раз это делать или раз в некоторое время
//        self.map.showsUserLocation = true
//        self.kek.startUpdatingLocation()
     
        print ("\(locations[0].coordinate.latitude) \(locations[0].coordinate.longitude)")
        
        if let  placemark = ViewController.getPlacemarkFromLocation(location: locations[0]){
     print ("kekekek \(placemark)")
        }
//
//        if let placemark2 = ViewController.getPlacemarkFromLocation(location: locations[0]){
//        print ("\(placemark2.subThoroughfare), \(placemark2.thoroughfare), \(placemark2.locality), \(placemark2.postalCode), \(placemark.country)")
//        }
        
//        textfield1.text = String(format:"%@ %@\n%@ %@ %@\n%@",
//                                 (placemark?.subThoroughfare)!,
//                                 (placemark?.thoroughfare)! ,
//                                 (placemark?.locality)!,
//                                 (placemark?.postalCode)!,
//                                 (placemark?.administrativeArea)!,
//                                 (placemark?.country)!)
//        }
//        else {print("kekeeelekeke")
//        }
    }
     class func getPlacemarkFromLocation(location:CLLocation)->String?{
//    class func getPlacemarkFromLocation(location:CLLocation)->CLPlacemark?{
        let g = CLGeocoder()
        var p:CLPlacemark?
        var q:String = " "
        g.reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) in
            if let pm = placemarks { //может здесь проверять на нил и если элемент равен нил то заменять на 0000 / здесь !
                print ("dadada")
//            if (pm.count > 0){
                p = pm[0] //был? и placemarks
                print(p)
             print ("asdadasd")
                q = String(format:"%@ %@\n%@ %@ %@\n%@",
                           (p?.subThoroughfare)!,
                           (p?.thoroughfare)! ,
                           (p?.locality)!,
                           (p?.postalCode)!,
                           (p?.administrativeArea)!,
                           (p?.country)!)
                print("AAAAAAAAAAAAAAAAAA \(q)")
//                }
            } else{
                print(error?.localizedDescription)
            }
            
        })

//        return p
        return q
    }
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

