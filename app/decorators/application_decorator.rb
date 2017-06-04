class ApplicationDecorator < Draper::Decorator
  include Utilities

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def cmty_prefix
    @cmty_prefix ||= multi_community? ? "#{community.abbrv}: " : ""
  end

  def cmty_prefix_no_colon
    @cmty_prefix_no_colon ||= multi_community? ? "#{community.abbrv} " : ""
  end

  def l(*args)
    return nil if args.first.nil?
    I18n.l(*args)
  end

  # Returns a Proc that inserts the given separator, to be passed to array.reduce.
  def sep(separator)
    ->(a, b){ a << separator.html_safe << b }
  end
end
