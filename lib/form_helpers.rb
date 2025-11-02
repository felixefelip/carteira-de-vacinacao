# typed: true
require 'sorbet-runtime'

# 1. Model
class User < T::Struct
  const :name, String
  const :email, String
  const :age, Integer
end

# 2. Enum com os campos
class UserField < T::Enum
  enums do
    Name  = new(:name)
    Email = new(:email)
    Age   = new(:age)
  end
end

# 3. FormBuilder genérico
class FormBuilder
  extend T::Sig
  extend T::Generic

  Model = type_member
  FieldEnum = type_member

  sig { params(model: Model).void }
  def initialize(model)
    @model = model
  end

  sig { params(field: FieldEnum).returns(String) }
  def input(field)
    name = field.serialize
    value = @model.send(name)
    "<input name=\"#{name}\" value=\"#{value}\" />"
  end
end

# 4. Método form_for com tipos parametrizados
module FormHelpers
  extend T::Sig

  sig do
    type_parameters(:Model, :FieldEnum)
      .params(
        model: T.type_parameter(:Model),
        enum_class: T.class_of(T::Enum),
        block: T.proc.params(f: FormBuilder[T.type_parameter(:Model), T.type_parameter(:FieldEnum)]).void
      ).void
  end
  def self.form_for(model, enum_class, &block)
    builder = FormBuilder[model.class, enum_class].new(model)
    yield builder
  end
end
