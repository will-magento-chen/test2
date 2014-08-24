class CountryController < ApplicationController
  def subregion_select
    render partial: "shared/subregion_select"
  end
end
