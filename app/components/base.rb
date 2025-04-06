# frozen_string_literal: true

class Components::Base < Phlex::HTML
  include Components

  # Include any helpers you want to be available across all components
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::Notice
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::FormWith

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end
end
