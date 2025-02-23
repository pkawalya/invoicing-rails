module ApplicationHelper
  include Pagy::Frontend

  def sort_link_to(name, column, **options)
    if params[:sort] == column.to_s
      direction = params[:direction] == "asc" ? "desc" : "asc"
    else
      direction = "asc"
    end
    link_to name, request.params.merge(sort: column, direction: direction), **options
  end

  def sort_indicator
    case params[:direction]
    when "asc"
      heroicon "chevron-up", variant: :mini
    when "desc"
      heroicon "chevron-down", variant: :mini
    end
  end

  def flash_class(level)
    case level.to_sym
    when :notice
      'bg-indigo-100 border-indigo-200 text-indigo-500'
    when :success
      'bg-emerald-100 border-emerald-200 text-emerald-600'
    when :alert
      'bg-amber-100 border-amber-200 text-amber-600'
    when :error
      'bg-rose-100 border border-rose-200 text-rose-600'
    else
      'bg-indigo-100 border-indigo-200 text-indigo-500'
    end
  end

  def required_field_indicator
    heroicon "star", variant: :mini, options: { class: "h-2 w-2 inline text-rose-500", disable_default_class: true }
  end

  def spanish_regions
    @es_regions = Array.new
    Country.alpha_2_coded("ES").subregions.each { |r| @es_regions << r.subregions }
    @es_regions.flatten.sort
  end
end
