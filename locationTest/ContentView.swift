//
//  ContentView.swift
//  locationTest
//
//  Created by Cloutier, Vincent on 2020-11-25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    let locationFetcher = LocationFetcher()
    @State var textLocation = ""
    var body: some View {
        VStack {
            Text(textLocation)
            Button("Start Tracking Location") {
                self.locationFetcher.start()
            }

            Button("Read Location") {
                if let location = self.locationFetcher.lastKnownLocation {
                    textLocation = "Your location is \(location)"
                } else {
                    print("Your location is unknown")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
