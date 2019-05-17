module ApplicationHelper
  def available_locales
    hidden = [:zh] # These are base locales we don't want to show
    (I18n.available_locales - hidden)
  end

  def locale_name_pairs
    available_locales.map do |locale|
      [I18n.t(:language, :locale => locale.to_s).to_s, locale.to_s]
    end
  end

  def create_links
    html=""
    locale_name_pairs.each do |link|
      html += content_tag(:li, link_to("#{link.first}", url_for(request.params.merge(:locale => link.last))))
    end
    html.html_safe
  end

  def code2language(code)
    I18n.t(:language, :locale => code)
  end

  def title
    if content_for?(:title)
      I18n.t('appname') + ' | ' + content_for(:title)
    elsif "#{ controller_path.tr('/', '.') }".include?('devise') || ['create','update'].any? {|e| action_name.include? e}
      I18n.t('appname')
    else
      I18n.t('appname') + ' | ' + I18n.t("#{ controller_path.tr('/', '.') }.#{ action_name }.title", default: :site_name)
    end
  end

  def flash_class(level)
    case level
    when :notice then "alert alert-info alert-dismissible fade show"
    when :success then "alert alert-success alert-dismissible fade show"
    when :error then "alert alert-danger alert-dismissible fade show"
    when :alert then "alert alert-warning alert-dismissible fade show"
    end
  end
end
