# frozen_string_literal: true

require "spec_helper"

RSpec.feature "Fill in the form" do
  scenario "Ensure we can perform a healthcheck" do
    visit healthcheck_path

    expect(page).to have_content("OK")
  end

  scenario "Ensure the privacy notice page is visible" do
    visit privacy_path

    expect(page).to have_content(I18n.t("privacy_page.title"))
  end

  scenario "Ensure the accessibility statement page is visible" do
    visit accessibility_statement_path

    expect(page).to have_content(I18n.t("accessibility_statement.title"))
  end

  scenario "Ensure the session expired page is visible" do
    visit session_expired_path

    expect(page).to have_content(I18n.t("session_expired.title"))
  end
end
