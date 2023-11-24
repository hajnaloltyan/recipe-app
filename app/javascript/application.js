// Import Rails UJS from the importmap
import Rails from "@rails/ujs";
Rails.start();

// Import Turbo from the importmap
import "@hotwired/turbo-rails";

// Import all controllers
import "controllers";
