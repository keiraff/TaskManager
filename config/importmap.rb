# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin_all_from "app/javascript/events", under: "events", preload: true

pin "@popperjs/core", to: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/esm/popper.min.js", preload: true
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js", preload: true
