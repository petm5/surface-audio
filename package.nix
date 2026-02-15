{
  stdenvNoCC,
  nix-update-script,
  bankstown-lv2,
  lsp-plugins,
  version
}:

stdenvNoCC.mkDerivation {
  pname = "surface-audio";
  inherit version;

  src = ./.;

  makeFlags = [
    "DESTDIR=$(out)"
    "DATA_DIR=share"
  ];

  fixupPhase = ''
    runHook preFixup

    for config_file in $(find $out -type f -not -name '*.wav') ; do
        substituteInPlace "$config_file" --replace-warn "/usr" "$out"
    done

    runHook postFixup
  '';

  passthru = {
    updateScript = nix-update-script { };
    requiredLv2Packages = [ bankstown-lv2 lsp-plugins ];
  };
}
