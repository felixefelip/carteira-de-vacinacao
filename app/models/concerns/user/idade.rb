class User
  module Idade
    extend ActiveSupport::Concern

    included do
      def idade
        (Date.current.strftime("%Y%m%d").to_i - data_nascimento.strftime("%Y%m%d").to_i) * 0.001
      end

      def idade_formatada
        "#{idade.to_s.gsub(".", ",")} anos"
      end
    end
  end
end
