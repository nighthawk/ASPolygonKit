//: Playground - noun: a place where people can play

import Cocoa
import MapKit

var str = "Hello, playground"

let swissEncoded = [
  "{xk_H{icn@ymE}hbKvr}@taB`xu@|h_K",
  "kvb|G{xal@cecAg~cMjVoheDb{xCucAjqlBtpmHo`^`zyBtrAlvzAtmLfhgB",
  "ynvuG{iul@{iv@htlIu{sChhC?s}pI",
  "wwdaHu}yh@eiXoy{Dp{mE??|krK",
  "wttaHegcn@qyl@snlDj~cAoquE|kr@~[nlD~cbK"
]

extension MKPolygon {
  
  convenience init(encoded: String) {
    let coordinates = CLLocationCoordinate2D.decodePolyline(encoded)
    self.init(coordinates: coordinates, count: coordinates.count)
  }
  
}

var swiss = swissEncoded.map { MKPolygon(encoded: $0) }
swiss.sort {
  return $0.0.boundingMapRect.distanceFromOrigin < $0.1.boundingMapRect.distanceFromOrigin
}

var grower = Polygon(swiss[0])

let second = Polygon(swiss[1])
try! grower.union(second)
grower

let third = Polygon(swiss[2])
try! grower.union(third)
grower

let forth = Polygon(swiss[3])
try! grower.union(forth)
grower

let fifth = Polygon(swiss[4])

print(grower.description!)
print(fifth.description!)


//try! grower.union(fifth)
grower
