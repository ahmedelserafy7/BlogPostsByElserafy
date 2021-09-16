import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct BlogPostsByElserafy: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://blogpostsbyelserafy.com")!
    var name = "Blog Posts By Elserafy"
    var description = "Swift blog posts"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

private struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div(content: content).class("wrapper")
    }
}

private struct ItemList<Site: Website>: Component {
    var items: [Item<Site>]
    var site: Site

    var body: Component {
        List(items) { item in
            Article {
                H1(Link(item.title, url: item.path.absoluteString))
//                ItemTagList(item: item, site: site)
                Paragraph(item.description)
            } // article
        } // list
        .class("item-list")
    }
}

struct MyHTMLFactory<Site: Website>: HTMLFactory {
    
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML("hello world!")
    }
    
    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML("")
    }
    
    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML("")
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        try makeIndexHTML(for: context.index, context: context)
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }
}

extension Theme {
    static var myTheme: Theme {
        Theme(htmlFactory: MyHTMLFactory(), resourcePaths: ["Resources/MyTheme/styles.css"])
    }
}

// This will generate your website using the built-in Foundation theme:
try BlogPostsByElserafy().publish(withTheme: .myTheme)
