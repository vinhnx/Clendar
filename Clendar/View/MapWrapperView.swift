//
//  MapView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 12/18/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapWrapperView: View {
    var location: Location

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(),
        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    )

    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: [location]
        ) { location in
            MapPin(coordinate: location.coordinate, tint: .appRed)
        }
        .onAppear { region.center = location.coordinate }
        .frame(minWidth: 200,
               idealWidth: 300,
               maxWidth: .infinity,
               minHeight: 200,
               idealHeight: 350,
               maxHeight: .infinity
        )
        .cornerRadius(10)
    }
}
