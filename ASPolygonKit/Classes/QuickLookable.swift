//
//  QuickLookable.swift
//  Pods
//
//  Created by Adrian Schoenig on 24/2/17.
//
//

import Foundation

extension Polygon {

  var minY: Double {
    return points.reduce(Double.infinity) { acc, point in
      return Double.minimum(acc, point.y)
    }
  }

  var maxY: Double {
    return points.reduce(Double.infinity * -1) { acc, point in
      return Double.maximum(acc, point.y)
    }
  }
  
  var minX: Double {
    return points.reduce(Double.infinity) { acc, point in
      return Double.minimum(acc, point.x)
    }
  }

  var maxX: Double {
    return points.reduce(Double.infinity * -1) { acc, point in
      return Double.maximum(acc, point.x)
    }
  }
  
  var quickLookPath: CGPath {
    
    let maxLength: CGFloat = 200
    let factor = 200 / CGFloat(Double.maximum(maxX - minX, maxY - minY))
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
  
  
  var quickLookImage: UIImage? {
    
    let path = quickLookPath
    
    // We have to create our own context here for drawing so that we can use
    // this within Xcode, too, not just on the device
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    guard let context = CGContext.init(
      data: nil,
      width: Int(path.boundingBox.size.width),
      height: Int(path.boundingBox.size.height),
      bitsPerComponent: 8,
      bytesPerRow: 0,
      space: colorSpace,
      bitmapInfo: UInt32(bitmapInfo.rawValue)) else {
        assertionFailure()
        return nil
    }
    UIGraphicsPushContext(context)

    UIGraphicsBeginImageContext(path.boundingBox.size)

    context.setFillColor(UIColor.red.cgColor)
    context.fill(path.boundingBox)
    
    context.setLineWidth(2)
    context.setStrokeColor(UIColor.green.cgColor)
    context.setFillColor(gray: 0, alpha: 0.5)
    context.addPath(path)
//    context.drawPath(using: .stroke)
    context.strokePath()
    context.fillPath()
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
    
  }
  
  public var debugQuickLookObject: Any {
    
    return quickLookImage ?? description
    
  }
  
}

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
