//
//  ViewController.swift
//  이동경로
//
//  Created by 왕승현 on 2016. 3. 5..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    let locationManager: CLLocationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    var timer: NSTimer!
    var count = 300
    var path: [CLLocationCoordinate2D ] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        locationManager.delegate = self
        locationManager.activityType = .Fitness
        locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation
        if locationManager.respondsToSelector("requestAlwaysAuthorization") {
            self.locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.allowsBackgroundLocationUpdates = true
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        
        
        
        
        
    }


    func drawRoute() {
        var coordinates: [CLLocationCoordinate2D] = []
        for i in path { coordinates.append(i) }
        
        if coordinates.count > 1{
            var polyLine: MKGeodesicPolyline = MKGeodesicPolyline(coordinates: &coordinates[0], count: coordinates.count)
            
            print("draw polyline")
            self.mapView.addOverlay(polyLine)
            
        }
        

    }
    @IBAction func myLocation(sender: AnyObject) {
        let location = path.last
        if let latitude = location?.latitude, let lognitude = location?.longitude {
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: lognitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            self.mapView.setRegion(region, animated: false)
        }
    }
    @IBAction func resetPolyLine(sender: AnyObject) {
        print("reset Poly line")
        path = []
        count = 300
        self.mapView.removeOverlays(self.mapView.overlays)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last as CLLocation!
        let newLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)

        count++
        if count > 300 {
            print("New Location add! pathCount : \(path.count)")
            path.append(newLocation)
            drawRoute()
            count = 0
        }
        //self.locationManager.stopUpdatingLocation()
        //self.timer = NSTimer(timeInterval: 0.01, target: self, selector: "turnOnLocationManger", userInfo: nil, repeats: false)

        
        
        //label.text = "\(location.coordinate.latitude)"
       
        
        if UIApplication.sharedApplication().applicationState == .Background {
            print("App is backgrounded. New location is \(newLocation)")
        }
    }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error")
    }
    
    
    func turnOnLocationManger() {
        self.timer.invalidate()
        self.locationManager.startUpdatingLocation()
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 8
            polylineRenderer.alpha = 0.1
            return polylineRenderer
        } 
        return nil
    }}

extension ViewController: UIApplicationDelegate {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {

        if (launchOptions![UIApplicationLaunchOptionsLocationKey] != nil) {
         self.locationManager.startMonitoringSignificantLocationChanges()
        }
    return true
    }
    
}
