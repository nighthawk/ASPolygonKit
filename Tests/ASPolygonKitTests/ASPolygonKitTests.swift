//
//  ASPolygonKitTests.swift
//  ASPolygonKitExampleTests
//
//  Created by Adrian Schoenig on 18/2/17.
//  Copyright © 2017 Adrian Schönig. All rights reserved.
//

import XCTest

import ASPolygonKit

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
    
    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
  }
  
  func testUK() throws {
    let polygons = try polygonsFromJSON(named: "polygons-uk-170217")
    XCTAssertEqual(19, polygons.count)
    
    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
  }

  func testScandinavia() throws {
    let polygons = try polygonsFromJSON(named: "polygons-scandinavia-170217")
    XCTAssertEqual(16, polygons.count)
    
    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
  }
  
  func testStaya() throws {
    let polygons = try polygonsFromJSON(named: "polygons-au-211102")
    XCTAssertEqual(13, polygons.count)
    
    let merged = try Polygon.union(polygons)
    XCTAssertEqual(7, merged.count)
  }
  
  func testInvariantToShuffling() throws {
    let polygons = try polygonsFromJSON(named: "polygons-uk-170217")
    XCTAssertEqual(19, polygons.count)
    
    let _ = try (1...100).map { _ in
      let shuffled = polygons.shuffled()
      let merged = try Polygon.union(shuffled)
      XCTAssertEqual(1, merged.count)
    }
  }
  
  func testOCFailure() throws {
    var grower = Polygon(pairs: [ (4,0), (4,3), (1,3), (1,0) ])
    let addition = Polygon(pairs: [ (5,1), (5,4), (3,4), (3,2), (2,2), (2,4), (0,4), (0,1) ])
    let merged = try grower.union(addition)
    XCTAssertTrue(merged)
    XCTAssertEqual(12, grower.points.count)
  }
  
  func testSinglePointFailure() throws {
    var grower = Polygon(pairs: [ (53.5,-7.77), (52.15,-6.25), (51.2,-10) ])
    let addition = Polygon(pairs: [ (53.4600,-7.77), (54,-10), (55,-7.77) ])
    let merged = try grower.union(addition)
    XCTAssertTrue(merged)
    XCTAssert(grower.points.count > 1)
  }
  
  func testPolygonContains() {
    let addition = Polygon(pairs: [ (53.4600,-7.77), (54,-10), (55,-7.77) ])
    
    XCTAssert( addition.contains(Point(latitude: 53.5, longitude: -7.77), onLine: true))
    XCTAssert(!addition.contains(Point(latitude: 53.5, longitude: -7.77), onLine: false))
  }

  func testUnsuccessfulUnion() throws {
    var grower = Polygon(pairs: [ (60.0000,-5.0000), (60.0000,0.0000), (56.2000,0.0000), (56.2000,-5.0000) ] )
    let addition = Polygon(pairs: [ (56.2500,-5.0000), (56.2500,0.0000), (55.9500,-1.8500), (55.1700,-5.7700) ] )
    
    let merged = try grower.union(addition)
    XCTAssertTrue(merged)
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

  func polygonsFromJSON(named name: String) throws -> [ASPolygonKit.Polygon] {
    guard
      let dict = try contentFromJSON(named: name) as? [String: Any],
      let encodedPolygons = dict ["polygons"] as? [String]
      else { preconditionFailure() }
    
    return encodedPolygons.map { Polygon(encoded: $0) }
  }
  
  
  func contentFromJSON(named name: String) throws -> Any {
    let url = Self.url(filename: name)
    let data = try Data(contentsOf: url)
    return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
  }
}

extension ASPolygonKit.Polygon {
  init(encoded: String) {
    let points = Point.decodePolyline(encoded)
    self.init(points: points)
  }
}
