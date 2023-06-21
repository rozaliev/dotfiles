{ config, lib, pkgs,  ... }:

with lib;

let
  settingsFormat = pkgs.formats.javaProperties {};
  fasttextModel = builtins.fetchurl {
    url = "https://dl.fbaipublicfiles.com/fasttext/supervised-models/lid.176.bin";
    sha256 = "0kkncb1swi2azh0ci7kq0sfg1mw559wy8jafhk3iq9mwa5afqsby";
  };
  ngrams-en = pkgs.fetchzip {
    url = "https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip";
    sha256 = "sha256-v3Ym6CBJftQCY5FuY6s5ziFvHKAyYD3fTHr99i6N8sE=";
  };

  ngram-env = pkgs.linkFarm "langtool-ngram-env" [
    {
      name = "en";
      path = ngrams-en;
    }
  ];
  
  settings = {
    fasttextBinary = "${pkgs.fasttext}/bin/fasttext";
    fasttextModel = fasttextModel;
    languageModel = ngram-env;
  };
in {
    launchd.user.agents.languagetool = {
      path = [ config.environment.systemPath ];

      serviceConfig = {
        ProgramArguments = [ "${pkgs.languagetool}/bin/languagetool-http-server" ]
          ++ ["--port" "${toString 39393}"]
          ++ ["--public" "false"]
          ++ ["--allow-origin"]
          ++ ["--config" "${settingsFormat.generate "languagetool.conf" settings}"];
        KeepAlive = true;
        ProcessType = "Interactive";
        StandardOutPath = "/tmp/languagetool-http-server.log";
        StandardErrorPath = "/tmp/log/languagetool-http-server.err.log";
      };
    };

}