module PessoasHelper
  def avatar_da_pessoa(pessoa, classes: nil)
    if pessoa.avatar.attached?
      image_tag pessoa.avatar, alt: pessoa.nome, class: class_names('avatar', classes)
    else
      tag.span pessoa.iniciais, class: class_names('avatar', classes), 'aria-hidden': true
    end
  end
end
