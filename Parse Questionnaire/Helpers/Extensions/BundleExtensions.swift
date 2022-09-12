// Project: Parse Questionnaire
//
//  Extension to make it easier to extract the version number of the app.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v \(releaseVersionNumber ?? "1.0.0")"
    }
    var releaseAndBuildVersionNumberPretty: String {
        return "v \(releaseVersionNumber ?? "1.0").\(buildVersionNumber ?? ".0")"
    }
}
