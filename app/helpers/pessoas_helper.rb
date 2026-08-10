module PessoasHelper
  def avatar_da_pessoa(pessoa, classes: nil)
    if pessoa.foto.attached?
      image_tag pessoa.foto, alt: pessoa.nome, class: class_names('avatar', classes)
    else
      tag.span pessoa.iniciais, class: class_names('avatar', classes), 'aria-hidden': true
    end
  end
end
