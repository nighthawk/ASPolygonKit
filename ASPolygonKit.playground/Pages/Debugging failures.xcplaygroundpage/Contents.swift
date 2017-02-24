//: [Previous](@previous)

import Foundation

var grower = Polygon(pairs: [ (47.6,5.8), (47.24,9.8), (47.2,7.8), (46.8,7.8), (47.1,9.7), (46.2,10.5), (45.9,5.7), (46.6,5.7) ])

let adder = Polygon(pairs: [ (47.2,7.7), (47.3,9.7), (47.0,9.7), (46.7,7.7) ])

do {
  try grower.union(adder)
  grower
} catch {
  
  print(":(")
}

//: ---
//: ### Let's explore what's going on here
//:
//: Basic assumption is that we have intersections:

grower.intersects(adder)

//: Now that is confirmed. Does it work the other way around?

do {
  var newGrower = adder
  try newGrower.union(grower)
  newGrower
  
} catch {
  print(":(")
}

//: Oh, gosh, that worked but the result is even worse!
//: As of the time of this writing, this is succeeding but it's resulting in a polygon that only has two additional points and is missing most of the `newAdder` polygon!
//: Let's try to simplify this a bit:

grower = Polygon(pairs: [ (4,0), (4,3), (1,3), (1,0) ])

var newAdder = Polygon(pairs: [ (5,1), (5,4), (3,4), (3,2), (2,2), (2,4), (0,4), (0,1) ])

try! grower.union(newAdder)
grower

//:
//: Ok, so now we have two issues:
//:
//: 1. Union crashing with an error, likely due to the new polygon being an inner polygon.
//: 2. Union isn't creating the full polygon
//:
//: Arguable 2 is more significant than 1.
//:
//: ---

//: [Next](@next)
