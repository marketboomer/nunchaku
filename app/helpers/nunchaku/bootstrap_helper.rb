module Nunchaku::BootstrapHelper
  LABEL_STYLES = %w(success warning important info inverse)
  BADGE_STYLES = LABEL_STYLES

  def flash_content
    content_tag(:div, :class => 'flash_contents navbar-fixed-bottom') do
      flash.map do |name, msg|
        content_tag(:div, msg, :class => "#{flash_class(name)} text-center flash")
      end.join.html_safe
    end.html_safe
  end

  def flash_class(name)
    @fc ||= { :notice => :success, :alert => :warning, :error  => :danger }

    "btn-#{ @fc[name.to_sym] || name }"
  end

  def bootstrap_label(string, options={})
    options[:class] = (options[:class] || '').split(' ').unshift('label label-primary').join(' ')
    options[:style] = 'font-size: 1em;'
    content_tag(:span, string, options)
  end

  LABEL_STYLES.each do |style|
    class_eval <<-RUBY_EVAL
      def bootstrap_#{style}_label(*args)
        options = args.extract_options!
        options[:class] = (options[:class] || '').split(' ').unshift('label-#{style}').join(' ')
        bootstrap_label(*args << options)
      end
    RUBY_EVAL
  end

  def bootstrap_badge(string, options={})
    options[:class] = (options[:class] || '').split(' ').unshift('badge').join(' ')
    content_tag(:span, string, options)
  end

  BADGE_STYLES.each do |style|
    class_eval <<-RUBY_EVAL
      def bootstrap_#{style}_badge(*args)
        options = args.extract_options!
        options[:class] = (options[:class] || '').split(' ').unshift('badge-#{style}').join(' ')
        bootstrap_badge(*args << options)
      end
    RUBY_EVAL
  end

  def bootstrap_tab(*args, &block)
    if block_given?
      url, options = *args
    else
      label, url, options = *args
    end

    options ||= {}
    options[:class] = 'active' if current_page?(url_for(url))

    content_tag(:li, options) { link_to(*args, &block) }
  end
end

