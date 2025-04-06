// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import "@hotwired/turbo-rails"
import Rails from "@rails/ujs";
Rails.start();

import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = true
