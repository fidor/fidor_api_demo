# encoding: utf-8
# Nifty Generators - https://github.com/ryanb/nifty-generators
#
# copy from Nifty Generators,
# markup optimized for bootstrap
#
# Usage:
#    <%= f.error_messages %>
#    <%= error_messages_for(@object) %>
#
module ErrorMessagesHelper
  # Render error messages for the given objects. The :message and :header_message options are allowed.
  def error_messages_for(*objects)
    options = objects.extract_options!
    options[:header_message] ||= I18n.t("errors.template.header", count: objects[0].errors.size, model: objects[0].class.model_name.human)
    options[:message] ||= I18n.t("errors.template.body")
    messages = objects.compact.flat_map { |o| o.errors.full_messages }
    unless messages.empty?
      content_tag(:div, class: "alert alert-danger alert-dismissible alert-form ") do
        list_items = messages.map { |msg| content_tag(:li, msg) }
        content_tag(:a, "&times;".html_safe, href: "#", class: "close", 'data-dismiss': "alert") +
        content_tag(:h4, options[:header_message], class: "h5 mt-1") +
        content_tag(:p, options[:message], class: "mb-0") +
        content_tag(:ul, list_items.join.html_safe, class: "mb-0")
      end
    end
  end

  module FormBuilderAdditions
    def error_messages(options = {})
      @template.error_messages_for(@object, options)
    end
  end
end

ActionView::Helpers::FormBuilder.send(:include, ErrorMessagesHelper::FormBuilderAdditions)
