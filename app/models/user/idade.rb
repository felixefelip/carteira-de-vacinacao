class User
  # typed: true
  module Idade
    extend T::Sig
    extend T::Helpers

    abstract!

    sig { overridable.returns(Float) }
    def idade
      return 0.0 if data_nascimento.nil?

      ((Date.current - data_nascimento) / 365).to_f.truncate(2)
    end

    sig { overridable.returns(String) }
    def idade_formatada
      if idade >= 1.2
        "#{idade.to_i} anos"
      elsif idade >= 1
        "#{idade.to_s.last(2)} meses"
      elsif idade >= 0.2
        "#{idade.to_s[2]} meses"
      else
        "#{idade.to_s[2]} mês"
      end
    end

    # No user o tipo é nilable, mas não apontou problema, será um bug?
    sig { abstract.returns(T.nilable(Date)) }
    def data_nascimento; end
  end
end
