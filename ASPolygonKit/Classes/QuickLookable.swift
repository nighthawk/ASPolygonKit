import Foundation

#if os(iOS) || os(tvOS)
  public typealias SGKImage = UIImage
#elseif os(OSX)
  import Cocoa
  public typealias SGKImage = NSImage
#endif
  
extension Polygon {
  
  public var quickLookPath: CGPath {
    
    let maxLength: CGFloat = 200
    let factor = maxLength / CGFloat(Double.maximum(maxX - minX, maxY - minY))
    let offset = CGPoint(x: minX, y: minY) * factor
    
    let path = CGMutablePath()
    points.enumerated().forEach { index, point in
      if index == 0 {
        path.move(to: point.cgPoint * factor - offset)
      } else {
        path.addLine(to: point.cgPoint * factor - offset, transform: .identity)
      }
    }
    path.closeSubpath()
    return path
    
  }
  
  #if os(OSX)
  public var bezierPath: NSBezierPath {
    
    let maxLength: CGFloat = 200
    let factor = maxLength / CGFloat(Double.maximum(maxX - minX, maxY - minY))
    let offset = CGPoint(x: minX, y: minY) * factor
    
    let path = NSBezierPath()
    points.enumerated().forEach { index, point in
      if index == 0 {
        path.move(to: point.cgPoint * factor - offset)
      } else {
        path.line(to: point.cgPoint * factor - offset)
      }
    }
    path.close()
    return path
    
  }
  
  
  var quickLookImage: NSImage? {
    
    let path = bezierPath
    return NSImage(size: path.bounds.size, flipped: false) { rect in
      
      let strokeColor = NSColor.green
      strokeColor.setStroke()
      
      path.stroke()
      
      return true
    }
  }
  
  
  public var debugQuickLookObject: Any {
    
    return quickLookImage ?? description!
    
  }

  #endif
  
}

#if os(OSX)
extension Polygon: CustomPlaygroundQuickLookable {
  
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    if let image = quickLookImage {
      return .image(image)
    } else {
      return .text(description!)
    }
  }
  
}
#endif


func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
  return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
  return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

extension Point {
  
  var cgPoint: CGPoint {
    return CGPoint(x: x, y: y)
  }
  
}


