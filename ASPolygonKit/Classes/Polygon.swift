//
//  Polygon.swift
//
//  Created by Adrian Schoenig on 18/2/17.
//
//

import Foundation

import MapKit

public struct Polygon {
  var points: [Point] {
    didSet {
      firstLink = Polygon.firstLink(forPoints: points)
    }
  }
  
  fileprivate var firstLink: LinkedLine
  
  init(pairs: [(Double, Double)]) {
    points = pairs.map { pair in
      Point(ll: pair)
    }
    firstLink = Polygon.firstLink(forPoints: points)
  }
  
  var description: String? {
    return points.reduce("[ ") { previous, point in
      let start = previous.utf8.count == 2 ? previous : previous + ", "
      return start + point.description
    } + " ]"
  }
  
  
  // MARK: MapKit / CoreLocation
  
  init(_ polygon: MKPolygon) {
    let count = polygon.pointCount
    var coordinates = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: count)
    let range = NSRange(location: 0, length: count)
    polygon.getCoordinates(&coordinates, range: range)
    
    points = coordinates.map { coordinate in
      Point(ll: (coordinate.latitude, coordinate.longitude))
    }
    firstLink = Polygon.firstLink(forPoints: points)
  }
  
  var polygon: MKPolygon {
    var coordinates = points.map { point in
      point.coordinate
    }
    return MKPolygon(coordinates: &coordinates, count: coordinates.count)
  }
  
  // MARK: Polygon as list of lines
  
  private static func firstLink(forPoints points: [Point]) -> LinkedLine {
    var first: LinkedLine? = nil
    var previous: LinkedLine? = nil
    for (index, point) in points.enumerated() {
      let nextIndex = (index == points.endIndex - 1) ? points.startIndex : index + 1
      let next = points[nextIndex]
      let line = Line(start: point, end: next)
      let link = LinkedLine(line: line, next: nil)
      if first == nil {
        first = link
      }
      previous?.next = link
      previous = link
    }
    return first!
  }
  
  // MARK: Polygon to polygon intersections
  func intersections(_ polygon: Polygon) -> [Intersection] {
    var intersections : [Intersection] = []
    for link in firstLink {
      for other in polygon.firstLink {
        if let point = link.line.intersection(with: other.line) {
          let intersection = Intersection(point: point, myLink: link, yourLink: other)
          intersections.append(intersection)
        }
      }
    }
    return intersections
  }
  
  // MARK: Contains point check
  
  fileprivate func numberOfIntersections(_ line: Line) -> Int {
    var count = 0
    for link in firstLink {
      if let point = link.line.intersection(with: line) {
        if point != line.start && point != line.end {
          count += 1
        }
      }
    }
    return count
  }
  
  func contains(_ point: Point, onLine: Bool) -> Bool {
    if onLine {
      for link in firstLink {
        if link.line.contains(point) {
          return true
        }
      }
    }
    
    let ray = Line(start: point, end: Point(ll: (0, 0))) // assuming no polygon contains the coast of africa
    return numberOfIntersections(ray) % 2 == 1
  }
  
  func contains(_ polygon: Polygon) -> Bool {
    for point in polygon.points {
      if !contains(point, onLine: false) {
        return false
      }
    }
    return true
  }
  
  // MARK: Union
  
  mutating func union(_ polygon: Polygon) {
    let intersections = self.intersections(polygon)
    if intersections.count == 0 {
      return
    }
    
    let _ = union(polygon, with: intersections)
  }
  
  mutating func union(_ polygon: Polygon, with intersections: [Intersection]) -> Bool {
    if intersections.count == 0 {
      return false
    }
    
    if true {
      let path = quickLookPath
      let image = quickLookImage
      print("\(path) - \(image)")
    }
    
    var link: LinkedLine = firstLink
    
    // We need to start outside the other polygon
    while polygon.contains(link.line.start, onLine: true) {
      if let next = link.next {
        link = next
      } else {
        break
      }
    }
    
    let start = link.line.start
    var onMine = true
    var newPoints: [Point] = []
    
    repeat {
      Polygon.append(link.line.start, toPoints: &newPoints)
      
      if newPoints.count - points.count > polygon.points.count * 2 {
        NSLog("Could not merge \(polygon.description!) into \(self.description!)")
        return false
      }
      
      var lineIntersections: [(Intersection, Bool)] = []
      for intersection in intersections {
        if intersection.myLink == link || intersection.yourLink == link {
          
          // The two lines intersection. For this intersection we want to continue on the one which has a smaller clock wise angle.
          // We compare your angle `line.start - point - other.line.end` to mine `line.start - point - line.end`. It is possible that `point == other.line.end` in that case, we take the angle to `other.next.line.end`. Same thing with `point == line.end` in which case we compare to the angle to `line.next.end`
          
          let point = intersection.point
          let yourLink = intersection.yourLink
          let myLink = intersection.myLink
          
          var yourEnd: Point
          if point == yourLink.line.end {
            if let next = yourLink.next {
              yourEnd = next.line.end
            } else {
              yourEnd = polygon.firstLink.line.end
            }
          } else {
            yourEnd = yourLink.line.end
          }
          
          var myEnd: Point
          if point == myLink.line.end {
            if let next = myLink.next {
              myEnd = next.line.end
            } else {
              myEnd = firstLink.line.end
            }
          } else {
            myEnd = myLink.line.end
          }
          
          let yourAngle = angle(start: link.line.start, middle: point, end: yourEnd)
          let myAngle = angle(start: link.line.start, middle: point, end: myEnd)
          var continueOnMine = true // can be 'let = continueOnMine : Bool' in Swift 1.2
          if myAngle < yourAngle {
            continueOnMine = true
          } else if (yourAngle < myAngle) {
            continueOnMine = false
          } else {
            let myDistance = point.distance(from: myEnd)
            let yourDistance = point.distance(from: yourEnd)
            continueOnMine = myDistance > yourDistance
          }
          let candidate = (intersection, continueOnMine)
          lineIntersections.append(candidate as (Intersection, Bool))
        }
      }
      
      if let (closest, newOnMine) = closestIntersection(lineIntersections, to: link.line.start) {
        Polygon.append(closest.point, toPoints: &newPoints)
        onMine = newOnMine
        link = onMine ? closest.myLink : closest.yourLink
      }
      
      // the linked lines do not wrap around themselves, so we do that here manually
      if let next = link.next {
        link = next
      } else {
        link = onMine ? firstLink : polygon.firstLink
      }
    } while link.line.start != start
    
    
    points = newPoints
    return true
  }
  
  fileprivate static func append(_ point: Point, toPoints points: inout [Point]) {
    // 1) if we don't have a last point, just append it
    // 2) if we have a previous point and this is the same, skip it
    // 3) if we have two previous points and this is on the same line then remove the previous point and insert this one
    // 4) otherwise, append it
    if let last = points.last {
      if last == point {
        return // 2)
      }
      
      if points.count - 2 >= 0 {
        let lastLast = points[points.count - 2]
        let spanner = Line(start: lastLast, end: point)
        let next = Line(start: last, end: point)
        if (abs(spanner.m) > 1_000_000 && abs(next.m) > 1_000_000) // takes care of both being Infinity
          || abs(spanner.m - next.m) < 0.0001 {
          points.removeLast() // 3)
        }
      }
    }
    
    points.append(point) // 1, 3, 4)
  }
}

// To find the polygon between the two polygons, we see if there's an intersection between each pair of lines between the polygons. First we need to get the lines in a polygon.

private class LinkedLine: Sequence, Equatable {
  let line: Line
  var next: LinkedLine?
  
  init(line: Line, next: LinkedLine?) {
    self.line = line
    self.next = next
  }
  
  func makeIterator() -> AnyIterator<LinkedLine> {
    var this: LinkedLine? = self
    return AnyIterator {
      let ret = this
      this = this?.next
      return ret
    }
  }
}

private func ==(lhs: LinkedLine, rhs: LinkedLine) -> Bool {
  return lhs.line == rhs.line
}


// Let's calculate the intersections and keep for each intersection information about which line this intersection is with

public struct Intersection {
  let point: Point
  fileprivate let myLink: LinkedLine
  fileprivate let yourLink: LinkedLine
}

// For this exercise we assume that one polygon is never part of another, so we only need to deal with two cases: There's an overlap or there's none. Note, that if there's an overlap, we should have at least two intersection points.
// What do we do with the intersections?
// For each line that intersects we need to deal with the case that it has multiple intersections. Typically we are only concerned about the closest then.

private func closestIntersection(_ intersections: [(Intersection, Bool)], to point: Point) -> (Intersection, Bool)? {
  if (intersections.count <= 1) {
    return intersections.first
  } else {
    // the closest is the one with the least distance from the points to the intersection
    return intersections.reduce(nil) {
      prior, entry in
      if prior == nil || entry.0.point.distance(from: point) < prior!.0.point.distance(from: point) {
        return entry
      } else {
        return prior
      }
    }
  }
}


private func angle(start: Point, middle: Point, end: Point) -> Double {
  let v1 = Point(x: start.x - middle.x, y: start.y - middle.y)
  let v2 = Point(x: end.x - middle.x, y: end.y - middle.y)
  let arg1 = v1.x * v2.y - v1.y * v2.x
  let arg2 = v1.x * v2.x + v1.y * v2.y
  let atan = atan2(arg1, arg2)
  let degrees = atan * -180/M_PI
  if degrees < 0 {
    return degrees + 360
  } else {
    return degrees
  }
}
