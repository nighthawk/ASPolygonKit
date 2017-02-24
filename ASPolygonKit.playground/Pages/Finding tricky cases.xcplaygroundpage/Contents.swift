//: Playground - noun: a place where people can play

import Cocoa
import MapKit

let encoded = [
  "_aisJ~nyo@?_oyo@~nh\\??~nyo@",
  "oiivI~nyo@?_oyo@~qy@nihJ~iwC~r|V"
]

extension MKPolygon {
  
  convenience init(encoded: String) {
    let coordinates = CLLocationCoordinate2D.decodePolyline(encoded)
    self.init(coordinates: coordinates, count: coordinates.count)
  }
  
}

var polygons = encoded.map { MKPolygon(encoded: $0) }
polygons.sort {
  return $0.0.boundingMapRect.distanceFromOrigin < $0.1.boundingMapRect.distanceFromOrigin
}

var grower = Polygon(polygons[0])
print(grower.description!)

for i in 1..<polygons.count {
  let addition = Polygon(polygons[i])
  print(addition.description!)
  do {
    try grower.union(addition)
  } catch {
    print(error)
  }
}
grower


//let add1 = Polygon(polygons[1])
//try! grower.union(add1)
//grower
