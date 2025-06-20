# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `sprockets-rails` gem.
# Please instead update this file by running `bin/tapioca gem sprockets-rails`.


# source://sprockets-rails//lib/sprockets/railtie.rb#18
module Rails
  class << self
    # source://railties/8.0.0.rc1/lib/rails.rb#44
    def app_class; end

    # source://railties/8.0.0.rc1/lib/rails.rb#44
    def app_class=(_arg0); end

    # source://railties/8.0.0.rc1/lib/rails.rb#45
    def application; end

    # source://railties/8.0.0.rc1/lib/rails.rb#43
    def application=(_arg0); end

    # source://railties/8.0.0.rc1/lib/rails.rb#126
    def autoloaders; end

    # source://railties/8.0.0.rc1/lib/rails.rb#56
    def backtrace_cleaner; end

    # source://railties/8.0.0.rc1/lib/rails.rb#44
    def cache; end

    # source://railties/8.0.0.rc1/lib/rails.rb#44
    def cache=(_arg0); end

    # source://railties/8.0.0.rc1/lib/rails.rb#52
    def configuration; end

    # source://railties/8.0.0.rc1/lib/rails/deprecator.rb#4
    def deprecator; end

    # source://railties/8.0.0.rc1/lib/rails.rb#75
    def env; end

    # source://railties/8.0.0.rc1/lib/rails.rb#82
    def env=(environment); end

    # source://railties/8.0.0.rc1/lib/rails.rb#93
    def error; end

    # source://railties/8.0.0.rc1/lib/rails/gem_version.rb#5
    def gem_version; end

    # source://railties/8.0.0.rc1/lib/rails.rb#106
    def groups(*groups); end

    # source://railties/8.0.0.rc1/lib/rails.rb#49
    def initialize!(*_arg0, **_arg1, &_arg2); end

    # source://railties/8.0.0.rc1/lib/rails.rb#49
    def initialized?(*_arg0, **_arg1, &_arg2); end

    # source://railties/8.0.0.rc1/lib/rails.rb#44
    def logger; end

    # source://railties/8.0.0.rc1/lib/rails.rb#44
    def logger=(_arg0); end

    # source://railties/8.0.0.rc1/lib/rails.rb#122
    def public_path; end

    # source://railties/8.0.0.rc1/lib/rails.rb#65
    def root; end

    # source://railties/8.0.0.rc1/lib/rails/version.rb#7
    def version; end
  end
end

# source://sprockets-rails//lib/sprockets/railtie.rb#19
class Rails::Application < ::Rails::Engine
  # source://railties/8.0.0.rc1/lib/rails/application.rb#109
  def initialize(initial_variable_values = T.unsafe(nil), &block); end

  # Called from asset helpers to alert you if you reference an asset URL that
  # isn't precompiled and hence won't be available in production.
  #
  # @return [Boolean]
  #
  # source://sprockets-rails//lib/sprockets/railtie.rb#38
  def asset_precompiled?(logical_path); end

  # Returns Sprockets::Environment for app config.
  #
  # source://sprockets-rails//lib/sprockets/railtie.rb#31
  def assets; end

  # Returns Sprockets::Environment for app config.
  #
  # source://sprockets-rails//lib/sprockets/railtie.rb#31
  def assets=(_arg0); end

  # Returns Sprockets::Manifest for app config.
  #
  # source://sprockets-rails//lib/sprockets/railtie.rb#34
  def assets_manifest; end

  # Returns Sprockets::Manifest for app config.
  #
  # source://sprockets-rails//lib/sprockets/railtie.rb#34
  def assets_manifest=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#102
  def autoloaders; end

  # source://railties/8.0.0.rc1/lib/rails/engine.rb#516
  def build_middleware_stack; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#451
  def config; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#455
  def config=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#288
  def config_for(name, env: T.unsafe(nil)); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#371
  def console(&blk); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#492
  def credentials; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#456
  def credentials=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#104
  def default_url_options(*_arg0, **_arg1, &_arg2); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#104
  def default_url_options=(arg); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#244
  def deprecators; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#550
  def eager_load!; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#511
  def encrypted(path, key_path: T.unsafe(nil), env_key: T.unsafe(nil)); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#317
  def env_config; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#102
  def executor; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#377
  def generators(&blk); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#524
  def helpers_paths; end

  # source://importmap-rails/2.1.0/lib/importmap/engine.rb#4
  def importmap; end

  # source://importmap-rails/2.1.0/lib/importmap/engine.rb#4
  def importmap=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#438
  def initialize!(group = T.unsafe(nil)); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#134
  def initialized?; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#359
  def initializer(name, opts = T.unsafe(nil), &block); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#445
  def initializers; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#388
  def isolate_namespace(mod); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#172
  def key_generator(secret_key_base = T.unsafe(nil)); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#544
  def load_generators(app = T.unsafe(nil)); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#236
  def message_verifier(verifier_name); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#208
  def message_verifiers; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#540
  def migration_railties; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#141
  def name; end

  # Lazy-load the precompile list so we don't cause asset compilation at app
  # boot time, but ensure we cache the list so we don't recompute it for each
  # request or test case.
  #
  # source://sprockets-rails//lib/sprockets/railtie.rb#52
  def precompiled_assets(clear_cache = T.unsafe(nil)); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#352
  def rake_tasks(&block); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#160
  def reload_routes!; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#164
  def reload_routes_unless_loaded; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#102
  def reloader; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#102
  def reloaders; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#414
  def require_environment!; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#419
  def routes_reloader; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#145
  def run_load_hooks!; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#365
  def runner(&blk); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#100
  def sandbox; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#100
  def sandbox=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#100
  def sandbox?; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#474
  def secret_key_base; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#383
  def server(&blk); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#520
  def to_app; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#426
  def watchable_args; end

  protected

  # source://railties/8.0.0.rc1/lib/rails/application.rb#623
  def default_middleware_stack; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#628
  def ensure_generator_templates_added; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#589
  def ordered_railties; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#611
  def railties_initializers(current); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#578
  def run_console_blocks(app); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#568
  def run_generators_blocks(app); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#573
  def run_runner_blocks(app); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#583
  def run_server_blocks(app); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#557
  def run_tasks_blocks(app); end

  private

  # source://railties/8.0.0.rc1/lib/rails/application.rb#641
  def build_middleware; end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#634
  def build_request(env); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#645
  def coerce_same_site_protection(protection); end

  # source://railties/8.0.0.rc1/lib/rails/application.rb#649
  def filter_parameters; end

  class << self
    # source://railties/8.0.0.rc1/lib/rails/application.rb#407
    def add_lib_to_load_path!(root); end

    # source://railties/8.0.0.rc1/lib/rails/application.rb#84
    def create(initial_variable_values = T.unsafe(nil), &block); end

    # source://railties/8.0.0.rc1/lib/rails/application.rb#88
    def find_root(from); end

    # source://railties/8.0.0.rc1/lib/rails/application.rb#71
    def inherited(base); end

    # source://railties/8.0.0.rc1/lib/rails/application.rb#80
    def instance; end

    def new(*_arg0); end
  end
end

# Hack: We need to remove Rails' built in config.assets so we can
# do our own thing.
#
# source://sprockets-rails//lib/sprockets/railtie.rb#22
class Rails::Application::Configuration < ::Rails::Engine::Configuration
  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#30
  def initialize(*_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def add_autoload_paths_to_load_path; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def add_autoload_paths_to_load_path=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def allow_concurrency; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def allow_concurrency=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#559
  def annotations; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#28
  def api_only; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#374
  def api_only=(value); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def asset_host; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def asset_host=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def assume_ssl; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def assume_ssl=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def autoflush_log; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def autoflush_log=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#469
  def autoload_lib(ignore:); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#481
  def autoload_lib_once(ignore:); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def beginning_of_week; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def beginning_of_week=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#386
  def broadcast_log_level; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def cache_classes; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def cache_classes=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def cache_store; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def cache_store=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#493
  def colorize_logging; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#497
  def colorize_logging=(val); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def consider_all_requests_local; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def consider_all_requests_local=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def console; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def console=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#564
  def content_security_policy(&block); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def content_security_policy_nonce_directives; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def content_security_policy_nonce_directives=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def content_security_policy_nonce_generator; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def content_security_policy_nonce_generator=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def content_security_policy_report_only; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def content_security_policy_report_only=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def credentials; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def credentials=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#432
  def database_configuration; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#388
  def debug_exception_response_format; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#392
  def debug_exception_response_format=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#581
  def default_log_file; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def disable_sandbox; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def disable_sandbox=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def dom_testing_default_html_version; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def dom_testing_default_html_version=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def eager_load; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def eager_load=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#358
  def enable_reloading; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#362
  def enable_reloading=(value); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#28
  def encoding; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#366
  def encoding=(value); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def exceptions_app; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def exceptions_app=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def file_watcher; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def file_watcher=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def filter_parameters; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def filter_parameters=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def filter_redirect; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def filter_redirect=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def force_ssl; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def force_ssl=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def helpers_paths; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def helpers_paths=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def host_authorization; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def host_authorization=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def hosts; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def hosts=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#593
  def inspect; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#414
  def load_database_yaml; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#92
  def load_defaults(target_version); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#28
  def loaded_config_version; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def log_file_size; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def log_file_size=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def log_formatter; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def log_formatter=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#28
  def log_level; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#381
  def log_level=(level); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def log_tags; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def log_tags=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def logger; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def logger=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#394
  def paths; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#573
  def permissions_policy(&block); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def precompile_filter_parameters; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def precompile_filter_parameters=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def public_file_server; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def public_file_server=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def railties_order; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def railties_order=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def rake_eager_load; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def rake_eager_load=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def relative_url_root; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def relative_url_root=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def reload_classes_only_on_change; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def reload_classes_only_on_change=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#354
  def reloading_enabled?; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def require_master_key; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def require_master_key=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def sandbox_by_default; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def sandbox_by_default=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#502
  def secret_key_base; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#512
  def secret_key_base=(new_secret_key_base); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def server_timing; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def server_timing=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def session_options; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def session_options=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#539
  def session_store(new_session_store = T.unsafe(nil), **options); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#555
  def session_store?; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def silence_healthcheck_path; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def silence_healthcheck_path=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def ssl_options; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def ssl_options=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def time_zone; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def time_zone=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def x; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def x=(_arg0); end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def yjit; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#14
  def yjit=(_arg0); end

  private

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#620
  def credentials_defaults; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#630
  def generate_local_secret; end

  # source://railties/8.0.0.rc1/lib/rails/application/configuration.rb#642
  def generate_local_secret?; end
end

# source://sprockets-rails//lib/sprockets/rails/asset_url_processor.rb#1
module Sprockets
  extend ::Sprockets::Utils
  extend ::Sprockets::URIUtils
  extend ::Sprockets::PathUtils
  extend ::Sprockets::DigestUtils
  extend ::Sprockets::PathDigestUtils
  extend ::Sprockets::Dependencies
  extend ::Sprockets::Compressing
  extend ::Sprockets::Exporting
  extend ::Sprockets::Processing
  extend ::Sprockets::HTTPUtils
  extend ::Sprockets::Transformers
  extend ::Sprockets::Mime
  extend ::Sprockets::Paths
end

# source://sprockets-rails//lib/sprockets/rails/asset_url_processor.rb#2
module Sprockets::Rails
  class << self
    # source://sprockets-rails//lib/sprockets/rails/deprecator.rb#7
    def deprecator; end
  end
end

# Resolve assets referenced in CSS `url()` calls and replace them with the digested paths
#
# source://sprockets-rails//lib/sprockets/rails/asset_url_processor.rb#4
class Sprockets::Rails::AssetUrlProcessor
  class << self
    # source://sprockets-rails//lib/sprockets/rails/asset_url_processor.rb#6
    def call(input); end
  end
end

# source://sprockets-rails//lib/sprockets/rails/asset_url_processor.rb#5
Sprockets::Rails::AssetUrlProcessor::REGEX = T.let(T.unsafe(nil), Regexp)

# source://sprockets-rails//lib/sprockets/rails/context.rb#6
module Sprockets::Rails::Context
  include ::ActionView::Helpers::AssetUrlHelper
  include ::ActionView::Helpers::CaptureHelper
  include ::ActionView::Helpers::OutputSafetyHelper
  include ::ActionView::Helpers::TagHelper
  include ::ActionView::Helpers::AssetTagHelper
  include GeneratedInstanceMethods

  mixes_in_class_methods GeneratedClassMethods

  # source://sprockets-rails//lib/sprockets/rails/context.rb#16
  def compute_asset_path(path, options = T.unsafe(nil)); end

  class << self
    # @private
    #
    # source://sprockets-rails//lib/sprockets/rails/context.rb#10
    def included(klass); end
  end

  module GeneratedClassMethods
    def assets_prefix; end
    def assets_prefix=(value); end
    def assets_prefix?; end
    def config; end
    def config=(value); end
    def config?; end
    def digest_assets; end
    def digest_assets=(value); end
    def digest_assets?; end
  end

  module GeneratedInstanceMethods
    def assets_prefix; end
    def assets_prefix=(value); end
    def assets_prefix?; end
    def config; end
    def config=(value); end
    def config?; end
    def digest_assets; end
    def digest_assets=(value); end
    def digest_assets?; end
  end
end

# source://sprockets-rails//lib/sprockets/rails/helper.rb#8
module Sprockets::Rails::Helper
  include ::ActionView::Helpers::AssetUrlHelper
  include ::ActionView::Helpers::CaptureHelper
  include ::ActionView::Helpers::OutputSafetyHelper
  include ::ActionView::Helpers::TagHelper
  include ::ActionView::Helpers::AssetTagHelper
  include ::Sprockets::Rails::Utils
  include GeneratedInstanceMethods

  mixes_in_class_methods GeneratedClassMethods

  # Expand asset path to digested form.
  #
  # path    - String path
  # options - Hash options
  #
  # Returns String path or nil if no asset was found.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#112
  def asset_digest_path(path, options = T.unsafe(nil)); end

  # Experimental: Get integrity for asset path.
  #
  # path    - String path
  # options - Hash options
  #
  # Returns String integrity attribute or nil if no asset was found.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#124
  def asset_integrity(path, options = T.unsafe(nil)); end

  # Writes over the built in ActionView::Helpers::AssetUrlHelper#compute_asset_path
  # to use the asset pipeline.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#77
  def compute_asset_path(path, options = T.unsafe(nil)); end

  # Override javascript tag helper to provide debugging support.
  #
  # Eventually will be deprecated and replaced by source maps.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#135
  def javascript_include_tag(*sources); end

  # Resolve the asset path against the Sprockets manifest or environment.
  # Returns nil if it's an asset we don't know about.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#100
  def resolve_asset_path(path, allow_non_precompiled = T.unsafe(nil)); end

  # Override stylesheet tag helper to provide debugging support.
  #
  # Eventually will be deprecated and replaced by source maps.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#164
  def stylesheet_link_tag(*sources); end

  protected

  # List of resolvers in `config.assets.resolve_with` order.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#249
  def asset_resolver_strategies; end

  # This is awkward: `integrity` is a boolean option indicating whether
  # we want to include or omit the subresource integrity hash, but the
  # options hash is also passed through as literal tag attributes.
  # That means we have to delete the shortcut boolean option so it
  # doesn't bleed into the tag attributes, but also check its value if
  # it's boolean-ish.
  #
  # @return [Boolean]
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#197
  def compute_integrity?(options); end

  # Append ?body=1 if debug is on and we're on old Sprockets.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#257
  def legacy_debug_path(path, debug); end

  # Internal method to support multifile debugging. Will
  # eventually be removed w/ Sprockets 3.x.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#225
  def lookup_debug_asset(path, options = T.unsafe(nil)); end

  # compute_asset_extname is in AV::Helpers::AssetUrlHelper
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#234
  def path_with_extname(path, options); end

  # Enable split asset debugging. Eventually will be deprecated
  # and replaced by source maps in Sprockets 3.x.
  #
  # @return [Boolean]
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#217
  def request_debug_assets?; end

  # Try each asset resolver and return the first non-nil result.
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#240
  def resolve_asset; end

  # Only serve integrity metadata for HTTPS requests:
  #   http://www.w3.org/TR/SRI/#non-secure-contexts-remain-non-secure
  #
  # @return [Boolean]
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#211
  def secure_subresource_integrity_context?; end

  class << self
    # @private
    #
    # source://sprockets-rails//lib/sprockets/rails/helper.rb#60
    def extended(obj); end

    # @private
    #
    # source://sprockets-rails//lib/sprockets/rails/helper.rb#43
    def included(klass); end
  end

  module GeneratedClassMethods
    def assets_environment; end
    def assets_environment=(value); end
    def assets_environment?; end
    def assets_manifest; end
    def assets_manifest=(value); end
    def assets_manifest?; end
    def assets_precompile; end
    def assets_precompile=(value); end
    def assets_precompile?; end
    def assets_prefix; end
    def assets_prefix=(value); end
    def assets_prefix?; end
    def check_precompiled_asset; end
    def check_precompiled_asset=(value); end
    def check_precompiled_asset?; end
    def debug_assets; end
    def debug_assets=(value); end
    def debug_assets?; end
    def digest_assets; end
    def digest_assets=(value); end
    def digest_assets?; end
    def precompiled_asset_checker; end
    def precompiled_asset_checker=(value); end
    def precompiled_asset_checker?; end
    def resolve_assets_with; end
    def resolve_assets_with=(value); end
    def resolve_assets_with?; end
    def unknown_asset_fallback; end
    def unknown_asset_fallback=(value); end
    def unknown_asset_fallback?; end
  end

  module GeneratedInstanceMethods
    def assets_environment; end
    def assets_environment=(value); end
    def assets_environment?; end
    def assets_manifest; end
    def assets_manifest=(value); end
    def assets_manifest?; end
    def assets_precompile; end
    def assets_precompile=(value); end
    def assets_precompile?; end
    def assets_prefix; end
    def assets_prefix=(value); end
    def assets_prefix?; end
    def check_precompiled_asset; end
    def check_precompiled_asset=(value); end
    def check_precompiled_asset?; end
    def debug_assets; end
    def debug_assets=(value); end
    def debug_assets?; end
    def digest_assets; end
    def digest_assets=(value); end
    def digest_assets?; end
    def precompiled_asset_checker; end
    def precompiled_asset_checker=(value); end
    def precompiled_asset_checker?; end
    def resolve_assets_with; end
    def resolve_assets_with=(value); end
    def resolve_assets_with?; end
    def unknown_asset_fallback; end
    def unknown_asset_fallback=(value); end
    def unknown_asset_fallback?; end
  end
end

# source://sprockets-rails//lib/sprockets/rails/helper.rb#9
class Sprockets::Rails::Helper::AssetNotFound < ::StandardError; end

# source://sprockets-rails//lib/sprockets/rails/helper.rb#10
class Sprockets::Rails::Helper::AssetNotPrecompiled < ::StandardError; end

# source://sprockets-rails//lib/sprockets/rails/helper.rb#12
class Sprockets::Rails::Helper::AssetNotPrecompiledError < ::Sprockets::Rails::Helper::AssetNotPrecompiled
  include ::Sprockets::Rails::Utils

  # @return [AssetNotPrecompiledError] a new instance of AssetNotPrecompiledError
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#14
  def initialize(source); end
end

# source://sprockets-rails//lib/sprockets/rails/helper.rb#35
Sprockets::Rails::Helper::VIEW_ACCESSORS = T.let(T.unsafe(nil), Array)

# Use a separate module since Helper is mixed in and we needn't pollute
# the class namespace with our internals.
#
# source://sprockets-rails//lib/sprockets/rails/helper.rb#268
module Sprockets::Rails::HelperAssetResolvers
  class << self
    # source://sprockets-rails//lib/sprockets/rails/helper.rb#269
    def [](name); end
  end
end

# source://sprockets-rails//lib/sprockets/rails/helper.rb#314
class Sprockets::Rails::HelperAssetResolvers::Environment
  # @raise [ArgumentError]
  # @return [Environment] a new instance of Environment
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#315
  def initialize(view); end

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#322
  def asset_path(path, digest, allow_non_precompiled = T.unsafe(nil)); end

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#335
  def digest_path(path, allow_non_precompiled = T.unsafe(nil)); end

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#356
  def find_asset(path, options = T.unsafe(nil)); end

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#346
  def find_debug_asset(path); end

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#342
  def integrity(path); end

  private

  # @return [Boolean]
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#366
  def precompiled?(path); end

  # @raise [Helper::AssetNotPrecompiledError]
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#370
  def raise_unless_precompiled_asset(path); end
end

# source://sprockets-rails//lib/sprockets/rails/helper.rb#280
class Sprockets::Rails::HelperAssetResolvers::Manifest
  # @raise [ArgumentError]
  # @return [Manifest] a new instance of Manifest
  #
  # source://sprockets-rails//lib/sprockets/rails/helper.rb#281
  def initialize(view); end

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#286
  def asset_path(path, digest, allow_non_precompiled = T.unsafe(nil)); end

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#292
  def digest_path(path, allow_non_precompiled = T.unsafe(nil)); end

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#302
  def find_debug_asset(path); end

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#296
  def integrity(path); end

  private

  # source://sprockets-rails//lib/sprockets/rails/helper.rb#307
  def metadata(path); end
end

# source://sprockets-rails//lib/sprockets/rails/quiet_assets.rb#3
class Sprockets::Rails::LoggerSilenceError < ::StandardError; end

# source://sprockets-rails//lib/sprockets/rails/quiet_assets.rb#5
class Sprockets::Rails::QuietAssets
  # @return [QuietAssets] a new instance of QuietAssets
  #
  # source://sprockets-rails//lib/sprockets/rails/quiet_assets.rb#6
  def initialize(app); end

  # source://sprockets-rails//lib/sprockets/rails/quiet_assets.rb#11
  def call(env); end

  private

  # @raise [LoggerSilenceError]
  #
  # source://sprockets-rails//lib/sprockets/rails/quiet_assets.rb#22
  def raise_logger_silence_error; end
end

# source://sprockets-rails//lib/sprockets/rails/route_wrapper.rb#3
module Sprockets::Rails::RouteWrapper
  # @return [Boolean]
  #
  # source://sprockets-rails//lib/sprockets/rails/route_wrapper.rb#8
  def internal?; end

  # @return [Boolean]
  #
  # source://sprockets-rails//lib/sprockets/rails/route_wrapper.rb#4
  def internal_assets_path?; end
end

# Rewrites source mapping urls with the digested paths and protect against semicolon appending with a dummy comment line
#
# source://sprockets-rails//lib/sprockets/rails/sourcemapping_url_processor.rb#4
class Sprockets::Rails::SourcemappingUrlProcessor
  class << self
    # source://sprockets-rails//lib/sprockets/rails/sourcemapping_url_processor.rb#8
    def call(input); end

    private

    # source://sprockets-rails//lib/sprockets/rails/sourcemapping_url_processor.rb#25
    def combine_sourcemap_logical_path(sourcefile:, sourcemap:); end

    # source://sprockets-rails//lib/sprockets/rails/sourcemapping_url_processor.rb#47
    def removed_sourcemap_comment(sourcemap_logical_path, filename:, env:); end

    # source://sprockets-rails//lib/sprockets/rails/sourcemapping_url_processor.rb#33
    def resolved_sourcemap_comment(sourcemap_logical_path, context:); end

    # source://sprockets-rails//lib/sprockets/rails/sourcemapping_url_processor.rb#37
    def sourcemap_asset_path(sourcemap_logical_path, context:); end
  end
end

# source://sprockets-rails//lib/sprockets/rails/sourcemapping_url_processor.rb#5
Sprockets::Rails::SourcemappingUrlProcessor::REGEX = T.let(T.unsafe(nil), Regexp)

# source://sprockets-rails//lib/sprockets/rails/utils.rb#5
module Sprockets::Rails::Utils
  # @return [Boolean]
  #
  # source://sprockets-rails//lib/sprockets/rails/utils.rb#6
  def using_sprockets4?; end
end

# source://sprockets-rails//lib/sprockets/rails/version.rb#3
Sprockets::Rails::VERSION = T.let(T.unsafe(nil), String)

# source://sprockets-rails//lib/sprockets/railtie.rb#60
class Sprockets::Railtie < ::Rails::Railtie
  include ::Sprockets::Rails::Utils

  # source://sprockets-rails//lib/sprockets/railtie.rb#182
  def build_environment(app, initialized = T.unsafe(nil)); end

  class << self
    # source://sprockets-rails//lib/sprockets/railtie.rb#213
    def build_manifest(app); end
  end
end

# source://sprockets-rails//lib/sprockets/railtie.rb#78
Sprockets::Railtie::LOOSE_APP_ASSETS = T.let(T.unsafe(nil), Proc)

# source://sprockets-rails//lib/sprockets/railtie.rb#63
class Sprockets::Railtie::ManifestNeededError < ::StandardError
  # @return [ManifestNeededError] a new instance of ManifestNeededError
  #
  # source://sprockets-rails//lib/sprockets/railtie.rb#64
  def initialize; end
end

# source://sprockets-rails//lib/sprockets/railtie.rb#83
class Sprockets::Railtie::OrderedOptions < ::ActiveSupport::OrderedOptions
  # source://sprockets-rails//lib/sprockets/railtie.rb#84
  def configure(&block); end
end
