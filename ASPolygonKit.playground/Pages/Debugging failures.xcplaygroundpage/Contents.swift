//: [Previous](@previous)

import Foundation

var grower = Polygon(pairs: [ (60.0000,-5.0000), (60.0000,0.0000), (56.2000,0.0000), (56.2000,-5.0000) ] )

let adder = Polygon(pairs: [ (56.2500,-5.0000), (56.2500,0.0000), (55.9500,-1.8500), (55.1700,-5.7700) ] )

do {
  try grower.union(adder)
  grower
} catch {
  print(":(")
}
