# ASPolygonKit

[![CI](https://github.com/nighthawk/ASPolygonKit/actions/workflows/swift.yml/badge.svg)](https://github.com/nighthawk/ASPolygonKit/actions/workflows/swift.yml)

Functionality:

- Polygon union

`ASPolygonKit` is tested and confirmed working on on iOS, macOS and Linux. It might work on other platforms, too.

## Installation

### Swift Package Manager

To install ASPolygonKit using the [Swift Package Manager](https://swift.org/package-manager/), add the following package to the `dependencies` in your Package.swift file:

```swift
.package(name: "ASPolygonKit", url: "https://github.com/nighthawk/aspolygonkit.git", from: "0.4.0"),
```

## Usage

`import ASPolygonKit` in any Swift file in your module.

Example, usage merging a GeoJSON polygon from [GeoJSONKit](https://github.com/maparoni/GeoJSONKit):

```swift
import GeoJSONKit
import ASPolygonKit

extension GeoJSON.Polygon {
  public static func union(_ polygons: [GeoJSON.Polygon]) throws -> [GeoJSON.Polygon] {
    try ASPolygonKit.Polygon.union(polygons.map(ASPolygonKit.Polygon.init))
      .map { polygon in
        .init(exterior: .init(positions: polygon.points.map { .init(latitude: $0.lat, longitude: $0.lng) }))
      }
  }
}

private extension ASPolygonKit.Polygon {
  init(_ geojson: GeoJSON.Polygon) {
    self.init(points: geojson.exterior.positions.map { .init(latitude: $0.latitude, longitude: $0.longitude) })
  }
}

```

## Author

adrian@schoenig.me

## License

ASPolygonKit is available under the MIT license. See the LICENSE file for more info.
