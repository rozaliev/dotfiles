{ config, pkgs, ... }: {

  programs.firefox = {
    enable = true;
    profiles.eugene = {
      name = "My default";
      isDefault = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        facebook-container
        tab-session-manager
        search-by-image
        multi-account-containers
        bitwarden
        enhancer-for-youtube
      ];
      settings = {
        "browser.startup.homepage" = "about:blank";
        "browser.urlbar.placeholderName" = "…";
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.suggest.history" = true;
        "browser.search.suggest.enabled" = false;
        "browser.search.region" = "US";
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.newtabpage.enabled" = false;

        "extensions.pocket.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" =
          false;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" =
          false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" =
          false;

        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.available" = false;
        "services.sync.declinedEngines" = "addons,passwords,prefs";
        "services.sync.engine.addons" = false;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engineStatusChanged.addons" = true;
        "services.sync.engineStatusChanged.prefs" = true;

        "permissions.default.desktop-notification" = 2;

        ## privacy
        "network.prefetch-next" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.http.referer.trimmingPolicy" = 2;
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        "browser.search.send_pings" = "false";
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.cache.offline.enable" = false;

        "dom.events.clipboardevents.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "geo.enabled" = false;
        "dom.battery.enabld" = false;
        "network.dns.disablePrefetch" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/chrome" = [ "firefox.desktop" ];
    "text/html" = [ "firefox.desktop" ];
    "application/x-extension-htm" = [ "firefox.desktop" ];
    "application/x-extension-html" = [ "firefox.desktop" ];
    "application/x-extension-shtml" = [ "firefox.desktop" ];
    "application/xhtml+xml" = [ "firefox.desktop" ];
    "application/x-extension-xhtml" = [ "firefox.desktop" ];
    "application/x-extension-xht" = [ "firefox.desktop" ];
  };
}
