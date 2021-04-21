import Foundation

extension String.Localized.Scenario {

    static var navBarTitle: String {
        return .localized("Scenario.navBarTitle")
    }

    enum ConcreteScenario {

        static var period1: String {
            return .localized("Scenario.ConcreteScenario.period1")
        }

        static var period2: String {
            return .localized("Scenario.ConcreteScenario.period2")
        }

        static var userGroup: String {
            return .localized("Scenario.ConcreteScenario.userGroup")
        }

        static var andRelation: String {
            return .localized("Scenario.ConcreteScenario.andRelation")
        }

        static var orRelation: String {
            return .localized("Scenario.ConcreteScenario.orRelation")
        }

        static var minimumParticipants: String {
            return .localized("Scenario.ConcreteScenario.minimumParticipants")
        }

    }

    static var negativeAttributeTitle: String {
        return .localized("Scenario.negativeAttributeTitle")
    }

    static var positiveAttributeTitle: String {
        return .localized("Scenario.positiveAttributeTitle")
    }

    static var optionalAttributeTitle: String {
        return .localized("Scenario.optionalAttributeTitle")
    }

}
