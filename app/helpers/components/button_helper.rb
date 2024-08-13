# frozen_string_literal: true

module Components
  module ButtonHelper
    def submit_button(form, **options)
      options = button_default_options(form, options)
      id = options[:id]
      data = options[:data]

      return tag.button(options[:label], id:, class: options[:class], data:) if form

      tag.link_to("#", class: options[:class], data:) { options[:label] }
    end

    def button_default_options(form, options)
      {
        id: options[:id] || "#{form.object.model_name.singular}_submit_button",
        label: options[:label] || "Button Without A Name",
        type: "button",
        class: form_button_class(colour: colours(options[:colour])),
        data: options[:data] || {}
      }
    end

    def colours(colour)
      case colour

      when nil, :purple
        { text: "text-white", bg: "bg-purple-600", border: "border-gray-300",
          hover: { bg: "hover:bg-indigo-900", text: "" } }
      when :light
        { text: "text-black", bg: "bg-gray-300", border: "border-black",
          hover: { bg: "hover:bg-gray-500", text: "hover:text-gray-50" } }
      when :red
        { text: "text-white", bg: "bg-red-800", border: "border-black",
          hover: { bg: "hover:bg-red-700", text: "hover:text-gray-50" } }
      when :indigo
        { text: "text-white", bg: "bg-indigo-600", border: "border-black",
          hover: { bg: "hover:bg-indigo-700", text: "hover:text-gray-50" } }
      when :orange
        { text: "text-white", bg: "bg-orange-500", border: "rounded-md",
          hover: { bg: "hover:bg-red-700", text: "" } }
      end
    end
  end
end
