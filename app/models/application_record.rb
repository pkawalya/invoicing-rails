class ApplicationRecord < ActiveRecord::Base
  include PgSearch::Model
  primary_abstract_class

  def get_regions
    @regions = []
    if new_record? || country.nil?
      Country.alpha_2_coded('UG').subregions.each { |r| @regions << r.subregions }
    elsif country.count('a-zA-Z') > 2
      Country.named(country)&.subregions&.each { |r| @regions << r.subregions }
      @regions = @regions.reject { |c| c.empty? }
      if @regions.empty?
        @regions = []
        Country.named(country)&.subregions&.each { |r| @regions << r }
      end
    else
      Country.alpha_2_coded(country).subregions.each { |r| @regions << r.subregions }
      @regions = @regions.reject { |c| c.empty? }
      if @regions.empty?
        @regions = []
        Country.alpha_2_coded(country).subregions.each { |r| @regions << r }
      end
    end
    @regions.flatten.sort
  end

  def country_code
    return 'UG' if country.nil?
    return Country.named(country)&.alpha_2_code if country.count('a-zA-Z') > 2

    country
  end
end
