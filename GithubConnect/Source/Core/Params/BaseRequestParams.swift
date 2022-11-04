import Foundation

protocol BaseRequestParams: Codable {
    func toString() -> String
}
