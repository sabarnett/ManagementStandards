// Helper methods for loading the questionnaire data from disc.
//
// The questionnaire is part of the app bundle in a file called "ManagementQuestionnaire"
//

import Foundation

class QuestionnaireLoader {
    
    public static func load(forName: String) -> QuestionnaireData? {
        // Locate and load the data file
        if let jsonData = readLocalFile(forName: "ManagementQuestionnaire") {
            print(jsonData)
            
            // Create a questionnaire file
            let decodedData = try? JSONDecoder().decode(QuestionnaireData.self, from: jsonData)
            
            // Lets see what we got
            return decodedData!
        }

        return nil
    }

    fileprivate static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
