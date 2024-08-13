# frozen_string_literal: true

module Components
  module TextFieldHelper
    def custom_text_field(form, field, **options)
      options = text_field_default_options(form, field, options)

      tag.div(class: "relative w-full") do
        svg = tag.div(class: "absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none") do
          render "shared/svgs/#{options[:svg]}" if options[:svg]
        end

        input = options[:type] == :textarea ? form.text_area(field, options) : form.text_field(field, options)

        svg + input
      end
    end

    def text_field_default_options(form, field, options)
      object = form.object

      options[:data] = { form_validate_target: "field" }.merge(options[:data] || {})
      options[:class] = [ input_class, options[:class] ].compact.join(" ")

      {
        id: "#{object.model_name.singular}_#{field}",
        label: attribute_model(object, field),
        autocomplete: field
      }.merge(options)
    end
  end
end
