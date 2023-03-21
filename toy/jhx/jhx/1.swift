import Combine
import SwiftUI

struct AsyncImageURL: View {
  @ObservedObject private var viewModel: ViewModel
  @StateObject var imageLoader = ImageLoader()
  @State var image = UIImage()
  @State var animated = false
  private var maxWidth: CGFloat?
  private var urlRequest: URLRequest
  private var placeholder: String?

  init(urlString: String, placeholder: String? = "", maxWidth: CGFloat? = nil, animated: Bool = false) {
    let urlRequest = URLRequest(url: URL(string: urlString)!)
    self.init(urlRequest: urlRequest, placeholder: placeholder, maxWidth: maxWidth, animated: animated)
  }
  
  init(url: URL, placeholder: String? = "", maxWidth: CGFloat? = nil, animated: Bool = false) {
    self.init(urlRequest: URLRequest(url: url), placeholder: placeholder, maxWidth: maxWidth, animated: animated)
  }
  
  init(urlRequest: URLRequest, placeholder: String? = "", maxWidth: CGFloat? = nil, animated: Bool = false) {
    self.urlRequest = urlRequest
    self.placeholder = placeholder
    self.maxWidth = maxWidth
    self.viewModel = .init()
    
    guard let url = urlRequest.url else { return }
    self.viewModel.tag = url.absoluteString.hash
    self.animated = animated

    if let newImage = UIImage.load(url) {
      setNewImage(image: newImage, animated: animated)
    } else if let urlString = url.valueOf("url")?.removingPercentEncoding,
              let url = URL(string: urlString), let newImage = UIImage.load(url) {
      setNewImage(image: newImage, animated: animated)
    }
    
  }

  func setNewImage(image: UIImage, animated: Bool) {
    if animated {
      withAnimation {}
    } else {
      self.image = image
    }
  }

  // MARK: - body

  var body: some View {
    GeometryReader { geometry in
      Image(uiImage: image)
//      imageLoader.loadImage(imageRequest: urlRequest) { output in
//        print(output)
//      }
        .onAppear {
          imageLoader.loadImage(imageRequest: urlRequest) { output in
            var response = output.response
            var data = output.data
            let width = geometry.size.width
            var scaledMaxWidth: CGFloat = .zero

            if let maxWidth = maxWidth {
              scaledMaxWidth = maxWidth * UIScreen.main.scale
            }else {
              scaledMaxWidth = width
            }
            self.viewModel.downloadAndStore(response: response, data: data, maxWith: scaledMaxWidth) { image,httpURLResponse  in
              guard let tag = self.viewModel.tag, let url = httpURLResponse.url, tag == url.absoluteString.hash else { return }
              if animated {
                withAnimation {
                  self.image = image
                }
              } else {
                self.image = image
              }
            }
          }
        }
    }
  }
}

extension AsyncImageURL {
  final class ViewModel: ObservableObject {
    var tag: Int?
    
    init() {}
    func downloadAndStore(response: URLResponse, data: Data, maxWith: CGFloat = 0, completion: ((UIImage, HTTPURLResponse) -> Void)?) {
      if let url = response.url, url.scheme == "file" {
        DispatchQueue.main.async {
          let httpURLResponse = HTTPURLResponse(url: url, mimeType: "image", expectedContentLength: data.count, textEncodingName: nil)
          completion?(UIImage(data: data) ?? UIImage(), httpURLResponse)
        }
      }
      guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response.mimeType, mimeType.hasPrefix("image"),
            let image = UIImage(data: data)
      else {
        return
      }
      var imageToSave = image.resize(maxWith) ?? image
//      if appConfig.isFeatureEnabled("feature.resize_cached_images"), image.size.width > maxWith {
//        imageToSave = image.resize(maxWith) ?? image
//      }
      
      imageToSave.store(httpURLResponse.url)
      if let urlString = httpURLResponse.url?.valueOf("url")?.removingPercentEncoding, let url = URL(string: urlString) {
        if let lastImage = UIImage.load(url), image.size.height > lastImage.size.height, image.size.width > lastImage.size.width {
          imageToSave.store(url)
        } else if UIImage.load(url) == nil {
          imageToSave.store(url)
        }
      }
      DispatchQueue.main.async {
        completion?(imageToSave, httpURLResponse)
      }
    }
  }
}

struct AsyncImageURL_Previews: PreviewProvider {
  static var previews: some View {
    AsyncImageURL(urlString: "https://images.unsplash.com/photo-1549740425-5e9ed4d8cd34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80").padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
  }
}

class ImageLoader: ObservableObject {
  private var cancellables = Set<AnyCancellable>()

  func loadImage(imageRequest: URLRequest, completion: @escaping (_ data: URLSession.DataTaskPublisher.Output) -> Void) {
    URLSession
      .shared
      .dataTaskPublisher(for: imageRequest)
      .receive(on: DispatchQueue.main)
      .sink { _ in
      } receiveValue: { output in
        completion(output)
      }
      .store(in: &cancellables)
  }
}
