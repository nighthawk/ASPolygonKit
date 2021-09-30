//
//  MKPolygon+Union.swift
//
//  Created by Adrian Schoenig on 18/2/17.
//
//

#if canImport(MapKit)
import MapKit
#endif

extension Polygon {
  public static func union(_ polygons: [Polygon]) -> [Polygon] {
    let sorted = polygons.sorted { first, second in
      if first.minY < second.minY {
        return true
      } else if second.minY < first.minY {
        return false
      } else {
        return first.minX < second.minX
      }
    }
    
    return sorted.reduce([]) { polygons, polygon in
      return union(polygons, with: polygon)
    }
  }
  
  public static func union(_ polygons: [Polygon], with polygon: Polygon) -> [Polygon] {
    var grower = polygon
    var newArray: [Polygon] = []
    
    for existing in polygons {
      if existing.contains(grower) {
        grower = existing
        continue
      }
      let intersections = grower.intersections(existing)
      if intersections.count > 0 {
        do {
          try grower.union(existing, with: intersections)
        } catch {
          newArray.append(existing)
        }
      } else {
        newArray.append(existing)
      }
    }
    
    newArray.append(grower)
    return newArray
  }
  
}

#if canImport(MapKit)
extension MKPolygon {
  
  @objc(unionOfPolygons:completionHandler:)
  public class func union(_ polygons: [MKPolygon], completion: @escaping ([MKPolygon]) -> Void) {
    let queue = DispatchQueue(label: "MKPolygonUnionMerger", qos: .background)
    queue.async {
      let result = union(polygons)
      DispatchQueue.main.async {
        completion(result)
      }
    }
  }
  
  @objc(unionOfPolygons:)
  public class func union(_ polygons: [MKPolygon]) -> [MKPolygon] {
    
    let sorted = polygons.sorted(by: { first, second in
      return first.boundingMapRect.distanceFromOrigin < second.boundingMapRect.distanceFromOrigin
    })
    
    return sorted.reduce([]) { polygons, polygon in
      return union(polygons, with: polygon)
    }
    
    //    return polygons.reduce([]) { polygons, polygon in
    //      return union(polygons, with: polygon)
    //    }
    
  }
  
  @objc(unionOfPolygons:withPolygon:)
  public class func union(_ polygons: [MKPolygon], with polygon: MKPolygon) -> [MKPolygon] {
    var grower = Polygon(polygon)
    var newArray: [MKPolygon] = []
    
    for existing in polygons {
      let existingStruct = Polygon(existing)
      if existingStruct.contains(grower) {
        grower = existingStruct
        continue
      }
      let intersections = grower.intersections(existingStruct)
      if intersections.count > 0 {
        do {
          try grower.union(existingStruct, with: intersections)
        } catch {
          newArray.append(existing)
        }
      } else {
        newArray.append(existing)
      }
    }
    
    newArray.append(grower.polygon)
    return newArray
  }
  
  public func contains(_ coordinate: CLLocationCoordinate2D) -> Bool {
    if (!boundingMapRect.contains(MKMapPoint(coordinate))) {
      return false
    }
    
    // It's in the bounding rect, but is it in the detailed shape?
    let polygon = Polygon(self)
    let point = Point(latitude: coordinate.latitude, longitude: coordinate.longitude)
    return polygon.contains(point, onLine: true)
  }
}

extension MKMapRect {
  
  public var distanceFromOrigin: Double {
    return sqrt( origin.x * origin.x + origin.y * origin.y )
  }
  
}

//MARK: - Compatibility

extension Point {
  public var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: lat, longitude: lng)
  }
  
  public var annotation: MKPointAnnotation {
    let point = MKPointAnnotation()
    point.coordinate = self.coordinate
    return point
  }
}

extension Line {
  public var polyline: MKPolyline {
    var points = [start.coordinate, end.coordinate]
    return MKPolyline(coordinates: &points, count: points.count)
  }
}

extension Polygon {
  public init(_ polygon: MKPolygon) {
    let count = polygon.pointCount
    var coordinates = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: count)
    let range = NSRange(location: 0, length: count)
    polygon.getCoordinates(&coordinates, range: range)
    
    points = coordinates.map { coordinate in
      Point(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    firstLink = Polygon.firstLink(for: points)
  }
  
  var polygon: MKPolygon {
    var coordinates = points.map { point in
      point.coordinate
    }
    return MKPolygon(coordinates: &coordinates, count: coordinates.count)
  }
}

#endif
