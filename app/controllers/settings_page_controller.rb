class SettingsPageController < ApplicationController
  def index
    render inertia: "SettingsPage"
  end
end
