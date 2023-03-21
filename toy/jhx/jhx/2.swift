import UIKit

extension UIImage {
  public static func exists(_ url: URL?) -> Bool {
    guard let url = url, let dataURL = UIImage.crateImageFolder() else { return false }
    let destinationFilename = URL(fileURLWithPath: dataURL.appendingPathComponent("\(url.absoluteString.hash).jpg").absoluteString)
    
    if FileManager.default.fileExists(atPath: destinationFilename.path) {
      return true
    }
    if let urlString = url.valueOf("url")?.removingPercentEncoding, let url = URL(string: urlString) {
      return UIImage.exists(url)
    }
    return false
  }
  
  class func load(_ url: URL?) -> UIImage? {
    guard let url = url, let dataURL = UIImage.crateImageFolder() else { return nil }
    let destinationFilename = URL(fileURLWithPath: dataURL.appendingPathComponent("\(url.absoluteString.hash).jpg").absoluteString)
    guard let imageData = try? Data(contentsOf: destinationFilename) else { return nil }
    return UIImage(data: imageData)
  }
  
  func store(_ url: URL?) {
    DispatchQueue.global(qos: .background).async {
      guard let url = url, let dataURL = UIImage.crateImageFolder() else { return }
      let destinationFilename = URL(fileURLWithPath: dataURL.appendingPathComponent("\(url.absoluteString.hash).jpg").absoluteString)
      do {
        try self.jpegData(compressionQuality: 1)?.write(to: destinationFilename)
      } catch {}
    }
  }
  
  private class func path() -> URL? {
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    return URL(string: paths[0])
  }
  
  private class func crateImageFolder() -> URL? {
    guard let pathURL = UIImage.path() else { return nil }
    let dataURL = pathURL.appendingPathComponent("images")
    try? FileManager.default.createDirectory(atPath: dataURL.absoluteString, withIntermediateDirectories: true, attributes: nil)
    return dataURL
  }
  
  func resize(_ width: CGFloat) -> UIImage? {
    guard width > 0 else {
      return self
    }
    let oldWidth = size.width
    let scaleFactor = width / oldWidth
    let newHeight = size.height * scaleFactor
    let newWidth = oldWidth * scaleFactor
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }
}

public extension URL {
  func createImageApi(with format: String?, width: Int) -> URL? {
    guard let format = format, scheme != "file" else { return nil }
    let percentEncod = absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    let urlString = String(format: format, percentEncod ?? "", width * Int(UIScreen.main.scale))
    return URL(string: urlString)
  }
  
  func createImageApi(with format: String?, width: Int, headerFields: HTTPHeaderFields? = nil) -> URLRequest? {
    createImageApi(with: format, width: width)?.createRequest(headerFields: headerFields)
  }
  
  func createRequest(headerFields: HTTPHeaderFields? = nil) -> URLRequest? {
    var request = URLRequest(url: self)
    headerFields?.forEach {
      request.setValue($0.value, forHTTPHeaderField: $0.key)
    }
    return request
  }
  
  internal func valueOf(_ queryParamaterName: String) -> String? {
    guard let url = URLComponents(string: absoluteString) else { return nil }
    return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
  }
}

extension String {
  var hash: Int {
    let unicodeScalars = self.unicodeScalars.map { $0.value }
    return unicodeScalars.reduce(5381) {
      ($0 << 5) &+ $0 &+ Int($1)
    }
  }
}

public typealias HTTPHeaderFields = [String: String]

public protocol RequestAdapterProtocol {
  func adapt(_ urlRequest: URLRequest) -> URLRequest
}

open class HTTPHeaderFieldsRequestAdapter: RequestAdapterProtocol {
  let httpHeaderFields: HTTPHeaderFields

  public init(_ headerFields: HTTPHeaderFields) {
    self.httpHeaderFields = headerFields
  }

  open func adapt(_ urlRequest: URLRequest) -> URLRequest {
    var urlRequest = urlRequest

    for headerfield in httpHeaderFields {
      urlRequest.setValue(headerfield.value, forHTTPHeaderField: headerfield.key)
    }

    return urlRequest
  }
}
