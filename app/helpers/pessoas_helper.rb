module PessoasHelper
  def avatar_da_pessoa(pessoa, classes: 'h-10 w-10 text-sm')
    if pessoa.foto.attached?
      image_tag pessoa.foto, alt: pessoa.nome, class: "avatar #{classes}"
    else
      tag.span pessoa.iniciais, class: "avatar #{classes}", 'aria-hidden': true
    end
  end
end
