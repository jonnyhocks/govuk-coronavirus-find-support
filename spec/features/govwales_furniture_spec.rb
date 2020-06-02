# frozen_string_literal: true

require "spec_helper"

RSpec.feature "GovWales furniture" do
  context "English language" do
    before do
      visit "/start"
    end

    scenario "header is rendered" do
      within "body > header" do
        within "a[href='https://gov.wales/'][title='Welsh Government']" do
          expect(page).to have_css("img[alt='Welsh Government'][src*='govwales/wg_logo']")
        end
      end
    end

    scenario "beta-bar is rendered" do
      within ".beta-bar" do
        expect(page).to have_css("div", text: "BETA")
        expect(page).to have_css("p", text: "This is a new service.")
        expect(page).to have_css("p", text: "Give feedback to help improve it.")
        expect(page).to have_css("a[href^='mailto:']", text: "Give feedback")
      end
    end

    scenario "service-title is rendered" do
      within "body > .govwales-width-container" do
        expect(page).to have_link("Back", href: "/")
        expect(page).to have_text("Finder")
        expect(page).to have_text("Find help if you’re struggling because of coronavirus")
      end
    end

    scenario "footer is rendered" do
      within "body > footer" do
        expect(page).to have_text("Accessibility Cookies Privacy Copyright statement")

        within "a[href='https://gov.wales/']" do
          expect(page).to have_css("img[alt='Welsh Government'][src*='govwales/footer-logo']")
        end
      end
    end
  end

  context "Welsh language" do
    before do
      visit "/dechrau" # dechrau = start
    end

    scenario "header is rendered" do
      within "body > header" do
        within "a[href='https://llyw.cymru/'][title='Llywodraeth Cymru']" do
          expect(page).to have_css("img[alt='Llywodraeth Cymru'][src*='govwales/wg_logo']")
        end
      end
    end

    scenario "beta-bar is rendered" do
      within ".beta-bar" do
        expect(page).to have_css("div", text: "BETA")
        expect(page).to have_css("p", text: "Gwasanaeth newydd yw hwn.")
        expect(page).to have_css("p", text: "Rhowch adborth i'n helpu i'w wella")
        expect(page).to have_css("a[href^='mailto:']", text: "Rhowch adborth")
      end
    end

    scenario "service-title is rendered" do
      within "body > .govwales-width-container" do
        expect(page).to have_link("Yn ôl", href: "/") # Back link
        expect(page).to have_text("Chwiliwr")

        expect(page).to have_text(
          "Dod o hyd i help os ydych yn cael pethau'n anodd oherwydd y coronafeirws",
        )
      end
    end

    scenario "footer is rendered" do
      within "body > footer" do
        expect(page).to have_text("Hygyrchedd Cwcis Preifatrwydd Datganiad hawlfraint")

        within "a[href='https://llyw.cymru/']" do
          expect(page).to have_css("img[alt='Llywodraeth Cymru'][src*='govwales/footer-logo']")
        end
      end
    end
  end
end
