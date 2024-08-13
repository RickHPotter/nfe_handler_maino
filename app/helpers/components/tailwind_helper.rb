# frozen_string_literal: true

module Components
  module TailwindHelper
    # @return [String] tailwind class for input.
    #
    def input_class
      "block w-full ps-12 p-2.5 border-1 border-gray-300 focus:ring-1 focus:ring-indigo-600 rounded-md shadow-sm outline-none appearance-none bg-white
    text-[0.8rem] sm:text-sm md:text-base
    text-gray-900".squish
    end

    # @return [String] tailwind class for autosave input.
    #
    def autosave_input_class
      "w-full text-black text-center text-ellipsis text-lg sm:text-xl lg:text-3xl xl:text-4xl 2xl:text-5xl font-extrabold
    border-0 focus:border-0 focus:ring-0 focus:outline-none sm:tracking-tight caret-transparent".squish
    end

    # @return [String] tailwind class for label.
    #
    def label_class
      "block mb-2 text-sm font-medium text-gray-900"
    end

    # @return [String] tailwind class for form button.
    #
    def form_button_class(options)
      "flex w-full py-2 px-4 justify-center transition duration-500 hover:scale-[1.01] rounded-md border
    #{options[:colour][:border]} #{options[:colour][:bg]} text-sm font-graduate font-medium #{options[:colour][:text]}
    shadow-sm #{options[:colour][:hover][:bg]} #{options[:colour][:hover][:text]} focus:outline-none".squish
    end
  end
end
