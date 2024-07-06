module User
  # typed: true
  module Idade
    extend T::Sig
    extend ActiveSupport::Concern

    included do
      sig { returns(Float) }
      def idade
        (Date.current.strftime("%Y%m%d").to_i - data_nascimento.strftime("%Y%m%d").to_i) * 0.001
      end

      sig { returns(String) }
      def idade_formatada
        "#{idade.to_s.gsub(".", ",")} anos"
      end

      sig { returns(Date) }
      def data_nascimento
        Kernel.raise NotImplementedError
      end
    end
  end
end
