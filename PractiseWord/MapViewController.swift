//
//  MapViewController.swift
//  PractiseWord
//
//  Created by xionghao on 2019/6/12.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    /*
     When a view controller is created, its view property is nil. If a view controller is asked for its view and
     its view is nil, then the loadView() method is called.
     */
    override func loadView() {
        mapView = MKMapView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController load")
    }
}
