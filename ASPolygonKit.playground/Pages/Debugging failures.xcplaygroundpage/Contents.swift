//: [Previous](@previous)

import Foundation

var grower = Polygon(pairs: [ (47.6,5.8), (47.24,9.8), (47.2,7.8), (46.8,7.8), (47.1,9.7), (46.2,10.5), (45.9,5.7), (46.6,5.7) ])

let adding = Polygon(pairs: [ (47.2,7.7), (47.3,9.7), (47.0,9.7), (46.7,7.7) ])

do {
  try grower.union(adding)
  grower
} catch {
  print(":(")
}


//: [Next](@next)
