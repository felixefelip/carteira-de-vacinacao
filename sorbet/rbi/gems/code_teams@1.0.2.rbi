# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `code_teams` gem.
# Please instead update this file by running `bin/tapioca gem code_teams`.


# source://code_teams//lib/code_teams/plugin.rb#3
module CodeTeams
  class << self
    # source://code_teams//lib/code_teams.rb#20
    sig { returns(T::Array[::CodeTeams::Team]) }
    def all; end

    # Generally, you should not ever need to do this, because once your ruby process loads, cached content should not change.
    # Namely, the YML files that are the source of truth for teams should not change, so we should not need to look at the YMLs again to verify.
    # The primary reason this is helpful is for clients of CodeTeams who want to test their code, and each test context has different set of teams
    #
    # source://code_teams//lib/code_teams.rb#62
    sig { void }
    def bust_caches!; end

    # source://code_teams//lib/code_teams.rb#26
    sig { params(name: ::String).returns(T.nilable(::CodeTeams::Team)) }
    def find(name); end

    # source://code_teams//lib/code_teams.rb#38
    sig { params(dir: ::String).returns(T::Array[::CodeTeams::Team]) }
    def for_directory(dir); end

    # source://code_teams//lib/code_teams.rb#54
    sig { params(string: ::String).returns(::String) }
    def tag_value_for(string); end

    # source://code_teams//lib/code_teams.rb#47
    sig { params(teams: T::Array[::CodeTeams::Team]).returns(T::Array[::String]) }
    def validation_errors(teams); end
  end
end

# source://code_teams//lib/code_teams.rb#15
class CodeTeams::IncorrectPublicApiUsageError < ::StandardError; end

# Plugins allow a client to add validation on custom keys in the team YML.
# For now, only a single plugin is allowed to manage validation on a top-level key.
# In the future we can think of allowing plugins to be gracefully merged with each other.
#
# @abstract It cannot be directly instantiated. Subclasses must implement the `abstract` methods below.
#
# source://code_teams//lib/code_teams/plugin.rb#7
class CodeTeams::Plugin
  abstract!

  # source://code_teams//lib/code_teams/plugin.rb#14
  sig { params(team: ::CodeTeams::Team).void }
  def initialize(team); end

  class << self
    # source://code_teams//lib/code_teams/plugin.rb#24
    sig { returns(T::Array[T.class_of(CodeTeams::Plugin)]) }
    def all_plugins; end

    # source://code_teams//lib/code_teams/plugin.rb#65
    sig { void }
    def bust_caches!; end

    # source://code_teams//lib/code_teams/plugin.rb#70
    sig { void }
    def clear_team_registry!; end

    # source://code_teams//lib/code_teams/plugin.rb#36
    sig { params(team: ::CodeTeams::Team).returns(T.attached_class) }
    def for(team); end

    # source://code_teams//lib/code_teams/plugin.rb#19
    sig { params(base: T.untyped).void }
    def inherited(base); end

    # source://code_teams//lib/code_teams/plugin.rb#41
    sig { params(team: ::CodeTeams::Team, key: ::String).returns(::String) }
    def missing_key_error_message(team, key); end

    # source://code_teams//lib/code_teams/plugin.rb#31
    sig { params(teams: T::Array[::CodeTeams::Team]).returns(T::Array[::String]) }
    def validation_errors(teams); end

    private

    # source://code_teams//lib/code_teams/plugin.rb#53
    sig { params(team: ::CodeTeams::Team).returns(T.attached_class) }
    def register_team(team); end

    # source://code_teams//lib/code_teams/plugin.rb#46
    sig { returns(T::Hash[T.nilable(::String), T::Hash[::Class, ::CodeTeams::Plugin]]) }
    def registry; end
  end
end

# source://code_teams//lib/code_teams/plugins/identity.rb#4
module CodeTeams::Plugins; end

# source://code_teams//lib/code_teams/plugins/identity.rb#5
class CodeTeams::Plugins::Identity < ::CodeTeams::Plugin
  # source://code_teams//lib/code_teams/plugins/identity.rb#12
  sig { returns(::CodeTeams::Plugins::Identity::IdentityStruct) }
  def identity; end

  class << self
    # source://code_teams//lib/code_teams/plugins/identity.rb#19
    sig { override.params(teams: T::Array[::CodeTeams::Team]).returns(T::Array[::String]) }
    def validation_errors(teams); end
  end
end

# source://code_teams//lib/code_teams/plugins/identity.rb#9
class CodeTeams::Plugins::Identity::IdentityStruct < ::Struct
  # Returns the value of attribute name
  #
  # @return [Object] the current value of name
  def name; end

  # Sets the attribute name
  #
  # @param value [Object] the value to set the attribute name to.
  # @return [Object] the newly set value
  def name=(_); end

  class << self
    def [](*_arg0); end
    def inspect; end
    def keyword_init?; end
    def members; end
    def new(*_arg0); end
  end
end

# source://code_teams//lib/code_teams.rb#68
class CodeTeams::Team
  # source://code_teams//lib/code_teams.rb#101
  sig { params(config_yml: T.nilable(::String), raw_hash: T::Hash[T.untyped, T.untyped]).void }
  def initialize(config_yml:, raw_hash:); end

  # source://code_teams//lib/code_teams.rb#117
  sig { params(other: ::Object).returns(T::Boolean) }
  def ==(other); end

  # source://code_teams//lib/code_teams.rb#93
  sig { returns(T.nilable(::String)) }
  def config_yml; end

  # @param other [Object]
  # @return [Boolean]
  #
  # source://sorbet-runtime/0.5.11609/lib/types/private/methods/_methods.rb#257
  def eql?(*args, **_arg1, &blk); end

  # source://code_teams//lib/code_teams.rb#128
  sig { returns(::Integer) }
  def hash; end

  # source://code_teams//lib/code_teams.rb#107
  sig { returns(::String) }
  def name; end

  # source://code_teams//lib/code_teams.rb#90
  sig { returns(T::Hash[T.untyped, T.untyped]) }
  def raw_hash; end

  # source://code_teams//lib/code_teams.rb#112
  sig { returns(::String) }
  def to_tag; end

  class << self
    # source://code_teams//lib/code_teams.rb#82
    sig { params(raw_hash: T::Hash[T.untyped, T.untyped]).returns(::CodeTeams::Team) }
    def from_hash(raw_hash); end

    # source://code_teams//lib/code_teams.rb#72
    sig { params(config_yml: ::String).returns(::CodeTeams::Team) }
    def from_yml(config_yml); end
  end
end

# source://code_teams//lib/code_teams.rb#17
CodeTeams::UNKNOWN_TEAM_STRING = T.let(T.unsafe(nil), String)
