//
//  ASPolygonKitTests.swift
//  ASPolygonKitExampleTests
//
//  Created by Adrian Schoenig on 18/2/17.
//  Copyright © 2017 Adrian Schönig. All rights reserved.
//

import XCTest

import MapKit

#if canImport(UIKit)
import UIKit
#endif

@testable import ASPolygonKit

class ASPolygonKitTests: XCTestCase {
    
  func testAll() throws {
    let polygons = try polygonsFromJSON(named: "polygons-tripgo-170217")
    XCTAssertEqual(154, polygons.count)
  }

  func testCH() throws {
    let polygons = try polygonsFromJSON(named: "polygons-ch-170224")
    XCTAssertEqual(5, polygons.count)
    
    let merged = MKPolygon.union(polygons)
    XCTAssertEqual(1, merged.count)
  }
  
  func testUK() throws {
    let polygons = try polygonsFromJSON(named: "polygons-uk-170217")
    XCTAssertEqual(19, polygons.count)
    
    let merged = MKPolygon.union(polygons)
    XCTAssertEqual(1, merged.count)
  }

  func testScandinavia() throws {
    let polygons = try polygonsFromJSON(named: "polygons-scandinavia-170217")
    XCTAssertEqual(16, polygons.count)
    
    let merged = MKPolygon.union(polygons)
    XCTAssertEqual(1, merged.count)
  }
  
  
  func testInvariantToShuffling() throws {
    let polygons = try polygonsFromJSON(named: "polygons-uk-170217")
    XCTAssertEqual(19, polygons.count)
    
    let _ = (1...100).map { _ in
      let shuffled = polygons.shuffled()
      let merged = MKPolygon.union(shuffled)
      XCTAssertEqual(1, merged.count)
    }
  }
  
  func testOCFailure() throws {
    var grower = Polygon(pairs: [ (4,0), (4,3), (1,3), (1,0) ])
    let addition = Polygon(pairs: [ (5,1), (5,4), (3,4), (3,2), (2,2), (2,4), (0,4), (0,1) ])
    try grower.union(addition)
    XCTAssertEqual(12, grower.points.count)
  }
  
  
  func testSinglePointFailure() throws {
    var grower = Polygon(pairs: [ (53.5,-7.77), (52.15,-6.25), (51.2,-10) ])
    let addition = Polygon(pairs: [ (53.4600,-7.77), (54,-10), (55,-7.77) ])
    try grower.union(addition)
    XCTAssert(grower.points.count > 1)
  }
  
  func testPolygonContains() {
    let addition = Polygon(pairs: [ (53.4600,-7.77), (54,-10), (55,-7.77) ])
    
    XCTAssert( addition.contains(Point(ll: (53.5,-7.77)), onLine: true))
    XCTAssert(!addition.contains(Point(ll: (53.5,-7.77)), onLine: false))
  }

  func testUnsuccessfulUnion() throws {
    var grower = Polygon(pairs: [ (60.0000,-5.0000), (60.0000,0.0000), (56.2000,0.0000), (56.2000,-5.0000) ] )
    let addition = Polygon(pairs: [ (56.2500,-5.0000), (56.2500,0.0000), (55.9500,-1.8500), (55.1700,-5.7700) ] )
    
    try grower.union(addition)
    XCTAssert(grower.points.count > 1)
  }
}


extension ASPolygonKitTests {
  static func url(filename: String, ofType fileType: String = "json") -> URL {
    let sourceFile = URL(fileURLWithPath: #file)
    let directory = sourceFile.deletingLastPathComponent()
    let resourceURL =
      directory
        .appendingPathComponent("data", isDirectory: true)
        .appendingPathComponent(filename)
        .appendingPathExtension(fileType)
    return resourceURL
  }

  func polygonsFromJSON(named name: String) throws -> [MKPolygon] {
    guard
      let dict = try contentFromJSON(named: name) as? [String: Any],
      let encodedPolygons = dict ["polygons"] as? [String]
      else { preconditionFailure() }
    
    return encodedPolygons.map { MKPolygon(encoded: $0) }
  }
  
  
  func contentFromJSON(named name: String) throws -> Any {
    let url = Self.url(filename: name)
    let data = try Data(contentsOf: url)
    return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
  }
}

extension MKPolygon {
  convenience init(encoded: String) {
    let coordinates = CLLocationCoordinate2D.decodePolyline(encoded)
    self.init(coordinates: coordinates, count: coordinates.count)
  }
}

#if canImport(UIKit)
extension MKPolygon : CustomPlaygroundDisplayConvertible {
  public var playgroundDescription: Any {
    return quickLookImage ?? description
  }
  
  fileprivate var quickLookImage: UIImage? {
    let options = MKMapSnapshotter.Options()
    options.mapRect = self.boundingMapRect
    
    let snapshotter = MKMapSnapshotter(options: options)
    var image: UIImage?
    
    let semaphore = DispatchSemaphore(value: 1)
    snapshotter.start() { snapshot, error in
      image = snapshot?.image
      semaphore.signal()
    }
    
    semaphore.wait()
    return image
  }
  
  public var debugQuickLookObject: Any {
    return quickLookImage ?? description
  }
}
#endif
