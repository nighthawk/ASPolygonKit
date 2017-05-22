//: [Previous](@previous)

//: When hitting an issue, start with the output from the log, looking for an issue like:
//: `Could not merge [ ... ] into [ ... ]`
//: Grab those two and place the first into `adder` and the latter into `grower`

import Foundation

import ASPolygonKit_Sources

var grower = Polygon(pairs: [ (53.500,8.5310), (53.9430,8.6430), (53.8760,8.8000), (53.8760,9.2660), (53.4460,9.2660), (53.0590,10.2340) ] )

let adder = Polygon(pairs: [ (53.8700,8.8500), (54.1898,8.8500), (54.1898,11.1400), (53.0478,11.1400), (53.0478,10.2070), (53.4380,9.2430) ] )

//: The following output will print a sad smiley if there was an issue.
//: If that's the case: Remove points from either polygon until the party starts.

let before = grower.description!.utf8.count

do {
  try grower.union(adder)
  grower
  
  let after = grower.description!.utf8.count
  if after == before {
    print("😩")
  } else {
    print("😃🎉🎊💃")
  }
  
} catch {
  print("😩")
}
