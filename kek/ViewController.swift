//
//  ViewController.swift
//  kek
//
//  Created by mrBublzzz on 02.06.2018.
//  Copyright © 2018 mrBublzzz. All rights reserved.
//

import UIKit
//import AVFoundation
//import AudioToolbox
import MapKit
import CoreLocation

// Главный класс
class ViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    var kek = CLLocationManager()
    var placemark:CLPlacemark?

    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var text: UITextView!
    
//    @IBAction func dismiss(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
   
    
// какая-то функция
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // Функция появления вью
    override func viewDidAppear(_ animated:Bool){
        super.viewDidAppear(animated)
//        let location1 = CLLocationCoordinate2DMake (55.805769, 37.725850)
//        var boy = MKUserLocation()
//        var userTrackingMode = MKUserTrackingMode(rawValue: 0)
//        let span = MKCoordinateSpanMake(0.002, 0.002)
//        var region = MKCoordinateRegion (center: location, span:span)
//        map.setRegion(region, animated: true)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location1
//        map.addAnnotation(annotation)
        
        self.kek.requestAlwaysAuthorization()
        self.kek.desiredAccuracy = 0.1
        self.kek.delegate = self
        self.kek.startUpdatingLocation()
        self.map.showsUserLocation = true
    }
// Функция стандартная, при приходе нового адреса вызывается заново
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:
            locations[0].coordinate.latitude, longitude:
            locations[0].coordinate.longitude),span:
            MKCoordinateSpanMake(0.002, 0.002))
        self.map.setRegion(region, animated: true) // по идее надо только в первый раз это делать или раз в некоторое время
        print("Координаты точки:   \(locations[0].coordinate.latitude) \(locations[0].coordinate.longitude)")
        print("Правильные текстовые координаты:   \(rabota.perem)")
        text.text = rabota.perem
        ViewController.getPlacemarkFromLocation(location: locations[0])
        
//    добавляем пины
        let location1 = CLLocationCoordinate2DMake ((locations[0].coordinate.latitude - 0.0002), (locations[0].coordinate.longitude - 0.0002))
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = location1
        map.addAnnotation(annotation1)
        
        let location2 = CLLocationCoordinate2DMake ((locations[0].coordinate.latitude + 0.0002), (locations[0].coordinate.longitude + 0.0002))
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = location2
        map.addAnnotation(annotation2)
//        let annotation3 = MKPinAnnotationView(
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationview = MKAnnotationView(annotation: annotation, reuseIdentifier: "top")
        annotationview.image = #imageLiteral(resourceName: "kek11")
        return annotationview
    }
    
//Функция запроса адреса с выводом в внешнюю переменную (функция ассинхронная и все данные образуются внутри вложенного метода)
        class func getPlacemarkFromLocation(location:CLLocation){
        let g = CLGeocoder()
        var p:CLPlacemark?
        var q:String?
        g.reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) in
            if let pm = placemarks {
                p = pm[0]
                q = String(format:"%@ %@\n%@ %@ %@ %@",
                           (p?.subThoroughfare ?? "хз"),
                           (p?.thoroughfare)! ,
                           (p?.locality)!,
                           (p?.postalCode)!,
                           (p?.administrativeArea)!,
                           (p?.country)!)
                rabota.perem = q!
                }else{
                print(error!.localizedDescription)
                }
            })
        }
 
    
// Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

