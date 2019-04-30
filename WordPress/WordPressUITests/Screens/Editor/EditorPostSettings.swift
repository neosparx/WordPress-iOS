import Foundation
import XCTest

class EditorPostSettings: BaseScreen {
    let backButton: XCUIElement
    let settingsTable: XCUIElement
    let categoriesSection: XCUIElement
    let tagsSection: XCUIElement
    let featuredImageButton: XCUIElement
    let mediaLibrary: XCUIElement

    init() {
        let app = XCUIApplication()
        backButton = app.navigationBars.element(boundBy: 0).buttons.element(boundBy: 0)
        settingsTable = app.tables["SettingsTable"]
        categoriesSection = settingsTable.cells["Categories"]
        tagsSection = settingsTable.cells["Tags"]
        featuredImageButton = settingsTable.cells["SetFeaturedImage"]
        mediaLibrary = app.cells.staticTexts["WordPress Media"]

        super.init(element: settingsTable)
    }

    func openCategories() -> CategoriesComponent {
        categoriesSection.tap()

        return CategoriesComponent()
    }

    func openTags() -> TagsComponent {
        tagsSection.tap()

        return TagsComponent()
    }

    func setFeaturedImage() -> EditorPostSettings {
        featuredImageButton.tap()
        mediaLibrary.tap()
        app.collectionViews.cells.element(boundBy: 0).tap() // Select latest uploaded image in media library

        return EditorPostSettings()
    }

    func verifyPostSettings(withCategory category: String? = nil, withTag tag: String? = nil, hasImage: Bool) -> EditorPostSettings {
        if let postCategory = category {
            XCTAssertTrue(categoriesSection.staticTexts[postCategory].exists, "Category \(postCategory) not set")
        }
        if let postTag = tag {
            XCTAssertTrue(tagsSection.staticTexts[postTag].exists, "Tag \(postTag) not set")
        }
        if hasImage {
            let imageCount = settingsTable.images.count
            XCTAssertTrue(imageCount == 1, "Featured image not set")
        }

        return EditorPostSettings()
    }

    func closePostSettings() -> EditorScreen {
        backButton.tap()

        return EditorScreen(mode: .rich)
    }

    static func isLoaded() -> Bool {
        return XCUIApplication().tables["SettingsTable"].exists
    }
}
