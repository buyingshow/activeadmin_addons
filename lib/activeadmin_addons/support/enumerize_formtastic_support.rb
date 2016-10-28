module ActiveAdminAddons
  module RansackFormBuilderExtension
    extend ActiveSupport::Concern

    included do
      prepend(
        Module.new do
          def input(method, options = {})
            if object.is_a?(::Ransack::Search)
              klass = object.klass

              if klass.respond_to?(:enumerized_attributes) && (attr = klass.enumerized_attributes[method])
                options[:collection] ||= attr.options
                options[:as] = :select
              end
            end

            super(method, options)
          end
        end
      )
    end
  end
end

::Formtastic::FormBuilder.send :include, ActiveAdminAddons::RansackFormBuilderExtension
