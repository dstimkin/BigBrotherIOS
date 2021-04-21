import Foundation

struct Scenario: Codable {

    struct UserGroup: Codable {

        enum Relation: Int, Codable {
            case and
            case or
        }

        let relation: Relation
        let items: [String]
        let minimumNumberOfParticipants: Int

    }

    let suspended: Bool
    let timeFlag: Bool
    let timeFrom: String?
    let timeTo: String?
    let periodFlag: Bool
    let period: Int?
    let daysOfWeek: [Bool]
    let description: String
    let userGroups: [UserGroup]

}

extension Scenario {

    static var empty: Scenario {
//        return Scenario(description: .empty, userGroups: [Scenario.UserGroup]())
        return Scenario(suspended: false,
                        timeFlag: true,
                        timeFrom: "10:20",
                        timeTo: "18:00",
                        periodFlag: true,
                        period: 10,
                        daysOfWeek: [true, true, true, true, true, true, true],
                        description: "Some description. it could be quite long, so be ready for it",
                        userGroups: [UserGroup(relation: .and, items: ["Winston Churchill", "Charlie Chaplin", "Pablo Picasso"], minimumNumberOfParticipants: 1),
                                     UserGroup(relation: .or, items: ["Audrey Hepburn", "Marie Curie", "Yuri Gagarin"], minimumNumberOfParticipants: 2)])
    }

}
