# frozen_string_literal: true

require "spec_helper"

RSpec.feature "GovWales language switch" do
  context "English to Welsh" do
    scenario "switch from start page" do
      visit "/start"

      expect(current_path).to eq "/need-help-with"
      expect(page).to have_css("h1", text: "What do you need help with because of coronavirus?")

      within "header" do
        click_link "Cymraeg"
      end

      expect(current_path).to eq "/angen-help-gyda" # angen-help-gyda = need-help-with
      expect(page).to have_css("header .header__components__language", text: "English")
      expect(page).to have_css(
        "h1",
        text: "Gyda beth y mae angen cymorth arnoch oherwydd y coronafeirws?",
      )
    end

    scenario "switch whilst in the journey" do
      visit "/start"
      check "Paying bills"
      click_on "Continue"

      expect(current_path).to eq "/afford-rent-mortgage-bills"

      expect(page).to have_css(
        "h1",
        text: "Are you finding it hard to afford rent, your mortgage or bills?",
      )

      within "header" do
        click_link "Cymraeg"
      end

      # When switching to Welsh, the user is taken back to the start of the journey
      expect(current_path).to eq "/angen-help-gyda"

      expect(page).to have_css(
        "h1",
        text: "Gyda beth y mae angen cymorth arnoch oherwydd y coronafeirws?",
      )
    end

    scenario "switch whilst on the Cookies page" do
      visit "/cookies"

      expect(current_path).to eq "/cookies"
      expect(page).to have_css("h1", text: "Cookies")

      within "header" do
        click_link "Cymraeg"
      end

      expect(current_path).to eq "/cwcis"
      expect(page).to have_css("h1", text: "Cwcis")
    end

    scenario "switch whilst on the Privacy page" do
      visit "/privacy"

      expect(current_path).to eq "/privacy"
      expect(page).to have_css("h1", text: "Website privacy notice")

      within "header" do
        click_link "Cymraeg"
      end

      expect(current_path).to eq "/preifatrwydd"
      expect(page).to have_css("h1", text: "Hysbysiad preifatrwydd gwefan")
    end
  end

  context "Welsh to English" do
    scenario "switch from start page" do
      visit "/dechrau" # dechrau = start

      expect(current_path).to eq "/angen-help-gyda" # angen-help-gyda = need-help-with

      expect(page).to have_css(
        "h1",
        text: "Gyda beth y mae angen cymorth arnoch oherwydd y coronafeirws?",
      )

      within "header" do
        click_link "English"
      end

      expect(current_path).to eq "/need-help-with"
      expect(page).to have_css("header .header__components__language", text: "Cymraeg")
      expect(page).to have_css("h1", text: "What do you need help with because of coronavirus?")
    end

    scenario "switch whilst in the journey" do
      visit "/dechrau"
      check "Talu biliau"
      click_on "Parhau"

      expect(current_path).to eq "/fforddio-rhent-morgais-biliau" # afford-rent-mortgage-bills

      expect(page).to have_css(
        "h1",
        text: "Ydych chi’n ei chael yn anodd fforddio’ch rhent, eich morgais neu’ch biliau?",
      )

      within "header" do
        click_link "English"
      end

      # When switching to English, the user is taken back to the start of the journey
      expect(current_path).to eq "/need-help-with"
      expect(page).to have_css("h1", text: "What do you need help with because of coronavirus?")
    end

    scenario "switch whilst on the Cookies page" do
      visit "/cwcis" # cookies

      expect(current_path).to eq "/cwcis"
      expect(page).to have_css("h1", text: "Cwcis")

      within "header" do
        click_link "English"
      end

      expect(current_path).to eq "/cookies"
      expect(page).to have_css("h1", text: "Cookies")
    end

    scenario "switch whilst on the Privacy page" do
      visit "/preifatrwydd"

      expect(current_path).to eq "/preifatrwydd"
      expect(page).to have_css("h1", text: "Hysbysiad preifatrwydd gwefan")

      within "header" do
        click_link "English"
      end

      expect(current_path).to eq "/privacy"
      expect(page).to have_css("h1", text: "Website privacy notice")
    end
  end
end
