module User
  # typed: true
  module Idade
    extend T::Sig
    extend T::Helpers

    # 1: `abstract!` instead of `interface!`
    abstract!

    # sig { abstract.returns(T.nilable(Integer)) }
    # def to_count; end

    sig { overridable.returns(Float) }
    def idade
      (Date.current.strftime("%Y%m%d").to_i - data_nascimento.strftime("%Y%m%d").to_i) * 0.001
    end

    sig { overridable.returns(String) }
    def idade_formatada
      "#{idade.to_s.gsub(".", ",")} anos"
    end

    sig { abstract.returns(Date) }
    def data_nascimento; end
  end
end
