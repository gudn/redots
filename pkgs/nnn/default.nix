{
  atool,
  fuse-archive,
  lib,
  makeWrapper,
  nnn,
  unzip,
  zip,
}:
(nnn.override {
  withPcre = true;
  withNerdIcons = true;
  extraMakeFlags = [
    "O_NOSSN=1"
  ];
}).overrideAttrs
  (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ makeWrapper ];
    postInstall = ''
      ${old.postInstall or ""}
      wrapProgram $out/bin/nnn \
        --prefix PATH : "${
          lib.makeBinPath [
            atool
            zip
            unzip
          ]
        }" \
        --set NNN_ARCHMNT "${fuse-archive}/bin/fuse-archive" \
        --set NNN_OPENER "$out/share/plugins/nuke" \
        --set NNN_BMS "d:~/Downloads;w:~/work" \
        --set NNN_ORDER "T:~/Downloads" \
        --set NNN_OPTS "xzeAEJR"
    '';
  })
