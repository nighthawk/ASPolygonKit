//
//  ASPolygonKitTests.swift
//  ASPolygonKitExampleTests
//
//  Created by Adrian Schoenig on 18/2/17.
//  Copyright © 2017 Adrian Schönig. All rights reserved.
//

import XCTest

import MapKit
import ASPolygonKit

@testable import ASPolygonKitExample

class ASPolygonKitTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testAll() {
    
    let polygons = polygonsFromJSON(named: "polygons-tripgo-170217")
    XCTAssertEqual(154, polygons.count)
  }

  func testCH() {
    
    let polygons = polygonsFromJSON(named: "polygons-ch-170224")
    XCTAssertEqual(5, polygons.count)
    
    let merged = MKPolygon.union(polygons)
    XCTAssertEqual(1, merged.count)
  }
  
  
  func testUK() {
    
    let polygons = polygonsFromJSON(named: "polygons-uk-170217")
    XCTAssertEqual(19, polygons.count)
    
    let merged = MKPolygon.union(polygons)
    XCTAssertEqual(1, merged.count)
  }

  func testScandinavia() {
    
    let polygons = polygonsFromJSON(named: "polygons-scandinavia-170217")
    XCTAssertEqual(16, polygons.count)
    
    let merged = MKPolygon.union(polygons)
    XCTAssertEqual(1, merged.count)
  }
  
  
  func testInvariantToShuffling() {
    
    let polygons = polygonsFromJSON(named: "polygons-uk-170217")
    XCTAssertEqual(19, polygons.count)
    
    let _ = (1...100).map { _ in
      let shuffled = polygons.shuffle()
      let merged = MKPolygon.union(shuffled)
      XCTAssertEqual(1, merged.count)
    }
    
  }
  
  
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
    
}


extension ASPolygonKitTests {
  
  func polygonsFromJSON(named name: String) -> [MKPolygon] {
    guard
      let dict = contentFromJSON(named: name) as? [String: Any],
      let encodedPolygons = dict ["polygons"] as? [String]
      else { preconditionFailure() }
    
    return encodedPolygons.map { MKPolygon(encoded: $0) }
  }
  
  func contentFromJSON(named name: String) -> Any {
    let bundle = Bundle(for: ASPolygonKitTests.self)
    let filePath = bundle.path(forResource: name, ofType: "json")
    let data = try? Data(contentsOf: URL(fileURLWithPath: filePath!))
    let object: Any? = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0))
    return object!
  }
  
}

extension Collection {
  /// Return a copy of `self` with its elements shuffled
  func shuffle() -> [Iterator.Element] {
    var list = Array(self)
    list.shuffleInPlace()
    return list
  }
}

extension MutableCollection where Index == Int {
  /// Shuffle the elements of `self` in-place.
  mutating func shuffleInPlace() {
    guard let count = count as? Int else { preconditionFailure() }
    
    // empty and single-element collections don't shuffle
    if count < 2 { return }
    
    for i in 0..<count - 1 {
      let j = Int(arc4random_uniform(UInt32(count - i))) + i
      guard i != j else { continue }
      swap(&self[i], &self[j])
    }
  }
}



extension MKPolygon {
  
  convenience init(encoded: String) {
    let coordinates = CLLocationCoordinate2D.decodePolyline(encoded)
    self.init(coordinates: coordinates, count: coordinates.count)
  }
  
}

extension MKPolygon : CustomPlaygroundQuickLookable {
  
  fileprivate var quickLookImage: UIImage? {
   
    let options = MKMapSnapshotOptions()
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
  
  
  
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    
    if let image = quickLookImage {
      return .image(image)
    } else {
      return .text(description)
    }
    
  }
  
  
}
